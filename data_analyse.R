# get count and Percentage for each type 
all_q <- all_q %>% arrange(start_time)

counttypestrip <- all_q %>% count(usertype)

print(counttypestrip)
percentages <- all_q %>%
  count(usertype) %>%
  mutate(Percentage = round((n / sum(n)) * 100, 1))
print(percentages)
 
#get the averages of trip time for each user type 
library(dplyr)
avg_tripduration <- all_q %>%
  group_by(usertype) %>%
  summarize(average_duration = mean(tripduration, na.rm = TRUE))
print(avg_tripduration)

# Find the most used day for each user_type
most_used_day <- all_q %>%
  group_by(usertype, day_name) %>%  # Group by user_type and date
  summarize(usage_count = n()) %>%  # Count the number of usages per day for each user_type
  group_by(usertype)
most_used_day <- most_used_day %>% arrange(usertype,usage_count)
print(most_used_day)

#number of trips every mounth 
mounth_use <- all_q %>%
  group_by(usertype, month_name) %>%  # Group by user_type and date
  summarize(usage_count = n()) 
print(mounth_use)  

#################
sub_all_q <- data.frame()
# Extract the time of day from the date_time column

sub_all_q <- all_q %>%
  mutate(start_time = as.POSIXct(start_time, format = "%Y-%m-%d %H:%M:%S"), 
         hour_of_day = format(start_time, "%H")) 

sub_all_q <- sub_all_q %>%
  select(-birthyear,-gender,-to_station_name,-to_station_id,-from_station_name,-from_station_id,-tripduration,-bikeid,-end_time,-trip_id)
sub_all_q <- sub_all_q %>%
  select(-age,-month_name,-day_name,-start_time)


# Find the most used time for each user_type
most_used_time <- sub_all_q %>%
  group_by(usertype, hour_of_day) %>%  # Group by user_type and time_of_day
  summarize(usage_count = n()) %>%      # Count the number of times each time is used
  group_by(usertype)   # Get the most used time for each user_type

print(most_used_time)

####################################
avg_age <- all_q %>%
  group_by(usertype, gender) %>% 
  summarize(average_age = mean(age))

print(avg_age)

#####################################

gender_count <- all_q %>%
  group_by(usertype, gender) %>%  
  summarize(gender_count = n())

print(gender_count)





