#!/usr/bin/env -S gawk -f

BEGIN {FS="\t"} {
}

// {
    gsub(/\(/, "\\(", $2)
    gsub(/\)/, "\\)", $2)
    system("luatex -jobname " NR " " \
	   "\\\\def\\\\toindex{" $1 "}" \
	   "\\\\def\\\\\\tocity{" $2 "}" \
	   "\\\\def\\\\\\toaddress{" $3 "}" \
	   "\\\\def\\\\\\toinstitution{" $4 "}" \
	   "\\\\def\\\\\\towhom{" $5 "}" \
	   "\\\\input{letters.tex}")
}

END {
    system("rm -f letters.pdf")
    system("pdftk *.pdf cat output letters.pdf.backup")
    system("rm -f *.log *.pdf")
    system("mv letters.pdf.backup letters.pdf")
}
