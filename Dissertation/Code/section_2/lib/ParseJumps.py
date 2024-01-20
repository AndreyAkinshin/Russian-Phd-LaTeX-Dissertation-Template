import re

# lib
from lib.Assert import Assert


# парсинг переходов, записанных в виде {'0<->1': config.wc}:
# - выделение уровней, участвующих в переходе
# - выделение амплитуды перехода
#
# return {'0<->1': {'value': 67290000.0, 'levels': [0, 1]}}
def parse_jumps(jumps):
    jumps_parsed = {}

    for k in jumps.keys():
        levels = re.split('<->|-', k)
        Assert(len(levels) == 2, 'len(levels) != 2')

        for i in range(len(levels)):
            levels[i] = int(levels[i])

        levels.sort()
        Assert(levels[0] != levels[1], 'levels[0] == levels[1]')

        key = str(levels[0]) + '<->' + str(levels[1])

        if len(jumps_parsed):
            for i in jumps_parsed.keys():
                Assert(i != key, 'duplicated key')

        jumps_parsed[key] = {
            'value': jumps[k],
            'levels': levels,
        }

    return jumps_parsed
