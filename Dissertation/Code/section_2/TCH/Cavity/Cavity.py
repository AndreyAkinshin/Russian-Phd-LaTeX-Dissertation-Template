# lib
from lib.ParseJumps import parse_jumps

# TCH
from TCH.Cavity.Atom import Atom


# класс "Полость
class Cavity:
    __ID = 0
    __init__ = ['__wc', '__n_photons', '__atoms', '__n_atoms', '__sink']

    def __init__(self, wc, id=None, photons=None, sink=None, atoms=[]):
        self.__wc = parse_jumps(wc)

        if photons is None:
            self.__n_photons = {}
        else:
            self.__n_photons = photons

        for ph_type in self.__wc.keys():
            self.__n_photons[ph_type] = 0

        self.__atoms = atoms
        self.__n_atoms = len(self.__atoms)

        self.__sink = sink

        self.set_id()

    @staticmethod
    def string_notation(code):
        s = ''
        for i in sorted(code[0].keys()):
            s += str(code[0][i])

        s += ''.join(map(str, code[1]))
        s += ''.join(map(str, code[2]))

        return s

    def as_array(self):
        return Cavity.string_notation(self.get_state())

    def try_jump(self):
        ans = []

        for sink_k, sink_v in enumerate(self.__sink):
            if sink_v['type'] == 'photon':
                for ph_type, ph_cnt in self.photons().items():
                    if ph_cnt > 0 and sink_v['capacity'] >= sink_v['lvl'] + 1:
                        state = self.get_state()

                        state[0][ph_type] -= 1
                        state[2][sink_k] += 1

                        ans.append({
                            'newcode': Cavity.string_notation(state),
                            'ph': {
                                'ph_type': ph_type,
                                'action': 'remove',
                            },
                            'sink_type': sink_v['type'],
                            'sink_i': sink_k,
                            'sink_lvl': state[2][sink_k],
                            'amplitude': {'value': 0},
                        })
            if sink_v['type'] == 'atom':

                for k_atom, v_atom in enumerate(self.atoms()):
                    lvl = v_atom.lvl()
                    if lvl == 1 and sink_v['capacity'] >= sink_v['lvl'] + 1:
                        state = self.get_state()

                        state[1][k_atom] = 0
                        state[2][sink_k] += 1

                        ans.append({
                            'newcode': Cavity.string_notation(state),
                            'atom_i': k_atom,
                            'atom_lvl': state[1][k_atom],

                            'sink_type': sink_v['type'],
                            'sink_i': sink_k,
                            'sink_lvl': state[2][sink_k],
                            'amplitude': {'value': 0},
                        })

        for ph_type, ph_cnt in self.photons().items():
            for k_atom, v_atom in enumerate(self.atoms()):
                lvl = v_atom.lvl()
                n_levels = v_atom.n_levels()

                lvl_from = self.wc(ph_type)['levels'][0]
                lvl_to = self.wc(ph_type)['levels'][1]

                if self.photons(ph_type) > 0:
                    # upper atom level
                    if lvl == lvl_from:
                        state = self.get_state()

                        state[0][ph_type] -= 1
                        state[1][k_atom] = lvl_to

                        ans.append({
                            'newcode': Cavity.string_notation(state),
                            'ph': {
                                'ph_type': ph_type,
                                'action': 'remove',
                            },
                            'atom_i': k_atom,
                            'atom_lvl': lvl_to,
                            'amplitude': self.atom(k_atom).g(ph_type),
                        })
                    elif lvl == lvl_to:
                        state = self.get_state()

                        state[0][ph_type] += 1
                        state[1][k_atom] = lvl_from

                        # lower atom level
                        ans.append({
                            'newcode': Cavity.string_notation(state),
                            'ph': {
                                'ph_type': ph_type,
                                'action': 'add',
                            },
                            'atom_i': k_atom,
                            'atom_lvl': lvl_from,
                            'amplitude': self.atom(k_atom).g(ph_type),
                        })

        return ans

    def add_photon(self, type, count=1):
        Assert(count >= 1, 'count < 1')

        if type not in self.__n_photons:
            self.__n_photons[type] = 0

        self.__n_photons[type] += count

    def remove_photon(self, type, count=1):
        Assert(type in self.__n_photons, 'type not in self.__n_photons')
        Assert(self.__n_photons[type] >= count,
               'self.__n_photons[type] < count')

        self.__n_photons[type] -= count

    def add_atom(self, atom):
        self.__atoms.append(atom)

        self.__n_atoms += 1

    def remove_atom(self, atom):
        self.__atoms.remove(atom)

        self.__n_atoms -= 1

    def remove_atom_by_id(self, atom_id):
        for atom in self.__atoms:
            if atom.id() == atom_id:
                self.remove_atom(atom)
                break

    def set_id(self):
        self.__id = Cavity.__ID
        Cavity.__ID += 1

    def id(self):
        return self.__id

    def wc(self, ph_type=None):
        if ph_type is None:
            return self.__wc

        return self.__wc[ph_type]

    def photons(self, ph_type=None):
        if ph_type is None:
            return self.__n_photons

        Assert(ph_type in self.__n_photons, 'ph_type not in self.__n_photons')

        return self.__n_photons[ph_type]

    def atom(self, index):
        Assert(index >= 0 and index < len(self.__atoms), 'no such index')

        return self.__atoms[index]

    def atoms(self):
        return self.__atoms

    # получение стока
    def set_sink(self, sink_i, sink_lvl):
        self.__sink[sink_i]['lvl'] = sink_lvl

    def get_state(self):
        state = []

        ph_state = {}

        for k_wc, v_wc in self.wc().items():
            if k_wc not in ph_state:
                ph_state[k_wc] = 0

            if k_wc in self.__n_photons:
                ph_state[k_wc] = self.__n_photons[k_wc]

        at_state = [i.lvl() for i in self.__atoms]

        sink_state = []
        for sink in self.__sink:
            sink_state += [sink['lvl']]

        return [ph_state, at_state, sink_state]
