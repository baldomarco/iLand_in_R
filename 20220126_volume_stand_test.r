# Create the first analysis report. I create the first plots and graphs using the stands of part of the CZ case study for a 75 year Time series in iLand forest model. I select 7 different stands and after a period of 75 years. I compared the wood volume dynamics in this different stand. I also compared the volume at the DBH in one stand, and a superficial boxplot statistical and logarithm analysis for one "RU".

# install.packages("RSQLite")
library(RSQLite)



file<-"C:/iland_data_test/20220125/Cz_region_20220125_BAU_management_all_stps_and_constrains.sqlite"   # file to read


sqlite.driver <- dbDriver("SQLite")
db1 <- dbConnect(sqlite.driver, dbname = file)  # connect to the file
tables.in.the.file<-dbListTables(db1)           # explore the tables in the file
print(tables.in.the.file)


#-----------------------------------------------
# READ IN different tables:    (here can read in by table names.... depending on what you have in your outputfile)

carbon <- dbReadTable(db1,"carbon")
# wind <- dbReadTable(db1,"wind")
# barkbeetle <- dbReadTable(db1,"barkbeetle")
# landscape??removed <- dbReadTable(db1,"landscape_removed")
landscape <- dbReadTable(db1,"landscape")
abeStand <- dbReadTable(db1, "abeStand")
stand <- dbReadTable(db1, "stand")

dbDisconnect(db1)    # close the file

# Make a plot with ggplot, volume, colored by species....

library(ggplot2)
ggplot(landscape, aes(year,volume_m3, fill=species))+
  geom_area()

ggplot(abeStand, aes(year,volume, fill=standid))+   
  geom_line()

# library(dplyr)
# subsetting: https://dplyr.tidyverse.org/reference/filter.html

# UFE    ID 3190 INDEX 2695 STP5 QURO
# UFE    ID 2155 INDEX 4154 STP5 FASY
# STATE FOREST (SF)  id 11413 index 5144 STP7 picea
# SF                 id 11301 index 6316 STP5 picea 

x <- filter(abeStand, standid == "2155")
stid1 <-ggplot(x, aes(year,volume) + 
                 geom_area() + 
                 ggtitle("Stand ID 2155 STP3 (Env5) fasy")
stid1 + theme(plot.title = element_text(hjust = 0.5))

ggplot(x, aes(dbh, volume)) + 
  ggtitle("Stand ID 2155/ correlation dbh - volume(m3)") +
  geom_line(colour = "blue") #find some code to cut part of the grafth or to set how many years plot


x1 <- filter(abeStand, standid == "3190")
stid2 <- ggplot(x1, aes(year,volume)) + 
  geom_area() + 
  ggtitle("Stand ID 3190 STP3 (Env5) quro")
stid2 + theme(plot.title = element_text(hjust = 0.5))


x2 <- filter(abeStand, standid == "11301")
stid3 <- ggplot(x2, aes(year, volume)) + 
  geom_area() + 
  ggtitle("Stand ID 11301 STP3 (Env5) piab")
stid3 + theme(plot.title =element_text(hjust = 0.5))

# Title of the graphics : http://www.sthda.com/english/wiki/ggplot2-title-main-axis-and-legend-titles
# +ggtitle("theme_tufte()") 
# GGPlot2 essentials r
# Machine Learning essentials r
# Practical Guide for Cluster Analysis essential r (unsupervised machine learning)


x3 <- filter(abeStand, standid == "11413")
stid3 <- ggplot(x3, aes(year, volume)) + 
  geom_area() + 
  ggtitle("Stand ID 11413 STP4 (Env7a) piab")
stid3 + theme(plot.title =element_text(hjust = 0.5))


_____________________________________________________
# volume-year x stand colour by species
spvol <- filter(stand, ru == "4154") # don't work because I need ru and this 4154 is index
ggplot(spvol, aes(year,volume_m3, fill=species))+ ggtitle("ID 2155")
  geom_area()

spvol2 <- filter(stand, ru == "2695")
ggplot(spvol2, aes(year,volume_m3, fill=species))+
  geom_area() + ggtitle("ID 3190 ")

spvol2 <- filter(stand, ru == "6316")
ggplot(spvol2, aes(year,volume_m3, fill=species)) +
  geom_area() + ggtitle("ID 11301")

summary(spvol$volume_m3)

boxplot(spvol$volume_m3)

z <- log10(spvol$volume_m3)

boxplot(z)

volume_year <- hist(spvol$volume_m3) 
summary (volume_year)
