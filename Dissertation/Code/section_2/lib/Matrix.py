# scientific
import copy
import numpy as np
import pandas as pd
from scipy.sparse import lil_matrix, csc_matrix, csr_matrix


precision = 5
eps = 1.0 / (10 ** precision)


class Matrix:
    def __init__(self, m, n, dtype, data=None):
        Assert(m > 0, 'm <= 0')
        Assert(n > 0, 'n <= 0')

        self.m = m
        self.n = n

        self.dtype = dtype

        if isinstance(data, csc_matrix):
            self.data = data
        elif isinstance(data, lil_matrix):
            self.data = data
        elif isinstance(data, csr_matrix):
            self.data = csc_matrix(data)
        elif isinstance(data, Matrix):
            self.data = data.data
        else:
            print('exit:', type(data))
            exit(0)
            # self.data = csc_matrix((m, n), dtype=dtype)
            # self.data = csc_matrix(data, shape=(m, n), dtype=dtype)

            if data is not None:
                # self.data = csc_matrix.tocsc(data, copy=True)
                self.data = csc_matrix(data)
            else:
                self.data = csc_matrix((m, n), dtype=dtype)

        # self.data = np.matrix(
        #     np.zeros([m, n]),
        #     dtype=dtype
        # )

    def abs_trace(self, precision=3):
        exit(0)
        print("%.3f" % np.sum(np.abs(self.data.diagonal())))
        return "%.3f" % np.sum(np.abs(self.data.diagonal()))

    def conj(self):
        conj_matrix = Matrix(m=self.m, n=self.n, dtype=self.dtype, data=self.data.getH())

        return conj_matrix
    # -----------------------------------------------------------------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------

    # -----------------------------------------------------------------------------------------------------------------
    # ---------------------------------------------------- IS_HERMITIAN -----------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------
    def is_hermitian(self):
        return np.all(ro == ro.getH())
    # -----------------------------------------------------------------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------

    # -----------------------------------------------------------------------------------------------------------------
    # ---------------------------------------------------- ABS_TRACE --------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------
    def abs_trace(self):
        # print("%.3f" % np.sum(np.abs(self.data.diagonal())))
        return np.sum(np.abs(self.data.diagonal()))
    # -----------------------------------------------------------------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------

    # -----------------------------------------------------------------------------------------------------------------
    # ---------------------------------------------------- CHECK_HERMITICITY ------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------
    # def check_hermiticity(ro):
    #     Assert(self.is_hermitian(), 'not hermitian')
    # -----------------------------------------------------------------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------

    # -----------------------------------------------------------------------------------------------------------------
    # ---------------------------------------------------- CHECK_HERMITICITY ------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------
    def check_hermiticity(self):
        # print(self.data)
        # print()
        # print(self.conj().data)
        # print(self.data-self.conj().data)
        diff = self.data - self.conj().data
        # print(diff.data)
        # print(np.all(abs(diff.data) < eps))
        # exit(0)
        Assert(np.all(abs(diff.data) < eps), 'matrix is not hermitian')
        # Assert(np.all(abs(self.data - self.data.getH()) < eps), 'matrix is not hermitian')
    # -----------------------------------------------------------------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------

    # -----------------------------------------------------------------------------------------------------------------
    # ---------------------------------------------------- CHECK_UNITARITY --------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------
    def check_unitarity(self):
        data = self.data
        data_H = self.data.getH()

        I = np.eye(self.m)

        Assert(np.all(abs(data.dot(data_H) - I) < eps), 'matrix is not unitary')
        Assert(np.all(abs(data_H.dot(data) - I) < eps), 'matrix is not unitary')
    # -----------------------------------------------------------------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------

    # -----------------------------------------------------------------------------------------------------------------
    # ---------------------------------------------------- NORMALIZE --------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------
    def normalize(self):
        self.data = (self.data + self.data.getH()) / 2.0
        self.data /= np.sum(np.abs(self.data.diagonal()))

        # self.data /= np.linalg.norm(self.data)
    # -----------------------------------------------------------------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------

    # -----------------------------------------------------------------------------------------------------------------
    # ---------------------------------------------------- ABS_PRINT --------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------
    def abs_print(self, header=None, precision=3, sep='\t', end='\n'):
        if header is not None:
            print(header, color='green', attrs=['bold'])

        data = self.data.todense()

        for i in range(self.m):
            for j in range(self.n):
                print(np.round(abs(data[i, j]), precision), end=sep)

            print()

        print(end, end='')
    # -----------------------------------------------------------------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------

    # -----------------------------------------------------------------------------------------------------------------
    # ---------------------------------------------------- PRINT ------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------
    def print(self, header=None, precision=3, sep='\t', end='\n'):
        if header is not None:
            print(header, color='green', attrs=['bold'])

        data = self.data.todense()

        for i in range(self.m):
            for j in range(self.n):
                # if data[i, j].real and data[i, j].imag:
                #     print(str('(%.'+str(precision)+'f,') % (np.round(data[i, j].real, precision)), end='')
                #     print(str('%.'+str(precision)+'f)') % (np.round(data[i, j].imag, precision)), end=sep)
                # elif data[i, j].real:
                #     print(str('%.'+str(precision)+'f') % (np.round(data[i, j].real, precision)), end=sep)
                # elif data[i, j].imag:
                #     print(str('%.'+str(precision)+'fj') % (np.round(data[i, j].imag, precision)), end=sep)
                # else:
                #     print(str('%.'+str(precision)+'f') % (np.round(data[i, j].imag, precision)), end=sep)

                    # print(str('%.'+str(precision)+'f') % (np.round(data[i, j].imag, precision)), end=sep)

                print('(%.3f' % (np.round(data[i, j].real, precision)), end=',')
                print('%.3f)' % (np.round(data[i, j].imag, precision)), end=sep)
                # print(np.round(data[i, j], precision), end=sep)

            print()

        print(end, end='')
    # -----------------------------------------------------------------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------

    # -----------------------------------------------------------------------------------------------------------------
    # ---------------------------------------------------- SET_HEADER -------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------
    def set_header(self, header):
        self.header = header
    # -----------------------------------------------------------------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------

    # -----------------------------------------------------------------------------------------------------------------
    # ---------------------------------------------------- TO_HTML ----------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------
    def to_html(self, filename):
        self.iprint()
        self.df.to_html(filename)
    # -----------------------------------------------------------------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------

    def tofile(self, filename, precision=3, sep=','):
        data = self.data.todense()

        f = open(filename, 'w')

        for i in range(self.m):
            for j in range(self.n):
                value = data[i, j]

                if abs(value.real) < eps:
                    re = format(+0, '.' + str(precision) + 'f')
                else:
                    re = format(value.real, '.' + str(precision) + 'f')

                if abs(value.imag) < eps:
                    im = format(+0, '.' + str(precision) + 'f')
                else:
                    im = format(value.imag, '.' + str(precision) + 'f')

                f.write('(' + re + ',' + im + ')')

                if j != self.n - 1:
                    f.write(sep)

            f.write('\n')

        f.close()

    def tofile_abs(self, filename, precision=3, sep=','):
        data = self.data.todense()

        f = open(filename, 'w')

        for i in range(self.m):
            for j in range(self.n):
                value = data[i, j]

                if abs(value) < eps:
                    value = format(+0, '.' + str(precision) + 'f')
                else:
                    value = format(value, '.' + str(precision) + 'f')

                f.write(value)

                if j != self.n - 1:
                    f.write(sep)

            f.write('\n')

        f.close()

    # -----------------------------------------------------------------------------------------------------------------
    # ---------------------------------------------------- OPERATORS --------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------
    def __add__(self, other):
        self.data += other.data

        return self
    # -----------------------------------------------------------------------------------------------------------------
    # -----------------------------------------------------------------------------------------------------------------

# =====================================================================================================================
# def remove_row(self, k):
#     self.data = np.delete(self.data, k, axis=0)
# =====================================================================================================================
# def swap_rows(self, i, j):
#     self.data[[i]], self.data[[j]] = self.data[[j]], self.data[[i]]

#     return
# =====================================================================================================================
# def swap_cols(self, j1, j2):
#     for i in range(self.m):
#         self.data[i][j1], self.data[i][j2] = self.data[i][j2], self.data[i][j1]

#     return
# =====================================================================================================================
# def remove_empty_rows(self):
#     for i in range(self.m-1, -1, -1):
#         if np.all(self.data[i] == np.zeros(self.n)):
#             self.data = np.delete(self.data, i, axis=0)
#             self.m -= 1
# =====================================================================================================================
# def remove_empty_cols(self):
#     self.data = np.transpose(self.data)
#     self.m, self.n = self.n, self.m
#     self.remove_empty_rows()
#     self.m, self.n = self.n, self.m
#     self.data = np.transpose(self.data)
# =====================================================================================================================
# def iprint(self, metric=None):
#     df = pd.DataFrame()

#     for i in range(self.m):
#         for j in range(self.n):
#             if metric is None:
#                 df.loc[i, j] = str(int(abs(self.data[i, j])))
#             else:
#                 df.loc[i, j] = wc_str(abs(self.data[i, j]))

#     if self.states is not None:
#         df.index = df.columns = [str(v) for v in self.states.values()]

#     self.df = df
# =====================================================================================================================
# def to_csv(self, filename, precision=5):
#     if self.dtype == np.complex128:
#         with open(filename, 'w') as f:
#             for i in range(0, self.m):
#                 for j in range(0, self.n):
#                     value = self.data[i, j]

#                     if abs(value.real) < eps:
#                         re = format(+0, '.' + str(precision) + 'f')
#                     else:
#                         re = format(value.real, '.' + str(precision) + 'f')

#                     if abs(value.imag) < eps:
#                         im = format(+0, '.' + str(precision) + 'f')
#                     else:
#                         im = format(value.imag, '.' + str(precision) + 'f')

#                     f.write('(' + re + ',' + im + ')')

#                     if j != self.n - 1:
#                         f.write(',')

#                 f.write('\n')
#     else:
#         with open(filename, 'w') as f:
#             for i in range(0, self.m):
#                 for j in range(0, self.n):
#                     value = self.data[i, j]

#                     if abs(value) < eps:
#                         re = format(+0, '.' + str(precision) + 'f')
#                     else:
#                         re = format(value, '.' + str(precision) + 'f')

#                     f.write(re)

#                     if j != self.n - 1:
#                         f.write(',')

#                 f.write('\n')
#     return
# =====================================================================================================================
# def print_pd(self):
#     size = len(str(self.header[0])) + 1

#     print(' ' * (len(str(self.header[0])) + 1), end='')

#     for k, v in self.header.items():
#         print(v, end=' ')

#     print()

#     for i in range(self.m):
#         print(self.header[i], end=' ')

#         for j in range(self.n):
#             s = wc_str_v(self.data[i, j].real, 3)

#             print(s.rjust(size - 1, ' '), end=' ')

#         print()

#     print()
# =====================================================================================================================
# def swap_rows(self, i, j):
#     self.data[[i]], self.data[[j]] = self.data[[j]], self.data[[i]]

#     return
# =====================================================================================================================
