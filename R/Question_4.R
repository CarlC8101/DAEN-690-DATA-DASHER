library(tidyverse)
library(tidymodels)
library(vip)
library(car)
library(ggplot2)
library(visreg)
library(lsr)

df <- read.csv("C:/Users/sampa/OneDrive/Desktop/GMU/Spring_2021/Dataset/cleandata_q3q4.csv")

my_data1 <- drop_na(select(df,Shift,FireStation,PatientOutcome))
my_data1

zz10 <- mutate(my_data1, Shift = ifelse(Shift == "A - Shift", 1, 
                                     ifelse(Shift == "B - Shift", 2, 3)))

zz11 <- mutate(zz10, PatientOutcome = ifelse(PatientOutcome == "Treated & Transported ", 1, 
                                         ifelse(PatientOutcome == "Standby (No Services Performed)", 2, 
                                                ifelse(PatientOutcome == "Treated, Transferred Care ", 3, 
                                                       ifelse(PatientOutcome == "Standby (Operational Support Provided)", 4, 
                                                              ifelse(PatientOutcome == "Patient Refusal  (AMA)", 5, 
                                                                     ifelse(PatientOutcome == "Patient Dead at Scene (No EMS CPR)", 6, 
                                                                            ifelse(PatientOutcome == "Patient Dead at Scene (EMS CPR Attempted)", 7, 
                                                                                   ifelse(PatientOutcome == "No Treatment/Transport Required", 8, 
                                                                                          ifelse(PatientOutcome == "No Patient Found", 9, 
                                                                                                 ifelse(PatientOutcome == "EMS Assist (Other Agency)", 10, 
                                                                                                        ifelse(PatientOutcome == "Canceled (Prior to Arrival) ", 11, 12))))))))))))
zz11

zz111 <- my_data1[!my_data1$PatientOutcome == "NULL", ]
ggplot(zz111, 
       aes(x = Shift, 
           fill = PatientOutcome)) + 
  geom_bar(position = "stack")

ggplot(zz111, 
       aes(x = FireStation, 
           fill = PatientOutcome)) + 
  geom_bar(position = "stack")

cor.test(zz11$FireStation, zz11$PatientOutcome)
cor.test(zz11$Shift, zz11$PatientOutcome)

chisq.test(zz111$Shift, zz111$PatientOutcome)

mytable <- table(zz111$Shift, zz111$PatientOutcome)
n<-sum(mytable)
q<-min(nrow(mytable),ncol(mytable))

chi2<- unname(chisq.test(mytable, correct = FALSE)$statistic)

v<-sqrt(chi2/(n*(q-1)))
v
#install.packages("lsr")
#library(lsr)
cramersV(mytable)


zz2 <- mutate(zz111, FireStation = ifelse(FireStation == 1, "McLean", 
                                        ifelse(FireStation == 2, "Vienna",  
                                               ifelse(FireStation == 4, "Herndon", 
                                                      ifelse(FireStation == 5, "Franconia", 
                                                             ifelse(FireStation == 8, "Annandale", 
                                                                    ifelse(FireStation == 9, "Mount Vernon", 
                                                                           ifelse(FireStation == 10, "Bailey's Crossroads",
                                                                                  ifelse(FireStation == 11, "Penn Daw", 
                                                                                         ifelse(FireStation == 12, "Great Falls", 
                                                                                                ifelse(FireStation == 13, "Dunn Loring",
                                                                                                       ifelse(FireStation == 14, "Burke", 
                                                                                                              ifelse(FireStation == 15, "Chantilly",
                                                                                                                     ifelse(FireStation == 16, "Clifton",
                                                                                                                            ifelse(FireStation ==17, "Centreville",
                                                                                                                                   ifelse(FireStation == 18, "Jefferson",
                                                                                                                                          ifelse(FireStation== 19, "Lorton",       
                                                                                                                                                 ifelse(FireStation==20, "Gunston", 
                                                                                                                                                        ifelse(FireStation==21, "Fair Oaks",
                                                                                                                                                               ifelse(FireStation==22, "Springfield",
                                                                                                                                                                      ifelse(FireStation==23, "West Annandale",
                                                                                                                                                                             ifelse(FireStation==24, "Woodlawn",
                                                                                                                                                                                    ifelse(FireStation==25, "Reston",
                                                                                                                                                                                           ifelse(FireStation==26, "Edsall Road",
                                                                                                                                                                                                  ifelse(FireStation==27, "West Springfield",
                                                                                                                                                                                                         ifelse(FireStation==28, "Seven Corners",
                                                                                                                                                                                                                ifelse(FireStation==29, "Tysons Corner",
                                                                                                                                                                                                                       ifelse(FireStation==30, "Merrifield",
                                                                                                                                                                                                                              ifelse(FireStation==31, "Fox Mill",
                                                                                                                                                                                                                                     ifelse(FireStation==32, "Fairview",
                                                                                                                                                                                                                                            ifelse(FireStation==34, "Oakton",
                                                                                                                                                                                                                                                   ifelse(FireStation==35, "Pohick",
                                                                                                                                                                                                                                                          ifelse(FireStation==36, "Frying Pan", 
                                                                                                                                                                                                                                                                 ifelse(FireStation==37, "Kingstowne",
                                                                                                                                                                                                                                                                        ifelse(FireStation==38, "West Centreville", 
                                                                                                                                                                                                                                                                               ifelse(FireStation==39, "North Point",
                                                                                                                                                                                                                                                                                      ifelse(FireStation==40, "Fairfax Center",
                                                                                                                                                                                                                                                                                             ifelse(FireStation==41, "Crosspointe",
                                                                                                                                                                                                                                                                                                    "Wolftrap"))))))))))))))))))))))))))))))))))))))
zz2

chisq.test(zz2$FireStation, zz2$PatientOutcome)

#CramersV
mytable1 <- table(zz2$FireStation, zz2$PatientOutcome)
cramersV(mytable1)
