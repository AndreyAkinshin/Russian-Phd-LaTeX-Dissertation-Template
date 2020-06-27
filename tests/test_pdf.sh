#!/usr/bin/env bash

TMPDIR=$(mktemp -d -p tests)
EXITCODE=0
RED='\033[0;31m'
NC='\033[0m'

function cleanup {
    rm -fr "$TMPDIR"
}
trap cleanup EXIT SIGINT

function setup_env {
    virtualenv -p "$(which python3)" "$TMPDIR"
    # shellcheck source=/dev/null
    source "$TMPDIR/bin/activate"
    pip install -r tests/requirements.txt
}

function run_tests {
    while [[ $# -gt 0 ]]
    do
        echo -e "${RED}${1%.pdf}${NC}"
        python -m pytest tests/test_pdf.py -rEs --pdf "$1" --log "${1%.pdf}.log.backup"
        if [[ "$?" -ne 0 ]]; then
            EXITCODE=1
        fi
        shift
    done
}

setup_env
run_tests "$@"

exit "$EXITCODE"
