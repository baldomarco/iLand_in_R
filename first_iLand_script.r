## WE CONSIDER THE TEST FOR ONE STAND VOLUME IN ILAND

                                  #### first report for iLand #######
                                  

# install.packages("RSQLite")
library(RSQLite)



file<-"D:/TEST_folder_2/output/subregion_medium_test1.sqlite"   # file to read


sqlite.driver <- dbDriver("SQLite")
db1 <- dbConnect(sqlite.driver, dbname = file)  # connect to the file
tables.in.the.file<-dbListTables(db1)           # explore the tables in the file
print(tables.in.the.file)


#-----------------------------------------------
# READ IN different tables:    (here can read in by table names.... depending on what you have in your outputfile)

carbon <- dbReadTable(db1,"carbon")
# wind <- dbReadTable(db1,"wind")
# barkbeetle <- dbReadTable(db1,"barkbeetle")
# lremoved <- dbReadTable(db1,"landscape_removed")
landscape <- dbReadTable(db1,"landscape")
abeStand <- dbReadTable(db1, "abeStand")
stand <- dbReadTable(db1, "stand")

dbDisconnect(db1)    # close the file

# Make a plot with ggplot, volume, colored by species....

library(ggplot2)
ggplot(landscape, aes(year,volume_m3, fill=species))+
  geom_area()

# ggplot(abeStand, aes(year,volume, fill=standid))+   
#   geom_line()

library(dplyr)

# subsetting: https://dplyr.tidyverse.org/reference/filter.html


x <- filter(abeStand, standid == "2021")
stid1 <-ggplot(x, aes(year,volume)) + geom_area() + ggtitle("CZ Stand ID 2021 (Initial Volume 0.0 m3, area 4.5 ha)")
stid1 + theme(plot.title = element_text(hjust = 0.5))

ggplot(x, aes(dbh, volume)) + 
  ggtitle("Stand RU 2742/ correlation dbh - volume(m3)") +
  geom_line(colour = "blue")


x1 <- filter(abeStand, standid == "414")
stid2 <- ggplot(x1, aes(year,volume)) + geom_area() + ggtitle("CZ Stand ID 414 (initial volume 1411 m3, area 17 ha)")
stid2 + theme(plot.title = element_text(hjust = 0.5))


x2 <- filter(abeStand, ru == "2032")
stid3 <- ggplot(x2, aes(year, volume)) + geom_area() + ggtitle("CZ Stand ID 2032 (initial volume 359 m3, area 10 ha)")
stid3 + theme(plot.title =element_text(hjust = 0.5))

# Title of the graphics : http://www.sthda.com/english/wiki/ggplot2-title-main-axis-and-legend-titles
# +ggtitle("theme_tufte()") 
# GGPlot2 essentials r
# Machine Learning essentials r
# Practical Guide for Cluster Analysis essential r (unsupervised machine learning)


x3 <- filter(abeStand, standid == "428")
stid3 <- ggplot(x3, aes(year, volume)) + 
  geom_area() + ggtitle("CZ Stand ID 428 (initial volume 1868 m3, area 0.7)")
stid3 + theme(plot.title =element_text(hjust = 0.5))


x4 <- filter(abeStand, standid == "417")
stid3 <- ggplot(x4, aes(year, volume)) + 
  geom_area() + ggtitle("CZ Stand ID 417 (initial volume 3.6, area 9 ha)")
stid3 + theme(plot.title =element_text(hjust = 0.5))


x5 <- filter(abeStand, standid == "68")
stid3 <- ggplot(x5, aes(year, volume)) + 
  geom_area() + ggtitle("Cz Stand ID 68 (int. volume 207.12 m3, 3.34 ha)")
stid3 + theme(plot.title =element_text(hjust = 0.5))

x6 <- filter(abeStand, standid == "749")
stid3 <- ggplot(x6, aes(year, volume)) + 
  geom_area() + ggtitle("Cz Stand ID 68 (int. volume 30 m3, 0.97 ha)")
stid3 + theme(plot.title =element_text(hjust = 0.5))


# volume-year x stand colour by species
spvol <- filter(abeStand, ru == "2742")
stid1 <- ggplot(spvol, aes(year,volume_m3, fill=species)) + 
  geom_area() + ggtitle("Cz Stand ID 2742 (STP1 -> STP2)")
stid1 + theme(plot.title =element_text(hjust = 0.5))


spvol2 <- filter(stand, ru == "247")
stid2 <- ggplot(spvol2, aes(year,volume_m3, fill=species))+
  geom_area() + ggtitle("Cz Stand ID 247 (STP2)")
stid2 + theme(plot.title =element_text(hjust = 0.5))


spvol3 <- filter(stand, ru == "2224")
stid3 <- ggplot(spvol3, aes(year,volume_m3, fill=species)) +
  geom_area() + ggtitle("Cz Stand ID 2224 (STP1)")
stid3 + theme(plot.title =element_text(hjust = 0.5))


spvol4 <- filter(stand, ru == "2219")
stid4 <- ggplot(spvol4, aes(year,volume_m3, fill=species)) +
  geom_area() + ggtitle("Cz Stand ID 2219 (STP2)")
stid4 + theme(plot.title =element_text(hjust = 0.5))


spvol5 <- filter(stand, ru == "1589")
stid5 <- ggplot(spvol5, aes(year,volume_m3, fill=species))+
  geom_area() + ggtitle("Cz Stand ID 1589 (STP2 -> STP1)")
stid5 + theme(plot.title =element_text(hjust = 0.5))


summary(spvol$volume_m3)

boxplot(spvol$volume_m3)

z <- log10(spvol$volume_m3)

boxplot(z)

volume_year <- hist(spvol$volume_m3) 
summary (volume_year)

