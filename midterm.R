#Joaquin Sanchez Gomez & Holli Tai
#midterm

library(tidyverse)
library(flexdashboard)
library(plotly)
library(leaflet)
library(dygraphs)
library(metricsgraphics)


getwd

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

list.files()

Young_Driver_Crashes <- Young_Driver_Crashes <- read.csv("Young_Driver_Crashes.csv")
head(Young_Driver_Crashes)

Wrong_Way_Crashes <- read.csv("Wrong_Way_Crashes.csv")
head(Wrong_Way_Crashes)

Work_Zone_Crashes <- read.csv("Work_Zone_Crashes.csv")
View(Work_Zone_Crashes)

Unlicensed_Driver_Crashes <- read.csv("Unlicensed_Driver_Crashes.csv")
View(Unlicensed_Driver_Crashes)

Pedestrian_Crashes <- read.csv("Pedestrian_Crashes.csv")
View(Pedestrian_Crashes)

Older_Driver_Crashes <- read.csv("Older_Driver_Crashes.csv")
head(Older_Driver_Crashes)

Non_Motorist_Crashes <- read.csv("Non_Motorist_Crashes.csv")
head(Non_Motorist_Crashes)

Motorcycle_Crashes <- read.csv("Motorcycle_Crashes.csv")
View(Motorcycle_Crashes)

Intersection_Crashes <- read.csv("Intersection_Crashes.csv")
View(Intersection_Crashes)

Fixed_Object_Crashes <- read.csv("Fixed_Object_Crashes.csv")
View(Fixed_Object_Crashes)

DUI_Crashes <- read.csv("DUI_Crashes.csv")
View(DUI_Crashes)

Distracted_Driver_Crashes <- read.csv("Distracted_Driver_Crashes.csv")
View(Distracted_Driver_Crashes)

accidents_CT <- bind_rows(Distracted_Driver_Crashes,DUI_Crashes,Fixed_Object_Crashes,Intersection_Crashes,Motorcycle_Crashes,Non_Motorist_Crashes,Older_Driver_Crashes,Pedestrian_Crashes,Unlicensed_Driver_Crashes,Work_Zone_Crashes,Wrong_Way_Crashes,Young_Driver_Crashes)

accidents_CT <- accidents_CT %>% distinct()

accidents_CT %>% group_by(CrashID) %>% count() %>% filter(n >1)

accidents_CTex <- Fixed_Object_Crashes %>% mutate(Fixed_Object=1) %>% select(CrashID, Fixed_Object) %>% distinct(CrashID, .keep_all = TRUE) %>%
  right_join(., accidents_CT, by=c("CrashID"))


accidents_CTex <- Distracted_Driver_Crashes %>% mutate(Distracted=1) %>% select(CrashID, Distracted) %>% distinct(CrashID, .keep_all = TRUE) %>%
  right_join(., accidents_CTex, by=c("CrashID"))

accidents_CTex <- DUI_Crashes %>% mutate(DUI=1) %>% select(CrashID, DUI) %>% distinct(CrashID, .keep_all = TRUE) %>%
  right_join(., accidents_CTex, by=c("CrashID"))

accidents_CTex <- Intersection_Crashes %>% mutate(Intersection=1) %>% select(CrashID, Intersection) %>% distinct(CrashID, .keep_all = TRUE) %>%
  right_join(., accidents_CTex, by=c("CrashID"))

accidents_CTex <- Motorcycle_Crashes %>% mutate(Moto=1) %>% select(CrashID, Moto) %>% distinct(CrashID, .keep_all = TRUE) %>%
  right_join(., accidents_CTex, by=c("CrashID"))

accidents_CTex <- Non_Motorist_Crashes %>% mutate(Non_motorist=1) %>% select(CrashID, Non_motorist) %>% distinct(CrashID, .keep_all = TRUE) %>%
  right_join(., accidents_CTex, by=c("CrashID"))

accidents_CTex <- Older_Driver_Crashes %>% mutate(Old_people=1) %>% select(CrashID, Old_people) %>% distinct(CrashID, .keep_all = TRUE) %>%
  right_join(., accidents_CTex, by=c("CrashID"))

accidents_CTex <- Pedestrian_Crashes %>% mutate(Pedestrian=1) %>% select(CrashID, Pedestrian) %>% distinct(CrashID, .keep_all = TRUE) %>%
  right_join(., accidents_CTex, by=c("CrashID"))

accidents_CTex <- Unlicensed_Driver_Crashes %>% mutate(Unlicensed=1) %>% select(CrashID, Unlicensed) %>% distinct(CrashID, .keep_all = TRUE) %>%
  right_join(., accidents_CTex, by=c("CrashID"))

accidents_CTex <- Work_Zone_Crashes %>% mutate(Work_zone=1) %>% select(CrashID, Work_zone) %>% distinct(CrashID, .keep_all = TRUE) %>%
  right_join(., accidents_CTex, by=c("CrashID"))

accidents_CTex <- Wrong_Way_Crashes %>% mutate(wrong_way=1) %>% select(CrashID, wrong_way) %>% distinct(CrashID, .keep_all = TRUE) %>%
  right_join(., accidents_CTex, by=c("CrashID"))

accidents_CTex <- Young_Driver_Crashes %>% mutate(young_driver=1) %>% select(CrashID, young_driver) %>% distinct(CrashID, .keep_all = TRUE) %>%
  right_join(., accidents_CTex, by=c("CrashID"))


accidents_CTex <- accidents_CTex %>% replace(is.na(.),0)


stamford <- accidents_CTex[accidents_CTex$CrashTownName == "Stamford", ]
stamford


### Drivers' age graph

sum(stamford$young_driver == 1)

sum(stamford$Old_people == 1)

age_people <- data_frame(group=c("Young",
                                "Old drivers" ),
                         value= c(8722,5492))



library(ggplot2)

ggplot(age_people, aes(x = group, y = value, fill = group)) +
  geom_bar(stat = "identity", width = 0.5) +
  labs(title = "Accidents by Age Group", x = "Group", y = "Value")







accidents_per_year <-stamford %>%group_by(CrashDateYear) %>% count() %>% arrange(desc(n))

colnames(accidents_per_year)[2]='NumberofCrashes'
colnames(accidents_per_year)[1]='Year'






###  

p <- ggplot(data=accidents_per_year,aes(x=Year,y=NumberofCrashes, fill=Year)) +
  geom_bar(stat='identity')


Crashes_Per_Year<- p + ggtitle("Stamford, CT: Accidents per Year") +
  xlab("Year") + ylab("Crash Count")

ggplotly(Crashes_Per_Year)




###  

most_day <- stamford %>%group_by(DayofWeek) %>% count %>% arrange(desc(n))


colnames(most_day)[1]='DayofWeek'
colnames(most_day)[2]='Crashes'

day <- ggplot(data=most_day,aes(x=DayofWeek,y=Crashes, fill=DayofWeek)) +
  geom_bar(stat='identity')


days_most_crashes <-day + ggtitle("Crashes by Day of Week") +
  xlab("Day of Week") + ylab ("Crash Count")


ggplotly(days_most_crashes)

###  
Week_Hour <-stamford %>%group_by(DayofWeek,CrashTimeHour) %>% count %>% arrange(desc(n))

colnames(Week_Hour)[1]='Day of Week'
colnames(Week_Hour)[2]='Hour'
colnames(Week_Hour)[3]='Crashes'
datatable(
  head(Week_Hour),
  caption = 'Quantity of Crashes by Day and Hour')




