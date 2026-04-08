
import json
import pandas as pd 
import plotly.express as px
import plotly.graph_objects as go 

gap = px.data.gapminder().query("year==2007")

europe = gap.query("continent == 'Europe'")



fig = px.choropleth( #make world figure with only data in europe
    europe,
    locations = "iso_alpha",
    color = "gdpPercap",
    hover_name = "country",
    hover_data = {
        "gdpPercap": ":,.0f",
        "pop": ":,",
        "iso_alpha" : False
    },
    color_continuous_scale = "Viridis", 
    title = "Europe: GDP per cap. and Population by country (2007)"
)


fig.update_geos( #clip map to only show european countries 
    scope = "europe",
    showland = True,
    landcolor = "rgb(240,240,240)"

)
fig.show()


#add two items 

fig2 = px.choropleth( #make world figure with only data in europe
    europe,
    locations = "iso_alpha",
    color = "gdpPercap",
    hover_name = "country",
    hover_data = {
        "gdpPercap": ":,.0f",
        "pop": ":,",
        "iso_alpha" : False
    },
    color_continuous_scale = "Viridis", 
    title = "Europe: GDP per cap. and Population by country",
    subtitle = "2007 Data", #added subtitle
   
)
fig2.show()
fig2.update_geos( #clip map to only show european countries 
    scope = "europe",
    showland = True,
    landcolor = "rgb(240,240,240)",
    zoom = 20
)
fig2.show()

fig3 = px.scatter_geo(
    gap,
    locations = "iso_alpha",
    color = 




)
