#!/usr/bin/env bash

TMPDIR=$(mktemp -d -p tests)
EXITCODE=0

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
        python -m pytest tests/test_pdf.py --pdf "$1"
        EXITCODE="$?"
        shift
    done
}

setup_env
run_tests "$@"

exit "$EXITCODE"
