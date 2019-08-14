#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- navbarPage('Select Season',
                 tabPanel('Summer',
                          
                          fluidPage(
                              sidebarPanel(HTML(
                                  paste(
                                      h3('TEP Bill Calculator'), 
                                      '<br>', 
                                      h4('Below you can calulate your estimated bill during the summer for each of TEP\'s power plans.  Just enter your estimated on- and off-peak kWh usage as well as the  max kW used in a single hour for the month'))),
                                  br(),
                                  numericInput('total_on', 
                                               'total kWh usage on-peak', 300,
                                               min = 1, max = 4000),
                                  numericInput('total_off', 
                                               'total kWh usage off-peak', 1000,
                                               min = 1, max = 4000),
                                  numericInput('max_kW', 'max kW used in an hour over the month', 6,
                                               min = 0.1, max = 30)
                              ),
                              mainPanel(
                                  h4('Your estimated cost is'),
                                  tableOutput('table_costs_summer')
                              )
                          )
                 ),
                 tabPanel('Winter',
                          
                          fluidPage(
                              sidebarPanel(HTML(
                                  paste(
                                      h3('TEP Bill Calculator'), 
                                      '<br>', 
                                      h4('Below you can calulate your estimated bill during the winter for each of TEP\'s power plans.  Just enter your estimated on- and off-peak kWh usage as well as the  max kW used in a single hour for the month'))),
                                  br(),
                                  numericInput('total_on_w', 
                                               'total kWh usage on-peak', 100,
                                               min = 1, max = 4000),
                                  numericInput('total_off_w', 
                                               'total kWh usage off-peak', 700,
                                               min = 1, max = 4000),
                                  numericInput('max_kW_w', 'max kW used in an hour over the month',4,
                                               min = 0.1, max = 30)
                              ),
                              mainPanel(
                                  h4('Your estimated cost is'),
                                  tableOutput('table_costs_winter')
                              )
                          )
                 ),
                 tabPanel('Data Upload',

                          fluidPage(
                              sidebarPanel(HTML(
                                  paste(
                                      h3('TEP Bill Calculator'),
                                      '<br>',
                                      h4("Upload your monthly csv file from TEP below, we'll take care of the rest..."))),
                                  br(),
                                  fileInput("file1", "Choose CSV File",
                                            accept = c("text/csv",
                                                       "text/comma-separated-values,
                                                       text/plain",
                                                       ".csv"))
                              ),
                              mainPanel(
                                  h4('Your estimated cost is'),
                                  tableOutput('table_costs_data_upload')
                              )
                          )
                 )
)

