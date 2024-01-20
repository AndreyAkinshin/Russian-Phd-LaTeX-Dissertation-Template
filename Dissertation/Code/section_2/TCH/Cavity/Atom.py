# lib
from lib.Assert import Assert
from lib.ParseJumps import parse_jumps


# класс "Атом"
class Atom:
    __slots__ = ['__id', '__wa', '__g', '__n_levels', '__lvl', 'jumps']
    __ID = 0

    def __init__(self, wa, g, id=None, lvl=0):
        self.__wa = wa
        self.__g = parse_jumps(g)
        self.__n_levels = 1 + max(
            [g['levels'][1] for g in self.__g.values()]
        )
        self.__lvl = 0

        self.set_id()

    def set_id(self):
        self.__id = Atom.__ID
        Atom.__ID += 1

    # получение id атома
    def id(self):
        return self.__id

    # получение частоты атомного перехода
    def wa(self, lvl=None):
        if lvl is None:
            return self.__wa

        if lvl in self.__wa:
            return self.__wa[lvl]

        lvl = str(lvl)

        if lvl in self.__wa:
            return self.__wa[lvl]

        Assert(False, 'lvl not in self.__wa')

    # получение интенсивности взаимодействия атома с полем
    def g(self, type=None):
        if type is None:
            return self.__g

        Assert(type in self.__g, 'type not in self.__g')
        return self.__g[type]

    # получение уровня атома
    def lvl(self):
        return self.__lvl

    # получение кол-ва уровней атома
    def n_levels(self):
        return self.__n_levels

    # возбуждение атома
    def up(self, lvl):
        ok = False

        for v in self.__g.values():
            if v['levels'] == [self.__lvl, lvl]:
                ok = True
                break

        Assert(ok, "not ok")
        self.__lvl = lvl

    # релаксация атома
    def down(self, lvl):
        ok = False

        for v in self.__g.values():
            if v['levels'] == [lvl, self.__lvl]:
                ok = True
                break

        Assert(ok, "not ok")
        self.__lvl = lvl

    # изменение уровня атома
    def change_lvl(self, lvl):
        Assert(
            lvl >= 0 and lvl <= self.__n_levels,
            'lvl < 0 or lvl > self.__n_levels'
        )
        self.__lvl = lvl
