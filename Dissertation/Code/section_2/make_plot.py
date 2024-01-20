import os
import sys

import numpy as np

# lib
from lib.Pickle import pickle_load
from lib.PlotBuilder3D import PlotBuilderData3D


if len(sys.argv) < 2:
    print('Usage: python3 make_plot.py <path>')
    exit(1)

path = sys.argv[1]
if not os.path.isdir(path):
    print('directory <', path, '> not exist', sep='')
    exit(1)

x_data = pickle_load(path + '/' + 't.pkl')
y_data = pickle_load(path + '/' + 'l_a_range.pkl')
z_data = pickle_load(path + '/' + 'sink_A.pkl')

x_data = np.array(x_data, dtype=float)
y_data = np.array(y_data, dtype=float)

for i in range(len(z_data)):
    z_data[i] = np.array(np.round(z_data[i], 3), dtype=float)

plot_builder = PlotBuilderData3D({
    'title': '',
    'width': 1000,
    'height': 700,
    'x': {
        'title': 't, mks',
        'data': x_data,
        'ticktext': x_data,
        'range': [0, max(x_data)],
        'tick0': 0,
        'dtick': 200,
        'nticks': 5,
        'scale': 1
    },
    'y': {
        'title': 'gamma<sub>ph_out</sub>/gamma<sub>ex</sub>',
        'data': y_data,
        'ticktext': y_data,
        'range': [0, max(y_data)],
        'tick0': 0,
        'dtick': 0.1,
        'nticks': 5,
        'scale': 1
    },
    'z': {
        'data': z_data,
        'title': 'P',
        'range': [0, 1],
        'scale': 1
    },
    'ticks': {
        'title': { 'size': 20 },
        'family': 'Lato',
        'color': '#222',
        'size': 14
    },
    'html': '3d.html',
    'to_file': False,
    'showlegend': False
})

plot_builder.make_plot()
