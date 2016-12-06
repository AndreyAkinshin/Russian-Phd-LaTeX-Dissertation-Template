#!/bin/bash
var="synopsis.pdf"
file=${var%".pdf"}
echo ${file}_booklet.pdf
pdftops $file.pdf - | psbook | psnup -s1 -2 | ps2pdf - ${file}_booklet.pdf


