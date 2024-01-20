import numpy as np
from math import sqrt

# lib
from lib.Matrix import Matrix


class Hamiltonian:
    def __init__(self, capacity, cavity):
        self.cavity = cavity

        self.n = n = cavity.n

        wc = cavity.wc
        wa = cavity.wa
        g = cavity.g

        _min = min(capacity, n)

        self.states = {}

        count = 0

        for i1 in range(0, _min + 1):
            for i2 in range(0, min(n, capacity - i1) + 1):
                self.states[count] = [i1, i2]

                count += 1

        self.size = len(self.states)

        self.matrix = Matrix(self.size, self.size, dtype=np.complex128)

        i = 1

        # построение гамильтониана в базисе из равномерных состояний
        for i1 in range(0, _min + 1):
            for i2 in range(0, min(n, capacity - i1) + 1):
                j = 1

                for j1 in range(0, _min + 1):
                    for j2 in range(0, min(n, capacity - j1) + 1):
                        if i1 != j1:
                            p = [i1, j1]
                        elif i2 != j2:
                            p = [i2, j2]
                        else:
                            p = [1, 2]

                        mi = min(p[0], p[1])

                        kappa = sqrt((n - mi) * (mi + 1))

                        if abs(i1 - j1) + abs(i2 - j2) == 1:
                            _max = max(
                                capacity - i1 - i2,
                                capacity - j1 - j2
                            )
                            self.matrix.data[i - 1, j - 1] = g * \
                                sqrt(
                                    max(
                                        capacity - i1 - i2,
                                        capacity - j1 - j2
                                    )
                            ) * kappa
                        elif abs(i1 - j1) + abs(i2 - j2) == 0:
                            self.matrix.data[i - 1, j - 1] = \
                                (capacity - (i1 + i2)) * wc + \
                                (i1 + i2) * wa
                        else:
                            self.matrix.data[i - 1, j - 1] = 0

                        j += 1

                i += 1
