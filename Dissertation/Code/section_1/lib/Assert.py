from inspect import currentframe as cf
from inspect import getframeinfo

frameinfo = getframeinfo(cf())


def Assert(condition, error, cf):
    if not condition:
        print_error(error, cf)
        exit(1)

def print_error(err_msg, cf):
    filename = getframeinfo(cf).filename

    print("\033[1;31;1mError:\033[1;32;0m", end=" ")
    print(err_msg, end="\n\n")

    print("\033[1;33;1mFile:\033[1;32;0m", end=" ")
    print("\"", filename, "\"", sep="")

    print("\033[1;33;1mLine:\033[1;32;0m", end=" ")
    print(cf.f_lineno)

    print()

    return
