import numpy as np
import pandas as pd
import plotly
import plotly.graph_objects as go


def PyPlot3D(z_csv, x_csv, y_csv, title="", t_coeff=1, path=".", filename="", x_axis="states", y_axis="time", to_file="", y_scale=1):
    z_data = pd.read_csv(z_csv, header=None)

    x = pd.read_csv(x_csv, keep_default_na=False)
    x.replace(r'\[(.+)\]', r'{\1>', regex=True, inplace=True)

    x_header = list(x)[0]
    x_ticktext = list(x['x'])
    x_tickvals = list(x['vals'])

    for i in range(len(x_ticktext)):
        x_ticktext[i] = x_ticktext[i]
        x_ticktext[i] = str(x_ticktext[i])

    y = pd.read_csv(y_csv, keep_default_na=False)

    y_header = list(y)[0]
    y_ticktext = list(y["y"])
    y_tickvals = np.array(list(y["vals"])) / t_coeff

    data = [
        go.Surface(
            showscale=False,
            lighting=dict(diffuse=0.5, specular=.2, fresnel=0.2),
            z=z_data.values,
            colorscale="Portland"
        )
    ]

    scale = int(y_ticktext[-1])

    layout = go.Layout(
        title=title,
        titlefont=dict(family='Lato', size=20, color="#222"),
        margin=go.Margin(l=0, r=0, b=0, t=35, pad=50),
        xaxis=dict(
            ticks='outside',
            tickfont=dict(size=200)
        ),
        yaxis=dict(
            title="y Axis",
            titlefont=dict(
                family="Courier New, monospace",
                size=40,
                color="#FFFFFF"
            ),
            ticks='outside',
            tickfont=dict(size=200)
        ),
        autosize=False,
        width=1200,
        height=650,
        plot_bgcolor="#AAA",
        scene=go.Scene(
            camera=dict(
                up=dict(x=0, y=0, z=1),
                center=dict(x=0, y=0, z=0.2),
                eye=dict(x=3.75, y=3.75, z=3.75)
            ),
            aspectratio={"x": 1, "y": y_scale * y_ticktext[-1], "z": 1},
            xaxis={
                "title": x_axis,
                "showgrid": False,
                "showline": False,
                "tickvals": x_tickvals,
                "ticktext": x_ticktext,
                'titlefont': dict(size=18),
                'tickfont': dict(size=14),
                'autorange': True
            },
            yaxis={
                'autorange': True,
                "title": y_axis,
                "ticktext": y_ticktext[::2],
                "tickvals": y_tickvals[::2],
                "linewidth": 1,
                'titlefont': dict(size=18),
                'tickfont': dict(size=14)
            },
            zaxis={
                'autorange': True,
                "range": [0, 1],
                "title": "prob.",
                "linewidth": 1,
                'titlefont': dict(size=18),
                'tickfont': dict(size=14)
            }
        )
    )
    fig = go.Figure(data=data, layout=layout)

    print("Making plot...")
    plotly.offline.plot(fig, filename=path + filename + ".html")
