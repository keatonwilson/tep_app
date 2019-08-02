#Power munging
#Keaton Wilson

#packages
library(tidyverse)
library(lubridate)

power_summary = function(power_data) {
names(power_data) = c("type", "date",
                             "start_time", 
                             "end_time", 
                             "useage", 
                             "units", 
                             "notes")

power_data = power_data %>%
  mutate(date = mdy(date)) %>%
  mutate(week_day = wday(date)) %>%
  mutate(peak = ifelse(start_time == hm("15:00") |
                         start_time == hm("16:00") |
                         start_time == hm("17:00") |
                         start_time == hm("18:00") & week_day %in% c(1:5), 
                        "peak", "off-peak"))

summer = c(5,6,7,8,9)
winter = c(10,11,12,1,2,3,4)

season = ifelse(month(power_data$date[1]) %in% summer, "summer", "winter")

total_peak = power_data %>%
  filter(peak == "peak") %>%
  summarize(sum_peak = sum(useage))

total_offpeak = power_data %>%
  filter(peak == "off-peak") %>%
  summarize(total_offpeak = sum(useage))

max_1hour = power_data %>%
  summarize(max = max(useage))

summary_df = data.frame(season = season, 
                        total_peak = total_peak,
                        total_offpeak = total_offpeak, 
                        max_1hour = max_1hour)
return(summary_df)
}


