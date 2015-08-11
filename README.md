# Weighted College Price

This is a Shiny application that allows the user to interactively view the change in geographically-weighted average county-level college price from 1997 to 2012. Data and analyses for this application come from a working paper that can be viewed here:

[Estimating the Education-Earnings Equation Using Geographic Variation](http://papers.ssrn.com/sol3/papers.cfm?abstract_id=2639267)

#### Authors

[Will Doyle](https://my.vanderbilt.edu/willdoyle/)  
[Benjamin Skinner](http://btskinner.me)

## To run locally: no file download

```R
## shiny library
library(shiny)

## run from GitHub
runGitHub('colcost', 'btskinner')

## run from the tar or zip file directly
runUrl('https://github.com/rstudio/colcost/archive/master.tar.gz')
runUrl('https://github.com/rstudio/colcost/archive/master.zip')
```

## To run locally: download files

Clone the git, switch into the directory, and use `runApp()`:

```R
## shiny library
library(shiny)

## change directory into local version of colcost
setwd('/path/to/cloned/colcost')
runApp()
```

## To run online

If you don't want to download the files or install Shiny locally on your machine, you can interact with the Shiny application at shinyapps.io:

[https://btskinner.shinyapps.io/colcost](https://btskinner.shinyapps.io/colcost)