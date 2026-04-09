#using plotly to make maps 
# bryan
#7 April 2026

import json
import pandas as pd 
import plotly.express as px
import plotly.graph_objects as go 

#load in data here (gapminder)
gap = px.data.gapminder().query("year==2007")
gap.head()

# min level choropleth
fig = px.choropleth(
    gap,
    locations = "iso_alpha",
    color = "lifeExp",
    hover_name = "country"

)
fig.show()


# add title, change coloration 

fig = px.choropleth(
    gap,
    locations = "iso_alpha",
    color = "lifeExp",
    hover_name = "country",
    color_continuous_scale = "Viridis",
    title =  "Life Expectancy by Country (2007)"
)
fig.show()

#crop map and improve labels
fig.update_layout(
    coloraxis_colorbar_title = "Years",
    margin = dict(l = 0, r = 0, t = 50, b=0) 
)

#gdp with more hovering info: 

fig = px.choropleth(
    gap,
    locations = "iso_alpha",
    color = "gdpPercap",
    hover_name = "country",
    hover_data = {
        "lifeExp":":1f",
        "pop": ":,",
        "gdpPercap": ":,.0f",
        "iso_alpha" : False
    },
    color_continuous_scale = "Plasma", 
    title = "GDP per cap. by country (2007)"
)
fig.show()

# update outlines of GDP map 

fig.update_geos(
    showframe = False,
    showcoastlines = False
)

#crop map to one region 

americas = gap.query("continent == 'Americas'")

americas


fig = px.choropleth(
    americas,
    locations = "iso_alpha",
    color = "lifeExp",
    hover_name = "country",
    color_continuous_scale = "Tealgrn",
    title =  "Life Expectancy in the Americas (2007)"
)
fig.show()

fig.update_geos(
    scope = "north america",
    showland = True,
    landcolor = "rgb(240,240,240)"

)
fig.show()


# look at projectsion

fig.update_geos(projection_type = "natural earth")
fig.show()

fig.update_geos(projection_type = "mercator")
fig.show()

fig.update_geos(projection_type = "orthographic")
fig.show()


# tile placed choropleths

from urllib.request import urlopen

with urlopen("https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json") as response:
    county_geojson = json.load(response)

county_df = pd.read_csv(
    "https://raw.githubusercontent.com/plotly/datasets/master/fips-unemp-16.csv",
    dtype={"fips": str}
)

county_df.head()



fig = px.choropleth_map(
    county_df,
    geojson=county_geojson,
    locations="fips",
    featureidkey="id",
    color="unemp",
    color_continuous_scale="Tealgrn",
    zoom=3,
    center={"lat": 37.8, "lon": -96},
    map_style="carto-darkmatter",
    opacity=0.7,
    title="US county unemployment"
)
fig.show()






