import os


def Assert(condition, err_msg):
    if not condition:
        raise AssertionError(err_msg)


def MPI_Assert(condition, err_msg, rootdir, err_file):
    if not condition:
        os.chdir(rootdir)
        MPI_Abort(err_msg=err_msg, to_print=True, filename=err_file)
