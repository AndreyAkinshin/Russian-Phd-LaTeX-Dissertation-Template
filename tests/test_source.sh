#!/usr/bin/env bash

TMPFILE=$(mktemp -p tests)
INDENT_SETTINGS="indent.yaml"
MAXLINE=$(grep 'max_line_width:' tests/config.yml | grep -o '[[:digit:]]*')
EXITCODE=0

function cleanup {
    rm -f "$TMPFILE"
}
trap cleanup EXIT SIGINT

function test_indent {
    while IFS= read -r -d '' f
    do
	latexindent -l="$INDENT_SETTINGS" "$f" > "$TMPFILE"
	if diff --brief "$f" "$TMPFILE" 1>/dev/null; then
	    echo "File $f is not properly indented" 1>&2
	    EXITCODE=1
	fi
    done < <(find . -not -path "*/\.git/*" \
		  \( -iname "*.tex" \
		  -o -iname "*.tikz" \
		  -o -iname "*.bib" \) -print0)
}

function test_encoding {
    local line
    while IFS= read -r -d '' f
    do
	line=$(file "$f")
	if grep --silent "extended" <<< "$line"; then
	    echo "File $f has non-Unicode encoding" 1>&2
	    EXITCODE=1
	fi
	if grep --silent "CRLF" <<< "$line"; then
	    echo "File $f has CRLF line terminators" 1>&2
	    EXITCODE=1
	fi
    done < <(find . -not -path "*/\.git/*" -type f -print0)
}

function test_line_width {
    while IFS= read -r -d '' f
    do
	if grep --silent --files-with-matches --perl-regexp ".{$MAXLINE,}" "$f"; then
	    echo "File $f lines exceed maximum width" 1>&2
	    EXITCODE=1
	fi
    done < <(find . -not -path "*/\.git/*" \
		  \( -iname "*.md" \
		  -o -iname "*.tex" \
		  -o -iname "*.tikz" \
		  -o -iname "*.bib" \) -print0)
}

function test_examine_logs {
    while IFS= read -r -d '' f
    do
	if grep --silent --files-with-matches --perl-regexp \
		"There were undefined references" "$f"; then
	    echo "File $f undefined references reported" 1>&2
		EXITCODE=1
	fi
	if grep --silent --files-with-matches --perl-regexp \
		"There were multiply-defined labels" "$f"; then
	    echo "File $f multiply defined labels reported" 1>&2
		EXITCODE=1
	fi
    done < <(find . -not -path "*/\.git/*" -iname "*.log" -print0)
}

test_encoding
test_indent
test_line_width
test_examine_logs

exit "$EXITCODE"
