#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import glob
import os
import re

bibfile = "external.bib"
authors = {}
author_list = []
pages = []
all_auth = []
cites = []
print("Searching for duped bib records...")
with open(bibfile, 'r', encoding="utf8") as biblio:
    for bib_line in biblio:
        if "@" in bib_line and "@comment" not in bib_line.lower():
            if "@" in bib_line.split("{", 1)[0]:
                cite = bib_line.split("{", 1)[1].split(",", 1)[0]
                cleanup = cite.split(' ')
                cite = ""
                for e in cleanup:
                    cite += e
                cites.append(cite)
            for author in author_list:
                if author not in authors:
                    authors[author] = []
                if len(pages) == 0:
                    pages = ['000']
                prev_cite = cites[-2]
                for page in pages:
                    authors[author].append( (page, prev_cite) )
                    authors[author].sort(key=lambda x: x[0])
            author_list = []
            pages = []
            # print("==========")
        bib_line = bib_line.lower()
        if re.match(r'(\s*)author(\s*)=', bib_line):
            authors_expr = bib_line.split("author")[1]
            all_auth = re.split('[{"]', authors_expr, maxsplit=1)[1]
            if "\n" in all_auth:
                all_auth = all_auth[:-1]
            all_auth = all_auth.split(" and ")
            for sub_auth in all_auth:
                sub_sub_auth = re.split('[,. -]', sub_auth)
                for name in sub_sub_auth:
                    cleanup = re.findall(r'\w+', name)
                    name = ""
                    for e in cleanup:
                        name += e
                    if len(name) > 1:
                        if name not in author_list:
                            author_list.append(name)
            # print(author_list)
        if ("pages" in bib_line and "numpages" not in bib_line) or ("article-number" in bib_line) or (
                "isbn" in bib_line):
            pages = re.findall(r'\d+', bib_line)
            # print(pages)
for author in authors:
    author_pages = [p for (p, c) in authors[author]]
    if len(author_pages) != len(set(author_pages)):
        print("\tDuplicated record author:", author)
        prev_page = ""
        prev_cite = ""
        for page, cite in authors[author]:
            if page == prev_page:
                if page == "000":
                    page = "No page"
                print("\t\t with page:", page, ";", cite, "vs", prev_cite)
            prev_page = page
            prev_cite = cite

print("Total cites: ", len(cites))

path = os.getcwd()
path_fig = os.path.join(path, '../Dissertation')
print("Dissertation path: ", path_fig)
os.chdir(path_fig)
files = []
for fname in glob.iglob('*.tex'):
    files.append(fname)
files.sort()
all_text = ""
for filename in files:
    with open(filename, 'r', encoding="utf8") as myfile:
        all_text += myfile.read().replace('\n', '')

path = os.getcwd()
path_fig = os.path.join(path, '../common')
print("common path: ", path_fig)
os.chdir(path_fig)
files = []
for fname in glob.iglob('*.tex'):
    files.append(fname)
files.sort()
for filename in files:
    with open(filename, 'r', encoding="utf8") as myfile:
        all_text += myfile.read().replace('\n', '')

print(len(all_text))
for cite in cites:
    if cite not in all_text:
        print("Cite " + cite + " is not used")
