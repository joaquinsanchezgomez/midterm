#Joaquin Sanchez Gomez & Holli Tai
#midterm

install.packages("tidyverse")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("flexdashboard")
install.packages("plotly")
install.packages("leaflet")
install.packages("dygraphs")
install.packages("metricsgraphics")
install.packages("readr")


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

colnames(DUI_Crashes)


accident_list <- list(Distracted_Driver_Crashes,DUI_Crashes,Fixed_Object_Crashes,Intersection_Crashes,Motorcycle_Crashes,Non_Motorist_Crashes,Older_Driver_Crashes,Pedestrian_Crashes,Unlicensed_Driver_Crashes,Work_Zone_Crashes,Wrong_Way_Crashes,Young_Driver_Crashes)
accident_list

accident_data_frame <- accident_list %>% reduce(full_join, by='CrashID')
accident_data_frame

