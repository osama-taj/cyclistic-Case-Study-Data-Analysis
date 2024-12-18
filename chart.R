library(ggplot2)
mycolors <- c("#455A64","#00897B","#1E88E5")
# Bar chart showing the count of each user_type
ggplot(counttypestrip, aes(x = usertype, y = n ,fill = usertype)) +
  geom_bar(stat = "identity", ) +
  labs(title = "Count of Trips by User Type", x = "User Type", y = "Count") +
  scale_fill_manual(values = mycolors)
  
  
############################################
# Bar chart showing the percentage of each user_type

ggplot(percentages, aes(x = "", y = Percentage, fill = usertype)) +
  geom_bar(stat = "identity", width = 1 ,) +
  coord_polar(theta = "y") +
  geom_text(aes(label = paste0(round(Percentage, 1), "%")), 
            position = position_stack(vjust = 0.5), color = "white") +
  labs(title = "User Type Percentages") +
  theme_void() +
  scale_fill_manual(values = mycolors)
###############################################
#  chart ffor avg time duration 
ggplot(avg_tripduration, aes(x = usertype, y = average_duration / 60, fill = usertype ,)) +  # Convert seconds to minutes
  geom_bar(stat = "identity") +
  labs(title = "Average Trip Duration by User Type", x = "User Type", y = "Average Duration (minutes)") +
  theme_minimal() +
  theme(legend.position = "none")+
  scale_fill_manual(values = mycolors)
#################################################
# char for trip in days 
ggplot(most_used_day, aes(x = day_name, y = usage_count, color = usertype, group = usertype)) +
  geom_line(size = 1) +  # Line plot with a thickness of 1
  labs(title = "Number of Trips per Day by User Type", x = "Day", y = "Number of Trips") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  scale_color_manual(values = mycolors)

#################################################################
# char for trip in month
ggplot(mounth_use, aes(x = month_name, y = usage_count, color = usertype, group = usertype)) +
  geom_line(size = 1) +  # Line plot with a thickness of 1
  labs(title = "Number of Trips per Month by User Type", x = "Month", y = "Number of Trips") +
  theme_minimal() +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_color_manual(values = mycolors)
###############################################################
# char for trip in time day
ggplot(most_used_time, aes(x = hour_of_day, y = usage_count, color = usertype, group = usertype )) +
  geom_line(size = 1) +  # Line plot with a thickness of 1
  labs(title = "Number of Trips per houre by User Type", x = "hour", y = "Number of Trips") +
  theme_minimal() +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_color_manual(values = mycolors)

