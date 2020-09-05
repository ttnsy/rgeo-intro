# Introduction to Geospatial Analysis in R

## Overview

The following coursebook is produced for [Algoritma](https://algorit.ma/)'s DSS [*Geospatial Analysis in R*](https://algorit.ma/ds-course/building-interactive-mapping-for-geospatial-analysis-in-r/) workshop. The 4-days online workshop is intended for participants new to the world of spatial analysis and / or programming. No prior programming knowledge is assumed.

 The primary objective of this course is to provide a participant a comprehensive introduction about tools and software for visualizing a geospatial data using the popular open-source tools: R

## Modules

- [Part 1. Brief Introduction to R](introduction.Rmd):
    * Tools Introduction
        + R and R Studio  
        + Open source packages  
        + Using R Markdown  
        + R Programming Basics  
    * Data Wrangling with R's `tidyverse`
        + Working with tabular data in R: Tips and Techniques 
        + Data Wrangling and Aggregation
        + Introduction to visualization with `ggplot2`

- [Part 2. Geospatial Analysis in R](main-course.Rmd)
    * Building Indonesia Static Map
        - Retrieving Indonesia spatial vector from an open source provider
        - Using `sf` for R's spatial environment
        - Grammar of Graphics for geospatial data using `ggplot2`
        - Enhancing map plots for richer visualization 
    * Creating Interactive Map
        - Using `leaflet` - a JavaScript API for creating interactive maps
        - Adding markers and colors in `leaflet`
        - Building various geospatial analysis graphics: Choropleth, Heatmap, etc.
    * [Publishing your visualization](dashboard-geo.Rmd)
        - Create an awesome and easy-to-build [dashboard](https://rpubs.com/tangerine/dss-geospatial) using `flexdashboard` package
        - Present your geospatial analysis for various industries business solution

- [Additional: Demo for R's`sp` package](sp-example.Rmd)

## R packages

Following packages are used within the material:

```r
packages <- c("rgdal","sf","tidyverse","glue", "plotly", "maps","leaflet","leaflet.extras", "tmap", "flexdashboard","DT")

install.packages(packages)
```

## References

- [Kristin Stock, Hans Guesgen, in Automating Open Source Intelligence, 2016](https://www.elsevier.com/books/T/A/9780128029169)
- [Edzer Pebesma, Daniel Nüst, and Roger Bivand, “The R Software Environment in Reproducible Geoscientific Research,” Eos 93 (2012): 163–164.](https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1029/2012EO160003)  
- [Edzer Pebesma, Roger Bivand, Spatial Data Science](https://keen-swartz-3146c4.netlify.app/)
- [Robin Lovelace, Jakub Nowosad, Jannes Muenchow, "Geocomputation with R"](https://geocompr.robinlovelace.net/spatial-class.html)
- [Leaflet for R](https://rstudio.github.io/leaflet/)
- [Wilkinson, Leland, and Graham Wills. 2005. The Grammar of Graphics. Springer Science+ Business Media.](https://www.springer.com/de/book/9780387245447)
- [Paula Moraga, Geospatial Health Data: Modeling and Visualization with R-INLA and Shiny, 2019](https://www.paulamoraga.com/book-geospatial/index.html)
- [DT: An R interface to the DataTables library](https://rstudio.github.io/DT/)


