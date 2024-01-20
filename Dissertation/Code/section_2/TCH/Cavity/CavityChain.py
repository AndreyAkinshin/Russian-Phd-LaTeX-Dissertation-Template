# TCH
from TCH.Cavity.Cavity import *

# lib
from lib.ParseJumps import *


class CavityChain:
    def __init__(self, cavities, capacity):
        self.__capacity = parse_jumps(capacity)

        self.__cavities = {}

        self.__n_cavities = 0

        for i in range(len(cavities)):
            self.__cavities[i] = cavities[i]
            self.__n_cavities += 1

        self.__connections = {}

    def n_cavities(self):
        return self.__n_cavities

    def connect(self, cavity_id1, cavity_id2, amplitude, ph_type):
        cvs = sorted([cavity_id1, cavity_id2])

        self.__connections[str(cvs[0]) + '<->' + str(cvs[1])] = {
            'amplitude': amplitude,
            'cavity_ids': cvs,
            'ph_type': ph_type,
        }

    def disconnect(self, cavity_id1, cavity_id2, ph_type=None):
        cvs = sorted([cavity_id1, cavity_id2])

        to_delete = []

        if ph_type is None:
            for conn_i, conn in self.__connections.items():
                if cvs == conn['cavity_ids']:
                    to_delete.append(conn_i)
        else:
            for conn_i, conn in self.__connections.items():
                if conn['ph_type'] == ph_type and cvs == conn['cavity_ids']:
                    to_delete.append(conn_i)
                    break

        Assert(len(to_delete) != 0, 'len(to_delete) == 0')

        for v in to_delete:
            del self.__connections[v]

    def try_jump_cv(self):
        ans = []

        n_cavities = self.n_cavities()

        cv_states = []

        for cv_k, cv_v in self.cavities().items():
            cv_states.append(self.cavity(cv_k).as_array())

        for cv_k, cv_v in self.cavities().items():
            state = self.get_state()

            photons = state[cv_k][0]
            atoms = state[cv_k][1]

            wc = cv_v.wc()
            can_jump = cv_v.try_jump()

            for jmp in can_jump:
                ans_ = ''

                for _ in range(cv_k):
                    ans_ += cv_states[_]
                ans_ += jmp['newcode']

                for _ in range(cv_k + 1, self.__n_cavities):
                    ans_ += cv_states[_]

                ans_i = {
                    'newcode': ans_,
                    'cavity': cv_k,
                    'amplitude': jmp['amplitude'],

                }

                for param in 'ph', 'atom_i', 'atom_lvl', 'sink_i', 'sink_lvl', 'sink_type':
                    if param in jmp:
                        ans_i[param] = jmp[param]

                ans.append(ans_i)
        return ans

    def make_jump(self, cv_from, cv_to, ph_type):
        self.cavity(cv_from).remove_photon(type=ph_type)
        self.cavity(cv_to).add_photon(type=ph_type)

    def capacity(self):
        return self.__capacity

    def cavities(self):
        return self.__cavities

    def cavity(self, cavity_id):
        return self.__cavities[cavity_id]

    def connections(self):
        return self.__connections

    def get_state(self):
        state = ()

        for cv_k, cv_v in self.__cavities.items():
            state += (cv_v.get_state(),)

        return state
