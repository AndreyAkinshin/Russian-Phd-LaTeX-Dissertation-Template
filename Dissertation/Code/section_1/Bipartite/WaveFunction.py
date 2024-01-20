import numpy as np

# lib
from lib.Assert import Assert, cf
from lib.Matrix import Matrix


class WaveFunction(Matrix):
    def __init__(self, states, init_state, amplitude=1):
        Assert(isinstance(states, dict), "states isn't dict", cf())
        Assert(isinstance(init_state, list), "init_state isn't list", cf())
        Assert(len(states) > 1, "len(states) <= 1", cf())

        self.states = states

        pos_found = None
        for pos, state in states.items():
            if init_state == state:
                pos_found = pos
                break

        Assert(pos_found, "failed to set w_0", cf())

        super(WaveFunction, self).__init__(
            m=len(states), n=1,
            dtype=np.complex128
        )

        self.data[pos_found] = amplitude

    def set_amplitude(self, state_to_set, amplitude=1):
        pos_found = None
        for pos, state in self.states.items():
            if state == state_to_set:
                pos_found = pos
                break

        Assert(pos_found is not None, "amplitude not set", cf())

        self.data[pos_found] = amplitude

    def normalize(self):
        norm = np.linalg.norm(self.data)
        Assert(norm > 0, "norm <= 0", cf())

        self.data /= norm

    def print(self):
        for k, v in self.states.items():
            print(v, np.asarray(self.data[k]).reshape(-1)[0])
