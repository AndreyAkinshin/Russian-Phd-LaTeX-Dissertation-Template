import numpy as np
import scipy.sparse.linalg as lg
from scipy.sparse import csc_matrix

# lib
from lib.Matrix import Matrix


class Unitary(Matrix):
    def __init__(self, H, dt):
        Assert(isinstance(dt, (int, float)), "dt is not numeric")
        Assert(dt > 0, "dt <= 0")

        # оператор эволюции U = exp(-i * H * dt)
        data = lg.expm(-1j * csc_matrix(H.data) * dt)
        data = csc_matrix(data, dtype=np.complex128)

        super(Unitary, self).__init__(
            m=H.size, n=H.size,
            dtype=np.complex128, data=data
        )

        self.check_unitarity()
