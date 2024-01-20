from lib.Assert import *


def to_Hz(value, precision=3):
    if value >= 1e9:
        value_str = str(round(value / 1e9, precision)) + ' GHz'
    elif value >= 1e6:
        value_str = str(round(value / 1e6, precision)) + ' MHz'
    elif value >= 1e3:
        value_str = str(round(value / 1e3, precision)) + ' KHz'
    else:
        value_str = str(round(value, precision)) + ' Hz'

    return value_str


def value_str_v(value, precision=3):
    if value >= 1e9:
        value_str = str(round(value / 1e9, precision))
    elif value >= 1e6:
        value_str = str(round(value / 1e6, precision))
    elif value >= 1e3:
        value_str = str(round(value / 1e3, precision))
    else:
        value_str = str(round(value, precision))

    return value_str

# ---------------------------------------------------------------------------------------------------------------------


def time_unit(time):
    # Assert(not(time != 0 and time < 1e-9), 'time < 1 ns')

    if time >= 1:
        unit = 's'
    elif time >= 1e-3:
        unit = 'ms'
    elif time >= 1e-6:
        unit = 'mks'
    elif time >= 1e-9:
        unit = 'ns'
    else:
        unit = 'fs'

    return unit
# ---------------------------------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------------------------------
def time_unit_full(time, precision=3):
    # Assert(not(time != 0 and time < 1e-9), 'time < 1 ns')
    # Assert(time >= 1e-9, 'time < 1 ns')

    if time >= 1:
        return str(round(time, precision)) + ' s'
    elif time >= 1e-3:
        return str(round(time / 1e-3, precision)) + ' ms'
    elif time >= 1e-6:
        return str(round(time / 1e-6, precision)) + ' mks'
    elif time >= 1e-9:
        return str(round(time / 1e-9, precision)) + ' ns'
    elif time >= 1e-12:
        return str(round(time / 1e-9, precision)) + ' ns'
    #     return str(round(time/1e-12, precision)) + ' p'
    # elif time >= 1e-15:
    #     return str(round(time/1e-15, precision)) + ' f'

    return time
# ---------------------------------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------------------------------
def frequency_unit(frequency):
    Assert(frequency >= 1, 'frequency < 1 Hz')

    if frequency >= 1e9:
        unit = 'GHz'
    elif frequency >= 1e6:
        unit = 'MHz'
    elif frequency >= 1e3:
        unit = 'KHz'
    else:
        unit = 'Hz'

    return unit
# ---------------------------------------------------------------------------------------------------------------------
