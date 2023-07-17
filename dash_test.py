import dash 
from jupyter_dash import JupyterDash 
import dash_core_components as dcc 
import dash_html_components as html 
import plotly.express as px
from dash.dependencies import Input, Output

gapminder = px.data.gapminder()
gapminder.head()

app = JupyterDash(__name__)

app.layout = html.Div([
                       dcc.Dropdown(id="my_dropdown",
                                    options=[{"value": cnt, "label": cnt} for cnt in gapminder.country.unique()],
                                    value=["Japan", "China", "Korea, Rep."],# ➊
                                    multi=True# ➋
                                    ),
                       dcc.Graph(id="my_graph")
])

@app.callback(Output("my_graph", "figure"), Input("my_dropdown", "value"))
def update_graph(selected_country):
  selected_gapminder = gapminder[gapminder["country"].isin(selected_country)] # ➌
  return px.line(selected_gapminder, x="year", y="lifeExp", color="country") # ➍

app.run_server(mode="", port=8052)