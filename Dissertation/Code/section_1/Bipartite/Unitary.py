import numpy as np
import scipy.linalg as lg

# lib
from lib.Assert import Assert, cf
from lib.Matrix import Matrix

# Bipartite
from Bipartite.Hamiltonian import Hamiltonian


class Unitary(Matrix):
    def __init__(self, H, dt):
        Assert(isinstance(H, Hamiltonian), "H is not Hamiltonian", cf())
        Assert(isinstance(dt, (int, float)), "dt is not numeric", cf())
        Assert(dt > 0, "dt <= 0", cf())

        super(Unitary, self).__init__(
            m=H.size, n=H.size,
            dtype=np.complex128
        )

        H_data = np.array(H.matrix.data, dtype=np.complex128)

        # оператор эволюции U = exp(-i * H * dt)
        self.data = np.matrix(
            lg.expm(-1j * H_data * dt),
            dtype=np.complex128
        )
