import builtins as __builtin__
from termcolor import cprint as colored_print
import functools

print = functools.partial(print, flush=True)


def hr(count=100):
    print('-' * count)


__builtin__.Print = __builtin__.print


def print(*args, **kwargs):
    if 'prefix' in kwargs.keys():
        __builtin__.Print(kwargs['prefix'], end='')
        del kwargs['prefix']

    if 'color' in kwargs.keys():
        colored_print(*args, **kwargs)
    else:
        __builtin__.Print(*args, **kwargs)
