import numpy as np
from scipy.sparse import csc_matrix

# TCH
from TCH.Cavity.Atom import Atom
from TCH.Cavity.Cavity import Cavity
from TCH.Cavity.CavityChain import CavityChain
from TCH.DensityMatrix import DensityMatrix
from TCH.QuantumSystem import QuantumSystem
from TCH.Unitary import Unitary
from TCH.WaveFunction import WaveFunction

# lib
from lib.LoadPackage import load_pkg
from lib.MkDir import mkdir
from lib.MPI.MPI import *
from lib.MPI.ParallelFor import parallel_for
from lib.Matrix import Matrix
from lib.Pickle import pickle_dump


if len(sys.argv) < 2:
    print('Usage: python3 main.py <config.py>')
    exit(1)

config_path = sys.argv[1]
if not os.path.isfile(config_path):
    print('File <', config_path, '> does not exist', sep='')
    exit(1)

config = load_pkg("config", config_path)

# директория с выходными данными, необходимыми
# для построения графика квантового бутылочного горлышка
outpath = 'out'

# ранг процесса
mpirank = MPI_Comm_rank()

if mpirank == 0:
    mkdir(outpath)


def operator_L(ro, lindblad):
    # функция, вычисляющая слагаемое
    # l * (L * ro * L^{+} - 1/2 * {L^{+} * L, ro})
    # основного квантового уравнения

    # L - оператор Линдблада
    L = lindblad['L']
    Lcross = L.conj()
    LcrossL = Lcross.data.dot(L.data)

    # l - соответствующая интенсивность линдбладовского процесса
    l = lindblad['l']

    def Lindblad(ro):
        nonlocal L, Lcross, LcrossL, l

        L1 = (L.data.dot(ro.data)).dot(Lcross.data)
        L1 = csc_matrix(L1)

        L2 = np.dot(ro.data, LcrossL) + np.dot(LcrossL, ro.data)
        L2 = csc_matrix(L2)

        return l * (L1 - 0.5 * L2)

    return Lindblad


# оператор Линдблада, реализующий утечку фотона в сток
a = [
    # $|0\rangle|-\rangle|0\rangle|+\rangle$   $|0\rangle|0\rangle|1\rangle|-\rangle$    $|0\rangle|1\rangle|0\rangle|-\rangle$    $|1\rangle|0\rangle|0\rangle|-\rangle$
    [    0,         0,          0,          0    ],  # $|0\rangle|-\rangle|0\rangle|+\rangle$
    [    0,         0,          0,          1    ],  # $|0\rangle|0\rangle|1\rangle|-\rangle$
    [    0,         0,          0,          0    ],  # $|0\rangle|1\rangle|0\rangle|-\rangle$
    [    0,         0,          0,          0    ],  # $|1\rangle|0\rangle|0\rangle|-\rangle$
]
a = csc_matrix(a, dtype=np.complex128)
a = Matrix(m=np.shape(a)[0], n=np.shape(a)[0], dtype=np.complex128, data=a)

# оператор Линдблада, реализующий превращение атома
A = [
    # $|0\rangle|-\rangle|0\rangle|+\rangle$   $|0\rangle|0\rangle|1\rangle|-\rangle$    $|0\rangle|1\rangle|0\rangle|-\rangle$    $|1\rangle|0\rangle|0\rangle|-\rangle$
    [    0,         0,          1,          0    ],  # $|0\rangle|-\rangle|0\rangle|+\rangle$
    [    0,         0,          0,          0    ],  # $|0\rangle|0\rangle|1\rangle|-\rangle$
    [    0,         0,          0,          0    ],  # $|0\rangle|1\rangle|0\rangle|-\rangle$
    [    0,         0,          0,          0    ],  # $|1\rangle|0\rangle|0\rangle|-\rangle$
]
A = csc_matrix(A, dtype=np.complex128)
A = Matrix(m=np.shape(A)[0], n=np.shape(A)[0], dtype=np.complex128, data=A)

atom = Atom(
    wa={'1': wc},
    g={'0<->1': config.g}
)

cavity = Cavity(
    wc={'0<->1': config.wc},
    atoms=[atom],
    sink=[
        {
            'capacity': 1,
            'type': 'photon',
            'lvl': 0,
        },
        {
            'capacity': 1,
            'type': 'atom',
            'lvl': 0,
        }
    ]
)
cavity.add_photon(type='0<->1')

cv_chain = CavityChain(capacity={'0 <-> 1': 1}, cavities=[cavity])

# здесь происходит построение базиса квантовой системы
qs = QuantumSystem(cavity_chain=cv_chain)

# построение гамильтониана
H = qs.H()

# оператор эволюции
U = Unitary(H=H, dt=config.dt)

U_conj = U.conj()

base_states = H.base_states()

w0 = WaveFunction(
    states=H.base_states(),
    init_state=base_states[2].state()
)
ro_0 = DensityMatrix(w0)

sink_a_list = []


def node_func(var):
    # параллельное моделирование неунитарной динамики
    # квантовой системы каждым процессом для своего диапазона
    # значений интенсивности линдбладовского процесса
    l_a_range = n_batches(var)

    sink_A_list = []

    for l_a_coeff in l_a_range:
        ro_t = deepcopy(ro_0)

        L_out_A = operator_L(ro_t, {
            'L': A,
            'l': config.lA_0
        })
        L_out_a = operator_L(ro_t, {
            'L': a,
            'l': config.la_0 * l_a_coeff
        })

        sink_A_tmp = []

        t = 0

        while t <= config.time_limit:
            diag_abs = ro_t.diag_abs()

            trace = ro_t.abs_trace()

            # проверка нормированности матрицы плотности
            Assert(abs(1 - trace) <= config.ro_err, 'ro is not normed')

            sink_A = diag_abs[0]
            sink_A_tmp.append(sink_A)

            ro_t.evolve(
                U=U,
                U_conj=U_conj,
                dt=config.dt,
                L=L_out_a(ro_t) + L_out_A(ro_t),
            )

            t += config.dt

        # состояние стока в различные периоды времени
        sink_A_list.append(sink_A_tmp)

    # вывод результата каждым процессом
    pickle_dump(sink_A_list, 'sink_A.pkl')

    # объединение выходных файлов со всех процессов,
    # необходимое для дальнейшего построения графика
    gather_file('out', 'sink_A.pkl')


parallel_for(func=node_func, path='out', prefix='l_', var=config.l_a_range)

if mpirank == 0:
    t_list = []

    t = 0

    while t <= config.time_limit:
        t_list.append(t)
        t += config.dt

    pickle_dump(t_list, outpath + '/' + 't.pkl')
    pickle_dump(config.l_a_range, outpath + '/' + 'l_a_range.pkl')
