from shutil import copyfile
import plotly.express as px
import pandas as pd
import sys
import os

# lib
from lib.LoadPackage import load_pkg
from lib.PyPlot import PyPlot3D

# Bipartite
from Bipartite.Cavity import Cavity
from Bipartite.Evolution import run_w
from Bipartite.Hamiltonian import Hamiltonian
from Bipartite.WaveFunction import WaveFunction


# подгрузка конфига квантовой системы
config = load_pkg("config", "config.py")

if not os.path.exists(config.path):
    os.makedirs(config.path)

copyfile("config.py", config.path + '/config.py')

# объект полости
cavity = Cavity(n=config.n, wc=config.wc, wa=config.wa, g=config.g)

# построение гамильтониана
H = Hamiltonian(capacity=config.capacity, cavity=cavity)

# начальное состояние квантовой системы
w_0 = WaveFunction(states=H.states, init_state=config.init_state)
w_0.normalize()

# эволюция начального состояния квантовой системы
run_w(
    w_0,
    H,
    dt=config.dt,
    nt=config.nt,
    config=config,
    fidelity_mode=True
)

y_scale = 1

if config.T <= 0.25 * config.mks:
    y_scale = 0.1
elif config.T <= 0.5 * config.mks:
    y_scale = 0.1
elif config.T == 0.5 * config.mks:
    y_scale = 0.01
elif config.T == 1 * config.mks:
    y_scale = 7.5
elif config.T == 5 * config.mks:
    y_scale = 1


def time_with_units(T):
    if T >= 1e-3:
        T_str = " ms"
    elif T >= 1e-6:
        T_str = " mks"
    elif T >= 1e-9:
        T_str = " ns"

    return T_str


# построение графика ансамблевых осцилляций
PyPlot3D(
    x_csv=config.path + "/" + "x.csv",
    y_csv=config.path + "/" + "t.csv",
    z_csv=config.path + "/" + "z.csv",
    x_axis="states",
    y_axis="time, " + time_with_units(config.T),
    y_scale=y_scale,
    path=config.path,
    filename="Bipartite"
)


def plot_fidelity(filename=config.fid_csv):
    z_data = pd.read_csv(filename)

    fig = px.line(z_data["fidelity"])

    fig.update_layout(
        title="Fidelity",
        xaxis_title='Time, ' + time_with_units(config.T),
        yaxis_title="Fidelity",
        showlegend=False,
        font=dict(size=16)
    )

    fig.show()


# построение графика fidelity
plot_fidelity(config.fid_csv)
