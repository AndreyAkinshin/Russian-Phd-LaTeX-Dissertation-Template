import os


def mkdir(dirname):
    if not os.path.exists(dirname):
        os.makedirs(dirname)
