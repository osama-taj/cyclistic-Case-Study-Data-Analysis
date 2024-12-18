q1=read.csv("Divvy_Trips_2019_Q1.csv")
q2=read.csv("Divvy_Trips_2019_Q2.csv")
q3=read.csv("Divvy_Trips_2019_Q3.csv")
q4=read.csv("Divvy_Trips_2019_Q4.csv")
#install.packages("tidyverse")
library(tidyverse)
library(dplyr)
#change the header names to meat names  in the rest file 
q2 <- q2 %>%
  rename(
    trip_id = X01...Rental.Details.Rental.ID,
    start_time = X01...Rental.Details.Local.Start.Time,
    end_time = X01...Rental.Details.Local.End.Time,
    bikeid=X01...Rental.Details.Bike.ID,
      tripduration=X01...Rental.Details.Duration.In.Seconds.Uncapped,
      from_station_id=X03...Rental.Start.Station.ID,
      from_station_name=X03...Rental.Start.Station.Name,
      to_station_id=X02...Rental.End.Station.ID,
      to_station_name=X02...Rental.End.Station.Name,
      usertype=User.Type,
      gender=Member.Gender,
      birthyear=X05...Member.Details.Member.Birthday.Year
    )

library(lubridate)

q3 <- q3 %>%
  mutate(
    start_time = format(ymd_hms(start_time), "%m/%d/%Y %H:%M:%S"),
    end_time = format(ymd_hms(end_time), "%m/%d/%Y %H:%M:%S")
    )
#q3 <- q3 %>%
  #mutate(
  #  end_time = format(ymd_hms(end_time), "%m/%d/%Y %H:%M:%S")
 # )
q4 <- q4 %>%
  mutate(
    start_time = format(ymd_hms(start_time), "%m/%d/%Y %H:%M:%S"),
    end_time = format(ymd_hms(end_time), "%m/%d/%Y %H:%M:%S")
  )
#q4 <- q4 %>%
  #mutate(
   # end_time = format(ymd_hms(end_time), "%m/%d/%Y %H:%M:%S")
  #)
###########################
q1 <- q1 %>%
  mutate(
    end_time = mdy_hm(end_time) %>% format("%Y-%m-%d %H:%M:%S") %>% ymd_hms(),
    start_time = mdy_hm(start_time) %>% format("%Y-%m-%d %H:%M:%S") %>% ymd_hms()
  )
q2 <- q2 %>%
  mutate(
    end_time = mdy_hm(end_time) %>% format("%Y-%m-%d %H:%M:%S") %>% ymd_hms(),
    start_time = mdy_hm(start_time) %>% format("%Y-%m-%d %H:%M:%S") %>% ymd_hms()
  )
q3 <- q3 %>%
  mutate(
    end_time = mdy_hms(end_time) %>% format("%Y-%m-%d %H:%M:%S") %>% ymd_hms(),
    start_time = mdy_hms(start_time) %>% format("%Y-%m-%d %H:%M:%S") %>% ymd_hms()
  )
q4 <- q4 %>%
  mutate(
    end_time = mdy_hms(end_time) %>% format("%Y-%m-%d %H:%M:%S") %>% ymd_hms(),
    start_time = mdy_hms(start_time) %>% format("%Y-%m-%d %H:%M:%S") %>% ymd_hms()
  )

###########################

all_q <- bind_rows(q1, q2,q3,q4)
# cheak the null value for the DF 
na_counts <- colSums(is.na(all_q))
print(na_counts)


all_q <- all_q %>%
  mutate(
    day_name = wday(start_time, label = TRUE, abbr = FALSE),  # Full day name
    month_name = month(start_time, label = TRUE, abbr = FALSE)  # Full month name
  )

all_q <- all_q %>%
  mutate(
    gender = ifelse(nchar(gender) > 0, substr(gender, 1, 1), "N")
  )
all_q <- all_q %>%
  mutate(
    age = ifelse(is.na(birthyear), 0, 2024-birthyear)
  )

#all_q <- subset(all_q, select = -obj)#delete obj

all_q$tripduration <- as.numeric(all_q$tripduration)# change the data  type of trip duration  
all_q <- all_q %>%
  mutate(
    tripduration = ifelse(
      is.na(tripduration) , 
      as.numeric(difftime(end_time, start_time, units = "secs")), # If tripduration time is NA, set duration
      tripduration # else set the same value 
    )
  )


 str(all_q)
 




