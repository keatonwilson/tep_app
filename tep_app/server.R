#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

#Data munging function
source("./power_breakdown.R")

#Data calculations function
source("./tep_plans.R")


#Custom TEP calculcation functions
server <- function(input, output) {
        if(is.null(input$file1)) {
            output$table_costs_summer <- renderTable({
                tep_plans_summer(total_kwh_on = input$total_on, 
                      total_kwh_off = input$total_off,
                      max_kw_in_hour = input$max_kW)
            })
            output$table_costs_winter<- renderTable({
            tep_plans_winter(total_kwh_on = input$total_on_w, 
                             total_kwh_off = input$total_off_w,
                             max_kw_in_hour = input$max_kW_w)
            })
            
        } else {
        
            df = read_csv(input$file1$datapath, skip = 1)
            summary_df = power_summary(df)
    
                if(summary_df$season == "summer") {
                    output$table_costs_data_upload <- renderTable({
                        tep_plans(total_kwh_on = summary_df$total_peak,
                                  total_kwh_off = summary_df$total_offpeak,
                                  max_kw_in_hour = summary_df$max_1hour)
                    })
                } else {
                    output$table_costs_data_upload<- renderTable({
                        tep_plans_winter(total_kwh_on = summary_df$total_peak,
                                         total_kwh_off = summary_df$total_offpeak,
                                         max_kw_in_hour = summary_df$max_1hour)
                    })
                }    
        }
        
}
