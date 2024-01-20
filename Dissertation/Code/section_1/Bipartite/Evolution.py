import numpy as np
import scipy.linalg as lg
import csv

# lib
from lib.Assert import Assert, cf
from lib.FileWriter import list_to_csv, write_x, write_t

# Bipartite
from Bipartite.Unitary import Unitary


def run_w(w_0, H, dt, nt, config, fidelity_mode=False):
    U = Unitary(H, dt)
    U_conj = U.conj()

    if fidelity_mode:
        fidelity = []

    w_0 = np.matrix(w_0.data)
    w_t = np.array(w_0.data)

    dt_ = nt / (config.T / config.mks) / 20000 * 1000
    nt_ = int(nt / dt_)

    z_0 = []
    z_1 = []
    z_max = []

    ind_0 = None
    ind_1 = None

    for k, v in H.states.items():
        if v == [0, H.n]:
            ind_0 = k
        elif v == [H.n, 0]:
            ind_1 = k

    # эволюция начального состояния квантовой системы
    with open(config.z_csv, "w") as csv_file:
        writer = csv.writer(
            csv_file, quoting=csv.QUOTE_NONE, lineterminator="\n")

        for t in range(0, nt + 1):
            w_t_arr = w_t.reshape(1, -1)[0]

            diag_abs = np.abs(w_t_arr)**2
            trace_abs = np.sum(diag_abs)

            # проверка нормированности матрицы плотности
            Assert(abs(1 - trace_abs) <= 0.1, "ro is not normed", cf())

            if fidelity_mode:
                w_t = np.matrix(w_t)

                p = w_0.getH().dot(w_t).reshape(-1)[0, 0]

                fidelity_t = round(abs(p), 3)
                fidelity_t = "{:>.5f}".format(fidelity_t)

                fidelity.append(fidelity_t)

            z_0.append("{:.5f}".format(diag_abs[ind_0]))
            z_1.append("{:.5f}".format(diag_abs[ind_1]))

            zmax = 0

            for i in range(0, len(diag_abs)):
                if i != ind_0 and i != ind_1 and diag_abs[i] > zmax:
                    zmax = diag_abs[i]

            z_max.append(zmax)

            writer.writerow(["{:.5f}".format(x) for x in diag_abs])

            w_t = np.array(U.data.dot(w_t))

    states = H.states

    write_x(states, config.x_csv, ind=[[0, H.n], [H.n, 0]])
    write_t(t_for_plot(config.T), config.nt, config.y_csv)

    if fidelity_mode:
        list_to_csv(config.fid_csv, fidelity, header=["fidelity"])

    list_to_csv(config.path + 'z_max.csv', z_max, header=["fidelity"])
    list_to_csv(config.path + 'z_0.csv', z_0, header=["fidelity"])
    list_to_csv(config.path + 'z_1.csv', z_1, header=["fidelity"])


def t_for_plot(T):
    if T >= 1e-3:
        T_str = round(T * 1e3, 3)
    elif T >= 1e-6:
        T_str = round(T * 1e6, 3)
    elif T >= 1e-9:
        T_str = round(T * 1e9, 3)
    else:
        T_str = round(T, 3)
    return T_str
