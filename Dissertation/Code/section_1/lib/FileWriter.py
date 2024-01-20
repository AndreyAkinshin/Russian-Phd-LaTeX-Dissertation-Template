import numpy as np
import pandas as pd


def list_to_csv(outfile, states, header):
    pd.DataFrame(states).to_csv(outfile, header=header, index=False)

def write_x(states, x_csv, ind):
    _k = [int(k) for k in states.keys()]
    _v = [v for v in states.values()]

    for k in _k:
        if states[k] in ind:
            _v[k] = str(states[k])
        else:
            _v[k] = ''

    _x = np.matrix([
        _v,
        _k
    ]).getT()

    list_to_csv(x_csv, _x, ["x", "vals"])


def write_t(T, nt, t_csv, count=10, precision=3):
    _t = np.matrix([
        np.round(np.linspace(0, T, count + 1), precision),
        np.round(np.linspace(0, nt, count + 1), precision)
    ]).getT()

    list_to_csv(t_csv, _t, ["y", "vals"])


def write_axis(max, steps, filename, name, count=10, precision=3):
    _t = np.matrix([
        np.round(np.linspace(0, max, count + 1), precision),
        np.round(np.linspace(0, steps, count + 1), precision)
    ]).getT()

    list_to_csv(filename, _t, [name, "vals"])
