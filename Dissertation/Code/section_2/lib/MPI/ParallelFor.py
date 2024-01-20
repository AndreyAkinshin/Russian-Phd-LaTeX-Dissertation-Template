import os

# lib
from lib.MkDir import mkdir
from lib.MPI.MPI import MPI_Comm_rank


# параллельное выполнение функции 'func'
# каждым процессом с выводом соответствующего
# результата в директорию 'path'
def parallel_for(func, path, prefix, var=None):
    pwd = os.getcwd()

    # ранг процесса
    mpirank = MPI_Comm_rank()

    # выходная директория
    path_i = str(path) + '/node_' + str(mpirank) + '/'

    mkdir(path_i)
    os.chdir(path_i)

    # параллельное выполнение функции:
    # списковый диапазон значений переменной
    # 'var' распределится между процессами
    func(var)

    os.chdir(pwd)
