from math import sqrt
from copy import deepcopy

# TCH
from TCH.BaseStates import BaseStates
from TCH.Hamiltonian import Hamiltonian
from TCH.State import State


# класс "Квантовая система"
class QuantumSystem:
    __slots__ = [
        '__cavity_chain', '__init_state',
        '__basis', '__n_base_states',
        '__H'
    ]

    def __init__(self, cavity_chain):
        self.__cavity_chain = cavity_chain
        self.__init_state = State(cavity_chain=self.__cavity_chain)
        self.__basis = self.set_basis()
        self.__n_base_states = len(self.__basis.states)
        self.__H = Hamiltonian(
            base_states=self.__basis,
            cavity_chain=self.__cavity_chain
        )

    def init_state(self):
        return self.__init_state

    def n_base_states(self):
        return self.__n_base_states

    def H(self):
        return self.__H

    # сложная функция определения базисных состояний системы
    # с учетом всевозможных переходов, включая перелет фотонов
    # между полостями и утечку фотонов в сток
    def set_basis(self):
        cv_chain = self.__cavity_chain
        cavities = list(cv_chain.cavities())

        self.__init_state = state = State(cavity_chain=cv_chain)

        notation = state.as_string()

        base_states = {}
        base_states_not_checked = {notation: state}

        while len(base_states_not_checked):
            keys = list(base_states_not_checked.keys())

            notation = keys[0]
            state = base_states_not_checked[notation]

            # перелет фотона между полостями
            for conn_k, conn_v in cv_chain.connections().items():
                ph_type = conn_v['ph_type']
                can = state.try_jump(
                    cv_from=conn_v['cavity_ids'][0],
                    cv_to=conn_v['cavity_ids'][1],
                    ph_type=ph_type
                )

                if can is not None:
                    newcode = can['newcode']

                    if (newcode not in base_states) and \
                            (newcode not in base_states_not_checked):
                        new_state = deepcopy(state)
                        new_state.delete_conn()
                        cv_from = can['cv_from']
                        cv_to = can['cv_to']

                        new_state.make_jump(
                            cv_from=cv_from,
                            cv_to=cv_to,
                            ph_type=ph_type
                        )

                        new_state.set_id()

                        base_states_not_checked[newcode] = new_state

                        amplitude = sqrt(
                            cv_chain.cavity(cv_from).photons(ph_type)
                        ) * sqrt(
                            cv_chain.cavity(cv_to).photons(ph_type) + 1
                        )

                        amplitude = {'value': amplitude}

                        state.connect(state=new_state, amplitude=amplitude)

            can_jump_cv = state.cavity_chain().try_jump_cv()

            if len(can_jump_cv):
                for jmp in can_jump_cv:
                    newcode = jmp['newcode']
                    if (newcode not in base_states) \
                            and (newcode not in base_states_not_checked):
                        if 'ph' in jmp and 'atom_i' in jmp or \
                                'ph' in jmp and 'sink_i' in jmp or \
                                'atom_i' in jmp and 'atom_i' in jmp:
                            pass
                        else:
                            continue

                        new_state = deepcopy(state)
                        new_state.delete_conn()

                        if 'atom_i' in jmp:
                            new_state.cavity(
                                jmp['cavity']
                            ).atom(
                                jmp['atom_i']
                            ).change_lvl(jmp['atom_lvl'])

                        if 'sink_i' in jmp:
                            new_state.cavity(
                                jmp['cavity']
                            ).set_sink(
                                jmp['sink_i'], jmp['sink_lvl']
                            )

                        if 'ph' in jmp:
                            if jmp['ph']['action'] == 'add':
                                new_state.cavity(
                                    jmp['cavity']
                                ).add_photon(
                                    jmp['ph']['ph_type']
                                )
                            elif jmp['ph']['action'] == 'remove':
                                new_state.cavity(
                                    jmp['cavity']
                                ).remove_photon(
                                    jmp['ph']['ph_type']
                                )

                        new_state.set_id()

                        base_states_not_checked[newcode] = new_state
                        amplitude = jmp['amplitude']

                        if 'ph' in jmp and 'atom_i' in jmp and \
                                'sink_i' not in jmp:
                            state.connect(
                                state=new_state,
                                amplitude=amplitude
                            )

            del base_states_not_checked[notation]
            base_states[notation] = state

        Assert(
            len(base_states_not_checked) == 0,
            'len(base_states_not_checked) != 0'
        )

        # полученные базисные состояния
        self.__basis = BaseStates(base_states)

        return self.__basis
