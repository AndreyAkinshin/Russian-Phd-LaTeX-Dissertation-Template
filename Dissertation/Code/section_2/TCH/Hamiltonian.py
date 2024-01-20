import numpy as np
from scipy.sparse import lil_matrix

# lib
from lib.Matrix import Matrix


class Hamiltonian(Matrix):
    def __init__(self, base_states, cavity_chain):
        self.__basis = base_states
        self.__base_states = base_states.states

        self.size = len(self.__base_states)
        self.cavity_chain = cavity_chain
        self.cavities = cavity_chain.cavities()

        # компоненты "поле" и "атомы"
        H0 = self.H0(base_states)

        # компонента атомно-полевого взаимодействия
        HI = self.HI(base_states)

        self.H = H0 + HI

        self.data = self.H.data

        # максимальное количество возбуждений в системе
        self.capacity = cavity_chain.capacity

    # базисные состояния гамильтониана
    def base_states(self):
        return self.__base_states

    # заполнение компоненты H0 матрицы гамильтониана
    def H0(self, cavity_chain):
        H0 = lil_matrix((self.size, self.size))

        cavities = self.cavities

        for k, v in self.__base_states.items():
            id_from = k

            H0[k, k] = 0

            for cv_i, cv in enumerate(v.state()):
                photons = cv[0]
                atoms = cv[1]

                wc = cavities[cv_i].wc()

                for ph_type, ph_count in photons.items():
                    H0[k, k] += wc[ph_type]['value'] * ph_count

                for i, atom_lvl in enumerate(atoms):
                    if atom_lvl == 0:
                        continue

                    wa = cavities[0].atom(i).wa(atom_lvl)
                    H0[k, k] += wa * atom_lvl

        return Matrix(m=self.size, n=self.size, dtype=np.float64, data=H0)

    # заполнение компоненты HI матрицы гамильтониана
    def HI(self, cavity_chain):
        HI = lil_matrix((self.size, self.size))

        base_states = self.__base_states

        for key_from, v in base_states.items():
            for conn in v.jumps():
                other_id = conn['state'].id()

                key_to = self.__basis.key_by_id(other_id)

                amplitude = conn['amplitude']

                HI[key_from, key_to] = amplitude['value']

        return Matrix(m=self.size, n=self.size, dtype=np.float64, data=HI)
