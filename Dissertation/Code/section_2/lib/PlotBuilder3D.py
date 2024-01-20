import plotly.graph_objs as go
import plotly

# lib
from lib.Assert import Assert


class PlotBuilderData3D:
    def __init__(self, args):
        required_args = [
            'title', 'width', 'height', 'x', 'y', 'z', 'ticks'
        ]

        for i in required_args:
            Assert(i in args, i + ' not in args')

        self.width = int(args['width'])
        Assert(
            self.width > 0 and self.width <= 1200,
            str(self.width) + ' not in (0, 1200]'
        )

        self.height = int(args['height'])
        Assert(
            self.height > 0 and self.height <= 800,
            str(self.height) + ' not in (0, 800]'
        )

        self.title = args['title']

        self.x = args['x']
        self.y = args['y']
        self.z = args['z']

        self.x_tickvals = self.x['data']
        self.y_tickvals = self.y['data']

        self.t_coeff = 1

        self.ticks = args['ticks']

        self.to_file = None
        if 'to_file' in args:
            self.to_file = args['to_file']

        self.showlegend = None
        if 'showlegend' in args:
            self.showlegend = args['showlegend']

        if 'scale' not in self.x:
            self.x['scale'] = 1
        if 'scale' not in self.y:
            self.y['scale'] = 1
        if 'scale' not in self.z:
            self.z['scale'] = 1

    def prepare(self):
        # ----------------------------- X ---------------------------------
        self.x['tickvals'] = self.x['data']

        if 'nticks' in self.x:
            x_nticks = self.x['nticks']
            x_step = len(self.x['data']) // x_nticks
            x_ticktext = [''] * len(self.x['ticktext'])

            for i in range(0, len(self.x['tickvals']), x_step):
                x_ticktext[i] = self.x['ticktext'][i]

            self.x['ticktext'] = x_ticktext
        else:
            print('no x_nticks')
            exit(1)
        # ----------------------------- X ---------------------------------

        # ----------------------------- Y ---------------------------------
        self.y['tickvals'] = self.y['data']

        if 'nticks' in self.y:
            y_nticks = self.y['nticks']
            y_step = len(self.y['data']) // y_nticks
            y_ticktext = [''] * len(self.y['ticktext'])

            if self.y['ticktext'][0] != 0:
                y_ticktext[0] = self.y['ticktext'][0]

                for i in range(len(self.y['tickvals'])):
                    if self.y['tickvals'][i] == y_step:
                        i0 = i
                        break
                for i in range(i0, len(self.y['tickvals']), y_step):
                    y_ticktext[i] = self.y['ticktext'][i]
            else:
                for i in range(y_step, len(self.y['tickvals']), y_step):
                    y_ticktext[i] = self.y['ticktext'][i]

            self.y['ticktext'] = y_ticktext
        else:
            print('no y_nticks')
            exit(1)
        # ----------------------------- Y ---------------------------------

        data = [
            go.Surface(
                z=self.z['data'],
                colorscale='portland',
                contours=go.surface.Contours(
                    z=go.surface.contours.Z(
                        show=True,
                        usecolormap=True,
                        project=dict(z=True)
                    )
                )
            )
        ]

        scale = 1

        layout = go.Layout(
            title='<b>' + self.title + '</b>',
            width=self.width,
            height=self.height,
            titlefont=dict(family='Lato', color='#222', size=20),
            plot_bgcolor='#AAA',
            scene=go.layout.Scene(
                camera=dict(
                    up=dict(x=0, y=0, z=1),
                    center=dict(x=0, y=0, z=0.2),
                    eye=dict(x=3.75, y=3.75, z=3.75)
                ),
                xaxis={
                    'title': self.x['title'],
                    'titlefont': dict(
                        family=self.ticks['family'],
                        color=self.ticks['color'],
                        size=self.ticks['title']['size']
                    ),
                    'linewidth': 2,
                    'showgrid': False,
                    'showline': False,
                    'tickvals': self.x['tickvals'],
                    'ticktext': self.x['ticktext'],
                    'tickfont': dict(
                        family=self.ticks['family'],
                        color=self.ticks['color'],
                        size=self.ticks['size']
                    ),
                    'tickangle': 0
                },
                yaxis={
                    'title': self.y['title'],
                    'titlefont': dict(
                        family=self.ticks['family'],
                        color=self.ticks['color'],
                        size=self.ticks['title']['size']
                    ),
                    'showgrid': False,
                    'showline': False,
                    'tickvals': self.y['tickvals'],
                    'ticktext': self.y['ticktext'],
                    'tickfont': dict(
                        family=self.ticks['family'],
                        color=self.ticks['color'],
                        size=self.ticks['size']
                    ),
                    'tickangle': 0,
                    'linewidth': 2
                },
                zaxis={
                    'title': self.z['title'],
                    'titlefont': dict(
                        family=self.ticks['family'],
                        color=self.ticks['color'],
                        size=self.ticks['title']['size']
                    ),
                    'tickfont': dict(
                        family=self.ticks['family'],
                        color=self.ticks['color'],
                        size=self.ticks['size']
                    ),
                    'tickangle': 0,
                    'showgrid': False,
                    'showline': False,
                    'linewidth': 2
                },
                aspectratio={
                    'x': self.x['scale'],
                    'y': self.y['scale'],
                    'z': self.z['scale']
                },
            ),
            showlegend=False
        )
        self.fig = go.Figure(data=data, layout=layout)

        if self.to_file:
            py.image.save_as(self.fig, filename=self.to_file)

    def make_plot(self, online=False, path='', filename='plot3d.html'):
        self.prepare()

        print('Making plot...')
        plotly.offline.plot(self.fig, filename=path + filename)
