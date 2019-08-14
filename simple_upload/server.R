#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

#Data munging function
source("./power_breakdown.R")

#Data calculations function
source("./tep_plans.R")

#Custom TEP calculcation functions
server <- function(input, output) {
  
    output$upload_check = renderTable({
        
        req(input$file1)
        
        df = read_csv(input$file1$datapath, 
                      skip = 1)
        summ_df = power_summary(df)
        
        return(summ_df)
    })
    
    output$summary_table = renderTable({
        req(input$file1)
        
        df = read_csv(input$file1$datapath, 
                      skip = 1)
        summ_df = power_summary(df)
        
        if (summ_df$season == "summer") {
          tep_plans_summer(total_kwh_on = summ_df$sum_peak,
                           total_kwh_off = summ_df$total_offpeak,
                           max_kw_in_hour = summ_df$max)
        } else {
          tep_plans_winter(total_kwh_on = summ_df$sum_peak,
                           total_kwh_off = summ_df$total_offpeak,
                           max_kw_in_hour = summ_df$max)
        }
      
    })
        

}
