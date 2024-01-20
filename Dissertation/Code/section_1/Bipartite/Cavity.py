# lib
from lib.Assert import Assert, cf


# класс "Полость"
class Cavity:
    def __init__(self, n, wc, wa, g):
        Assert(isinstance(n, int), "n is not integer", cf())
        Assert(isinstance(wc, (int, float)), "wc is not numeric", cf())
        Assert(isinstance(wa, (int, float)), "wa is not numeric", cf())
        Assert(isinstance(g, (int, float)), "g is not numeric", cf())

        Assert(n > 0, "n <= 0", cf())
        Assert(wc > 0, "wc <= 0", cf())
        Assert(wa > 0, "wa <= 0", cf())
        Assert(g > 0, "g <= 0", cf())

        self.n = n

        self.wc = wc
        self.wa = wa

        self.g = g
