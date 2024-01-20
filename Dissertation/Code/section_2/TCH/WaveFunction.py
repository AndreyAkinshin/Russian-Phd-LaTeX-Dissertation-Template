import numpy as np
from scipy.sparse.linalg import norm
from scipy.sparse import lil_matrix

# lib
from lib.Matrix import Matrix


class WaveFunction(Matrix):
    def __init__(self, states, init_state, amplitude=1):
        Assert(len(states) > 1, "len(states) <= 1")

        self.init_state = init_state
        self.amplitude = amplitude

        self.states = {}
        for k, v in states.items():
            self.states[k] = v.state()

        pos_found = None
        for pos, state in self.states.items():
            if init_state == state:
                pos_found = pos
                break

        Assert(pos_found is not None, "w_0 is not set")

        data = lil_matrix((len(states), 1), dtype=np.complex128)
        data[pos_found, 0] = amplitude

        super(WaveFunction, self).__init__(
            m=len(states), n=1,
            dtype=np.complex128,
            data=data
        )

    def set_amplitude(self, state_to_set, amplitude=1):
        pos_found = None
        for pos, set_state in enumerate(self.states):
            if state == state_to_set:
                pos_found = pos
                break

        Assert(pos_found is not None, "amplitude not set")
        self.data[pos_found, 0] = amplitude

    def normalize(self):
        wf_norm = norm(self.data)
        Assert(wf_norm > 0, "norm <= 0")

        self.data /= wf_norm
