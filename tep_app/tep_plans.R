#Summer
tep_plans_summer <- function(total_kwh_on, total_kwh_off, max_kw_in_hour){
  df <- data.frame(matrix(ncol = 2, nrow = 4))
  colnames(df) <- c('plan', 'estimated cost per month')
  df$plan <- c('Basic', 'TOU', 'Demand', 'Demand TOU')
  
  total_kwh_used <- total_kwh_on + total_kwh_off
  # basic
  first_500_basic <- ifelse(total_kwh_used >= 500 , 10.2*500, 10.2*total_kwh_used)
  second_500_basic <- ifelse(total_kwh_used >= 500 & total_kwh_used <= 1000, 
                             11.7*(total_kwh_used-500), 
                             ifelse(total_kwh_used > 1000, 11.7*500, 0))
  rest_basic <- ifelse(total_kwh_used > 1000, 12.5*(total_kwh_used-1000), 0)
  fee_basic <- 1300
  total_basic <- (first_500_basic + second_500_basic + rest_basic + fee_basic)/100
  df[df$plan == 'Basic', 'estimated cost per month'] <- total_basic
  # tou
  first_500_on_tou <- ifelse(total_kwh_on >= 500, 500*13.87, 13.87*total_kwh_on)
  second_500_on_tou <- ifelse(total_kwh_on > 500 & total_kwh_on <= 1000, 
                              14.77*(total_kwh_on-500), 
                              ifelse(total_kwh_on > 1000, 14.77*500, 0))
  rest_on_tou <- ifelse(total_kwh_on > 1000, 15.52*(total_kwh_on-1000), 0)
  
  first_500_off_tou <- ifelse(total_kwh_off >= 500, 500*9.85, 9.85*total_kwh_off)
  second_500_off_tou <- ifelse(total_kwh_off > 500 & total_kwh_off <= 1000, 
                               10.75*(total_kwh_off-500), 
                               ifelse(total_kwh_off > 1000, 10.75*500, 0))
  rest_off_tou <- ifelse(total_kwh_off > 1000, 11.3*(total_kwh_off-1000), 0)
  # add and make dollars
  on_peak_tou <- (first_500_on_tou + second_500_on_tou + rest_on_tou)/100 
  off_peak_tou <- (first_500_off_tou + second_500_off_tou + rest_off_tou)/100 
  
  fee_tou <- 10 # 10 dollars
  total_tou <- on_peak_tou + off_peak_tou + fee_tou
  df[df$plan == 'TOU', 'estimated cost per month'] <- total_tou
  
  
  # demand
  per_kwh_demand <- (total_kwh_used * 6.98)/100 # convert to dollars
  
  kw_add_demand <- ifelse(max_kw_in_hour < 7, 
                          max_kw_in_hour * 8.85, 
                          ((7*8.85) + ((max_kw_in_hour - 7)*12.85)))
  fee_demand <- 10
  total_demand <- per_kwh_demand + kw_add_demand + fee_demand
  df[df$plan == 'Demand', 'estimated cost per month'] <- total_demand
  
  
  # demand_tou
  kwh_on_demand_tou <- (total_kwh_on * 10.06)/100
  kwh_off_demand_tou <- (total_kwh_off * 6.03)/100
  kw_add_demand_tou <- ifelse(max_kw_in_hour < 7, 
                              max_kw_in_hour * 8.85, 
                              ((7*8.85) + ((max_kw_in_hour - 7)*12.85)))
  fee_demand_tou <- 10
  total_demand_tou <- kwh_on_demand_tou + kwh_off_demand_tou + 
    kw_add_demand_tou + fee_demand_tou
  df[df$plan == 'Demand TOU', 'estimated cost per month'] <- total_demand_tou
  return(df)
}

#Winter
tep_plans_winter <- function(total_kwh_on, total_kwh_off, max_kw_in_hour){
  df_winter <- data.frame(matrix(ncol = 2, nrow = 4))
  colnames(df_winter) <- c('plan', 'estimated cost per month')
  df_winter$plan <- c('Basic', 'TOU', 'Demand', 'Demand TOU')
  
  total_kwh_used <- total_kwh_on + total_kwh_off
  # basic
  first_500_basic <- ifelse(total_kwh_used >= 500 , 9.87*500, 9.87*total_kwh_used)
  second_500_basic <- ifelse(total_kwh_used >= 500 & total_kwh_used <= 1000, 
                             11.37*(total_kwh_used-500), 
                             ifelse(total_kwh_used > 1000, 11.37*500, 0))
  rest_basic <- ifelse(total_kwh_used > 1000, 11.92*(total_kwh_used-1000), 0)
  fee_basic <- 1300
  total_basic <- (first_500_basic + second_500_basic + rest_basic + fee_basic)/100
  df_winter[df_winter$plan == 'Basic', 'estimated cost per month'] <- total_basic
  
  # tou
  first_500_on_tou <- ifelse(total_kwh_on >= 500, 500*10.47, 10.47*total_kwh_on)
  second_500_on_tou <- ifelse(total_kwh_on > 500 & total_kwh_on <= 1000, 
                              11.37*(total_kwh_on-500), 
                              ifelse(total_kwh_on > 1000, 11.37*500, 0))
  rest_on_tou <- ifelse(total_kwh_on > 1000, 11.92*(total_kwh_on-1000), 0)
  
  first_500_off_tou <- ifelse(total_kwh_off >= 500, 500*9.78, 9.78*total_kwh_off)
  second_500_off_tou <- ifelse(total_kwh_off > 500 & total_kwh_off <= 1000, 
                               10.68*(total_kwh_off-500), 
                               ifelse(total_kwh_off > 1000, 10.68*500, 0))
  rest_off_tou <- ifelse(total_kwh_off > 1000, 11.23*(total_kwh_off-1000), 0)
  # add and make dollars
  on_peak_tou <- (first_500_on_tou + second_500_on_tou + rest_on_tou)/100 
  off_peak_tou <- (first_500_off_tou + second_500_off_tou + rest_off_tou)/100 
  
  fee_tou <- 10 # 10 dollars
  total_tou <- on_peak_tou + off_peak_tou + fee_tou
  df_winter[df_winter$plan == 'TOU', 'estimated cost per month'] <- total_tou
  
  
  # demand
  per_kwh_demand <- (total_kwh_used * 6.65)/100 # convert to dollars
  kw_add_demand <- ifelse(max_kw_in_hour < 7, 
                          max_kw_in_hour * 8.85, 
                          ((7*8.85) + ((max_kw_in_hour - 7)*12.85)))
  fee_demand <- 10
  total_demand <- per_kwh_demand + kw_add_demand + fee_demand
  df_winter[df_winter$plan == 'Demand', 'estimated cost per month'] <- total_demand
  
  # demand_tou
  kwh_on_demand_tou <- (total_kwh_on * 6.69)/100
  kwh_off_demand_tou <- (total_kwh_off * 5.69)/100
  kw_add_demand_tou <- ifelse(max_kw_in_hour < 7, 
                              max_kw_in_hour * 8.85, 
                              ((7*8.85) + ((max_kw_in_hour - 7)*12.85)))
  fee_demand_tou <- 10
  total_demand_tou <- kwh_on_demand_tou + kwh_off_demand_tou + 
    kw_add_demand_tou + fee_demand_tou
  df_winter[df_winter$plan == 'Demand TOU', 'estimated cost per month'] <- total_demand_tou
  return(df_winter)
}