library(shiny)

###################################################################################################
## TEXTS
###################################################################################################

## ---------------------------------------
## INTERACTIVE MAPS
## ---------------------------------------


helptext <- 'View the change in average county-level college price from 1997 to 2012.'

citeline <- 'Data from "Estimating the Education-Earnings Equation Using Geographic
            Variation," a paper prepared and presented by William R. Doyle
            and Benjamin T. Skinner at the Association for American Education
            Finance and Policy 40th Annual Conference, 27 February 2015,
            Washington, D.C.'

## ---------------------------------------
## METHODOLOGY
## ---------------------------------------

## data
census <- 'County population center coordinates were taken from the 2000 and 2010
           United States Census. Because our study period spans from 1997 to 2012,
           coordinates from the 2000 census were used for the years 1997 to 2005
           while the 2012 coordinates were used for years thereafter.'

ipeds <- 'College coordinates and costs were taken from IPEDS variables for published tuition in
         each year of the study period. In the case of public institutions,
         the lower of in-state and in-district were used. All dollar amounts
         are inflation-adjusted to 2013 dollars to show the change in real dollars
         over time.'

## visulization text
visualizetext <- 'The following images are meant to give a visual example of how the distance-weighted
                  average price measures were computed for each county in each year.'

## figures
fig1text <- 'Figure 1 uses Williamson County, TN, as an example county. The population center
             coordinates are used as the origin point for distance measures to sample schools.'

fig2text <- 'Figure 2 shows the location of all public two-year colleges in the area. The legend
             shows the average price of all public two-year colleges in 2012 as well as the
             average price for similar colleges only in Tennessee. These would be the unweighted
             average price for Williamson County if it shared the same price as all US counties/
             Tennessee counties, respectively.'

fig3text <- 'Figure 3 shows how the geodesic distance measure links Williamson County to all
             public four-year colleges (including those not shown for clarity). The weighted
             average price for Williamson County is changed as a function of this distance
             from the unweighted average price.'

fig4text <- 'Figure 4 is similar to Figure 3 except that the sample of public two-year colleges
             is limited to those instate.'

## equations
initext <- 'The weighted average pric (WAP) of college for each United States county
           in the lower 48 in each year is computed using the following formula:'

WAP <- '$$WAP_{iy} = \\sum_{k = 1}^{K}\\frac{g_{ik}\\cdot price_{ky}}{\\sum_{k = 1}^{K} g_{ik}}$$'

text1 <- 'where \\(price_{ky}\\) is cost of institution \\(k\\) in year \\(y\\) and \\(g\\)
         is a weight for each cell. The weight \\(g\\) is defined as'

WAPw <- '$$g_{ik} = \\Bigg(\\frac{d_{ik}}{\\sum_{k=1}^K d_{ik}}\\Bigg)^{-r}$$'

text2 <- 'with \\(d_{ik}\\) as the geodesic distance in miles between the county population
         centroid \\(i\\) and institution \\(k\\) and \\(r\\) as the drop off rate of influence.'

text3a <- 'For every county in the sample across each sample year, we compute the
           geodesic distance to each postsecondary institution using the Vincenty computation formula
           in the R package '
text3b <- a('geosphere', href = 'http://cran.r-project.org/web/packages/geosphere/geosphere.pdf',
             target = '_blank')
text3c <- ', creating an \\(I \\times K\\) matrix where the sum of each row
          represents the total distance of all postsecondary institutions from the county and the
          fraction of each cell over the row total the proportional distance of
          each institution.  So that closer institutions carry more weight than
          farther ones, weights for each cell, \\(g_{ik}\\), are computed by
          dividing the inverse of the proportional distance by the row sum of
          the inverse proportional distances.  To change the rate at which distance has influence,
          the exponential term, \\(r\\), may be modified. At \\(r = 1\\), weights are a linear
          function of distance; when \\(r > 1\\), weights exponentially decay as distance
          increases. As \\(r\\) increases, the cost of the nearest institutions are
          up-weighted. In the limit, \\(r \\rightarrow \\infty\\), all weight will be
          placed on the nearest institution. We use a rate of \\(r = 2\\) to compute
          weights used to adjust the college price values for the interactive maps.'

text4a <- 'To compute the weighted average price for each county in each year,
          \\(WAP_{iy}\\), these weights are applied to a vector of yearly
          institutional costs, \\(price_{ky}\\), that are taken from IPEDS, and summed with
          that year. This results in an average postsecondary price for each county in each
          year. We repeat this process for different samples of schools: all Title IV
          schools, all public schools, all pubic four-year schools, and all public two-year
          schools. These different samples are represented by the '
text4b <- strong('College sample')
text4c <- ' dropdown menu on the interactive maps page. Within each school sample, we compute
          two sets of weights: one that allows out-of-state schools to figure in the weighted
          average price equation and another that limits the sample of schools to only those
          located in the same state as the county. These different computations are represented
          in the '
text4d <- strong('Weight computation')
text4e <- ' dropdown menu.'

## ---------------------------------------
## AUTHOR
## ---------------------------------------

wd <- 'Will Doyle is an associate professor of higher education in the department of
      Leadership, Policy and Organizations at Peabody College of Vanderbilt University.
      His research includes evaluating the impact of higher education policy, the
      antecedents and outcomes of higher education policy at the state level and the
      study of political behavior as it affects higher education.'

bs <- 'Benjamin Skinner is doctoral student in the Department of Leadership, Policy,
      and Organizations at Peabody College of Vanderbilt University.
      His research interests focus on community colleges and the non-traditional student
      populations that attend them. His work is particularly concerned with the
      infrastructural determinants of and/or barriers to successful matriculation,
      persistence, and graduation/transfer at these institutions (e.g. local economic
      opportunity, access to broadband internet).'

###################################################################################################
###################################################################################################

shinyUI(navbarPage('Weighted College Price',

                   ## =============================================================================
                   ## INTERACTIVE MAP PAGE
                   ## =============================================================================
                   
                   tabPanel('Maps',

                            fixedPage(
                                
                                fixedRow(
                                    
                                    column(9,
                                           plotOutput('map')
                                           ),
                                    
                                    column(3,
                                           h2('Maps'),
                                           helpText(helptext),
                                           
                                           br(),
                                           
                                           selectInput('sample1', 
                                                       label = 'College sample',
                                                       choices = list('All colleges','Public colleges',
                                                           'Public four year colleges',
                                                           'Public two year colleges'),
                                                       selected = 'Public four year colleges'),
                                           
                                           selectInput('sample2', 
                                                       label = 'Weight computation',
                                                       choices = list('Across state lines',
                                                           'Compare within state only'),
                                                       selected = 'Across state lines'),
                                           
                                           sliderInput('year', 
                                                       label = "Year",
                                                       min = 1997, max = 2012, step = 1,
                                                       sep = '',
                                                       value = 1997, round = TRUE, ticks = FALSE),
                                           br()
                                           
                                           )
                                ),
                                fixedRow(
                                    
                                    column(9,
                                           em(citeline)
                                           ),
                                    
                                    column(3,
                                           br()
                                           )
                                )
                            )
                            ),
                   
                   ## =============================================================================
                   ## METHODOLGY PAGE
                   ## =============================================================================
                   
                   tabPanel('Methodology',
                            fluidPage(
                                fluidRow(
                                    column(2,
                                           br()
                                           ),
                                    column(8,
                                           h1('Methodology'),
                                           br(),
                                           h2('Visualizing distance measure'),
                                           visualizetext,
                                           br(),
                                           br(),
                                           fluidRow(
                                               column(8,
                                                      em('Figure 1: Example county --- Williamson County, TN'),
                                                      img(src = 'general.png', width = '100%'),
                                                      br(),
                                                      br()
                                                      ),
                                               column(4,
                                                      br(),
                                                      fig1text
                                                      )
                                           ),
                                           fluidRow(
                                               column(8,
                                                      em('Figure 2: Area public two-year colleges'),
                                                      img(src = 'schools2yr.png', width = '100%'),
                                                      br(),
                                                      br()
                                                      ),
                                               column(4,
                                                      br(),
                                                      fig2text
                                                      )
                                           ),
                                           fluidRow(
                                               column(8,
                                                      em('Figure 3: Distance to all public two-year colleges'),
                                                      img(src = 'lines2yr.png', width = '100%'),
                                                      br(),
                                                      br()
                                                      ),
                                               column(4,
                                                      br(),
                                                      fig3text
                                                      )
                                           ),
                                           fluidRow(
                                               column(8,
                                                      em('Figure 4: Distance to in-state public two-year colleges'),
                                                      img(src = 'lines2yrinstate.png', width = '100%'),
                                                      br(),
                                                      br()
                                                      ),
                                               column(4,
                                                      br(),
                                                      fig4text
                                                      )
                                           ),
                                           br(),
                                           br(),
                                           h2('Weighted average price formulas'),
                                           initext,
                                           br(),
                                           br(),
                                           withMathJax(WAP),
                                           br(),
                                           withMathJax(text1),
                                           br(),
                                           br(),
                                           withMathJax(WAPw),
                                           br(),
                                           withMathJax(text2),
                                           br(),
                                           br(),
                                           withMathJax(text3a,text3b,text3c),
                                           br(),
                                           br(),
                                           withMathJax(text4a,text4b,text4c,text4d,text4e),
                                           br(),
                                           br(),
                                           h2('Data'),
                                           br(),
                                           h4('United States Census Bureau'),
                                           census,
                                           br(),
                                           br(),
                                           h4('Integrated Postsecondary Education Data System (IPEDS)'),
                                           ipeds,
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br()
                                           ),
                                    column(2,
                                           br()
                                           )
                                )
                            )
                            ),

                   ## =============================================================================
                   ## CONTACT PAGE
                   ## =============================================================================
                   
                   tabPanel('Authors',
                            fluidPage(
                                fluidRow(
                                    column(2,
                                           br()
                                           ),
                                    column(8,
                                           h1('Authors'),
                                           br(),
                                           h4('Will Doyle'),
                                           wd,
                                           a('Website',
                                             href = 'https://my.vanderbilt.edu/willdoyle/',
                                             target = '_blank'),
                                           br(),
                                           br(),
                                           br(),
                                           h4('Benjamin Skinner'),
                                           bs,
                                           a('Website',
                                             href = 'http://www.btskinner.me/',
                                             target = '_blank')
                                           ),
                                    column(2,
                                           br()
                                           )
                                )
                            )
                            )
                   )
        )
