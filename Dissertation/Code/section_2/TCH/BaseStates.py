import re

# TCH
from TCH.State import State


class BaseStates:
    def __init__(self, states):
        self.states = {}
        for k, v in enumerate(sorted(states)):
            self.states[k] = states[v]
            self.states[k].n_base_states = len(states)

            self.states[k].amplitude = {}

            for _ in range(len(states)):
                self.states[k].amplitude[_] = 0j

            self.states[k].amplitude[k] = 1

        State.BASE_STATES = self.states

    def key_by_id(self, id):
        for k, v in self.states.items():
            if v.id() == id:
                key = k
                break

        return key
