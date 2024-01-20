# utils
from utils.flat_list import flat_list

import copy
import numpy as np


class State:
    @staticmethod
    def array_notation(raw_notation):
        return flat_list(raw_notation)

    @staticmethod
    def string_notation(raw_notation):
        return ''.join(map(str, State.array_notation(raw_notation)))

    @staticmethod
    def flat_list2(nestedList):
        atoms_flag = False
        tensor_flag = False

        s = ''
        flatList = []

        for elem in nestedList:
            if isinstance(elem, list):
                if atoms_flag:
                    s += '|'
                s += State.flat_list2(elem)

                if atoms_flag:
                    s += '〉'

                atoms_flag = False
                tensor_flag = True

            elif isinstance(elem, dict):
                s += '|'

                for v in elem.values():
                    s += str(v)
                s += '〉'

                atoms_flag = True

            else:
                s += str(elem)

        return s

    __ID = 0

    BASE_STATES = {}

    def __init__(self, cavity_chain):
        self.set_id()

        self.__cavity_chain = copy.deepcopy(cavity_chain)
        self.__capacity = self.__cavity_chain.capacity()
        self.__cavities = self.__cavity_chain.cavities()
        self.__n_cavities = len(self.__cavities)

        self.__state = cavity_chain.get_state()

        self.__array = flat_list(self.__state)
        self.__string = State.string_notation(self.__state)

        self.__braket = State.flat_list2(self.__state)

        self.__jumps = []

        self.__amplitudes = {}

    def set_id(self):
        self.__id = State.__ID
        State.__ID += 1

    def state(self):
        return self.__cavity_chain.get_state()

    def id(self):
        return self.__id

    def cavity(self, cavity_id):
        return self.__cavities[cavity_id]

    def cavity_chain(self):
        return self.__cavity_chain

    def n_cavities(self):
        return self.__n_cavities

    def jumps(self):
        return self.__jumps

    def get_state(self):
        self.update_notation()
        return self.__state
    # -----------------------------------------------------------------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------

    def delete_conn(self):
        self.__jumps = []

    def try_jump(self, cv_from, cv_to, ph_type):
        if self.cavity(cv_from).photons(ph_type) > 0 and self.cavity(cv_to).photons(ph_type) + 1 <= self.__capacity[ph_type]['value']:
            state = self.state()

            state[cv_from][0][ph_type] -= 1
            state[cv_to][0][ph_type] += 1

            newcode = State.string_notation(state)

            return {
                'cv_from': cv_from,
                'cv_to': cv_to,
                'newcode': newcode,
            }
        elif self.cavity(cv_to).photons(ph_type) > 0 and self.cavity(cv_from).photons(ph_type) + 1 <= self.__capacity[ph_type]['value']:
            state = self.state()

            state[cv_to][0][ph_type] -= 1
            state[cv_from][0][ph_type] += 1

            newcode = State.string_notation(state)

            return {
                'cv_from': cv_to,
                'cv_to': cv_from,
                'newcode': newcode
            }

        return None

    def connect(self, state, amplitude):
        self.__jumps.append({'state': state, 'amplitude': amplitude})
        state.__jumps.append({'state': self, 'amplitude': amplitude})

    def as_string(self):
        return self.__string

    def as_braket(self):
        return self.__braket

    def as_array(self):
        return self.__array

    def update_notation(self):
        self.__state = self.__cavity_chain.get_state()

        self.__array = flat_list(self.__state)
        self.__string = State.string_notation(self.__state)
        self.__braket = State.flat_list2(self.__state)

    def set_amplitudes(self, k):
        for k_ in range(k):
            self.__amplitudes[k_] = 0j

    def __mul__(self, coeff):
        for k in self.amplitude.keys():
            self.amplitude[k] *= coeff

        return self

    def make_jump(self, cv_from, cv_to, ph_type):
        self.__cavity_chain.make_jump(cv_from, cv_to, ph_type)
