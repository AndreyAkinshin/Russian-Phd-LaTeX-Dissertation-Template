from TCH.Const import wc, ns, mks, ms, KHz, MHz, GHz
from copy import copy, deepcopy
from math import sqrt
import os
import sys
from utils.sub import sub
from lib.to_Hz import to_Hz
from pygments import highlight, lexers, formatters
from time import sleep as sleep
import json as json
from lib._print import hr
from lib._print import print as Print
import builtins

from lib.Assert import Assert
builtins.Assert = Assert

builtins.print = Print

builtins.hr = hr

builtins.json = json

builtins.sleep = sleep

builtins.highlight = highlight
builtins.lexers = lexers
builtins.formatters = formatters

builtins.to_Hz = to_Hz

builtins.sub = sub

builtins.sys = sys

builtins.os = os

builtins.sqrt = sqrt

builtins.copy = copy
builtins.deepcopy = deepcopy

builtins.wc = wc
builtins.ns = ns
builtins.mks = mks
builtins.ms = ms
builtins.KHz = KHz
builtins.MHz = MHz
builtins.GHz = GHz
