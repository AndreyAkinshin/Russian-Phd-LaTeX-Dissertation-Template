import _pickle as cPickle
import gzip


def pickle_dump(data, filename):
    # выгрузка данных в файл <filename>.gz
    opener = gzip.open if filename.lower().endswith('.gz') else open
    handle = opener(filename, 'wb')
    cPickle.dump(data, handle, protocol=0)
    handle.close()


def pickle_load(filename):
    # считывание данных из файла <filename>.gz
    opener = gzip.open if filename.lower().endswith('.gz') else open
    handle = opener(filename, 'rb')
    data = cPickle.load(handle)
    handle.close()

    return data
