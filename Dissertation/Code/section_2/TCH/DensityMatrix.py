import numpy as np
from scipy.sparse import lil_matrix

# lib
from lib.Assert import Assert
from lib.Matrix import Matrix

# TCH
from TCH.WaveFunction import WaveFunction


class DensityMatrix(Matrix):
    def __init__(self, wf):
        Assert(isinstance(wf, WaveFunction), "wf is not WaveFunction")

        wf_data = wf.data

        # вычисление матрицы плотности
        ro_data = wf_data.dot(wf_data.getH())

        self.states = wf.states
        self.size = np.shape(ro_data)[0]

        super(DensityMatrix, self).__init__(
            m=self.size, n=self.size,
            dtype=np.complex128,
            data=ro_data
        )

    def evolve(self, U, U_conj, dt, L):
        # неунитарная динамика: ro(t + dt) = U * (ro + L * dt) * U^{+}
        self.data = (U.data.dot(self.data + dt * L)).dot(U_conj.data)

    def diag_abs(self):
        # получение диагонали матрицы плотности
        return np.abs(self.data.diagonal(), dtype=np.longdouble)
