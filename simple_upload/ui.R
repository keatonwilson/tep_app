#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
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
                     h4('Your power summary from uploaded data:'),
                     tableOutput('upload_check'), 
                     br(),
                     h4('Your estimated costs are:'),
                     tableOutput('summary_table')
                 )
             )
)

