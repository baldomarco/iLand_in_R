# R code for making analysis on stand volume and comparative analysis of volume stand


# NEEDED PACKAGES

library(RSQLite)                                                                # Package for reading sqlite databases
library(ggplot2)
library(dplyr)                                                                  # subsetting: https://dplyr.tidyverse.org/reference/filter.html
library(gridExtra)

#___________________________________________________________________________________________
dataroot <- ("C:/iLand/2022/test_harv/usm_0.5_hi_1_test7/")                                # As -setwd- but for the database root in the computer system

# CC
file_cc <-paste0(dataroot,"Cz_region_20220325_BAU_cc_management.sqlite")        # file to be read in this case database

sqlite.driver <- dbDriver("SQLite")                                             # import the driver for the connection at sqlite with R
db1 <- dbConnect(sqlite.driver, dbname = file_cc)                               # connect to the file
tables.in.the.file<- dbListTables(db1)                                         # explore the tables in the file and to import the elements (dataframe and matrix) into R console
print(tables.in.the.file)                                                       # see the element in the database

# READ IN different tables:                                                     # here can read in by table names depending on what you have in your outputfile

abeStand_cc <- dbReadTable(db1, "abeStand")
abeStandDetail_cc <- dbReadTable(db1, "abeStandDetail")
abeStandRemoval_cc <- dbReadTable(db1, "abeStandRemoval")
abeUnit_cc <- dbReadTable(db1, "abeUnit")
barkbeetle_cc <- dbReadTable(db1,"barkbeetle")
carbon_cc <- dbReadTable(db1,"carbon")
carbonflow_cc <- dbReadTable(db1,"carbonflow")
dynamicstand_cc <- dbReadTable(db1,"dynamicstand")
landscape_cc <- dbReadTable(db1,"landscape")
runinfo_cc <- dbReadTable(db1, "runinfo")
stand_cc <- dbReadTable(db1, "stand")
wind_cc <- dbReadTable(db1,"wind")

dbDisconnect(db1)                                                               # close the file
#_______________________________________________________________________________________________

# SW
file_sw <-paste0(dataroot,"Cz_region_20220325_BAU_sw_management.sqlite")

# SW 
sqlite.driver <- dbDriver("SQLite")                                             # import the driver for the connection at sqlite with R
db2 <- dbConnect(sqlite.driver, dbname = file_sw)                               # connect to the file
tables.in.the.file <- dbListTables(db2)                                         # explore the tables in the file and to import the elements (dataframe and matrix) into R console
print(tables.in.the.file)                                                       # see the element in the database

# READ IN different tables:                                                     # here can read in by table names depending on what you have in your outputfile

abeStand_sw <- dbReadTable(db2, "abeStand")
abeStandDetail_sw <- dbReadTable(db2, "abeStandDetail")
abeStandRemoval_sw <- dbReadTable(db2, "abeStandRemoval")
abeUnit_sw <- dbReadTable(db2, "abeUnit")
barkbeetle_sw <- dbReadTable(db2,"barkbeetle")
carbon_sw <- dbReadTable(db2,"carbon")
carbonflow_sw <- dbReadTable(db2,"carbonflow")
dynamicstand_sw <- dbReadTable(db2,"dynamicstand")
landscape_sw <- dbReadTable(db2,"landscape")
runinfo_sw <- dbReadTable(db2, "runinfo")
stand_sw <- dbReadTable(db2, "stand")
wind_sw <- dbReadTable(db2,"wind")

dbDisconnect(db2)
#_________________________________________________________________________________________
# Make plot with ggplot for the landscape volume in avarage and colored by species

# CC
v_cc <- ggplot(landscape_cc, aes(year,volume_m3, fill=species))+
          ggtitle("Landscape volume color by species in Clearcut management")+
          theme(plot.title = element_text(hjust = 0.5))+
          xlab("Year")+
          ylab("Volume (m3/ha)")+
          geom_area()+
          theme_bw()
  
v_cc <- v_cc + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22))
v_cc <- v_cc + theme(plot.title = element_text(hjust = 0.5))
v_cc <- v_cc + theme(axis.title.y = element_text(size = rel(1.8), angle = 90))
v_cc <- v_cc + theme(axis.title.x = element_text(size = rel(1.8), angle = 00))
v_cc

# SW
v_sw <- ggplot(landscape_sw, aes(year,volume_m3, fill=species))+
  ggtitle("Landscape volume color by species in Shelterwood management")+
  theme(plot.title = element_text(hjust = 0.5))+
  xlab("Year")+
  ylab("Volume (m3/ha)")+
  geom_area()+
  theme_bw()

v_sw <- v_sw + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22))
v_sw <- v_sw + theme(plot.title = element_text(hjust = 0.5))
v_sw <- v_sw + theme(axis.title.y = element_text(size = rel(1.8), angle = 90))
v_sw <- v_sw + theme(axis.title.x = element_text(size = rel(1.8), angle = 00))
v_sw
#_______________________________________________________________________________________


# ANALYSIS AT THE STAND LEVEL
# VOLUME

               x_cc <- filter(abeStand_cc, standid == "46404")
               stid <- ggplot (x_cc, aes(year,volume)) + geom_area() + ggtitle("Stand ID 46404 in Clearcut management") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) 
               x_cc <- stid + theme(plot.title = element_text(hjust = 0.5))
               
               x_sw <- filter(abeStand_sw, standid == "46404")
               stid <- ggplot (x_sw, aes(year,volume)) + geom_area() + ggtitle("Stand ID 46404 in Shelterwood management") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) 
               x_sw <- stid + theme(plot.title = element_text(hjust = 0.5))
               
               
               x1_cc <- filter(abeStand_cc, standid == "47559")
               stid1 <- ggplot(x1_cc, aes(year,volume)) + ggtitle("Stand ID 47559 in Clearcut management") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
                 geom_area() 
               x1_cc <- stid1 + theme(plot.title = element_text(hjust = 0.5))
               
               x1_sw <- filter(abeStand_sw, standid == "47559") 
               stid1 <- ggplot(x1_sw, aes(year,volume)) + ggtitle("Stand ID 47559 in Shelterwood management") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
                 geom_area()
               x1_sw <- stid1 + theme(plot.title = element_text(hjust = 0.5))
               
              
               x2_cc <- filter(abeStand_cc, standid == "11301")
               stid2 <- ggplot(x2_cc, aes(year, volume)) + ggtitle("Stand ID 11301 in Clearcut management") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
                 geom_area() 
               x2_cc <- stid2 + theme(plot.title =element_text(hjust = 0.5))
               
               x2_sw <- filter(abeStand_sw, standid == "11301")
               stid2 <- ggplot(x2_sw, aes(year, volume)) + ggtitle("Stand ID 11301 in Shelterwood management") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
               geom_area() 
               x2_sw <- stid2 + theme(plot.title =element_text(hjust = 0.5))
              
               
               x3_cc <- filter(abeStand_cc, standid == "11413")
               stid3 <- ggplot(x3_cc, aes(year, volume)) + ggtitle("Stand ID 11413 in Clearcut management") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
               geom_area()
               x3_cc <- stid3 + theme(plot.title =element_text(hjust = 0.5))
               
               x3_sw <- filter(abeStand_sw, standid == "11413")
               stid3 <- ggplot(x3_sw, aes(year, volume)) + ggtitle("Stand ID 11413 in Shelterwood management") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
                 geom_area()
               x3_sw <- stid3 + theme(plot.title =element_text(hjust = 0.5))
               
               #___________________________________________________________________________________
               # volume-year x stand color by species
               # to have a sense you have to pair stand id with ru, because ru is the output giving volume by species
               
               spvol_cc <- filter(stand_cc, ru == "4154")                                                    
               s_cc <- ggplot(spvol_cc, aes(year,volume_m3, fill=species)) + geom_area() + ggtitle("Stand ID 46404 in Clearcut management color by species") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) 
               
               spvol_sw <- filter(stand_sw, ru == "4154")   
               s_sw <- ggplot(spvol_sw, aes(year,volume_m3, fill=species)) + geom_area() + ggtitle("Stand ID 46404 in Shalterwood management color by species") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) 
               
               
               spvol1_cc <- filter(stand_cc, ru == "2695")
               s1_cc <- ggplot(spvol1_cc, aes(year,volume_m3, fill=species)) + ggtitle("Stand ID 47559 in Clearcut management color by species") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) + geom_area()
               
               spvol1_sw <- filter(stand_sw, ru == "2695")
               s1_sw <- ggplot(spvol1_sw, aes(year,volume_m3, fill=species)) + ggtitle("Stand ID 47559 in Shelterwood management color by species") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) + geom_area()
               
               
               spvol2_cc <- filter(stand_cc, ru == "6316") 
               s2_cc <- ggplot(spvol2_cc, aes(year,volume_m3, fill=species)) + ggtitle("Stand ID 11301 in Clearcut management color by species") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) + geom_area()
               
               spvol2_sw <- filter(stand_sw, ru == "6316") 
               s2_sw <- ggplot(spvol2_sw, aes(year,volume_m3, fill=species)) + ggtitle("Stand ID 11301 in Shelterwood management color by species") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) + geom_area()
               
               
               spvol3_cc <- filter(stand_cc, ru == "6317") 
               s3_cc <- ggplot(spvol3_cc, aes(year,volume_m3, fill=species)) + ggtitle("Stand ID 11302 in Clearcut management color by species") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) + geom_area()
               
               spvol3_sw <- filter(stand_sw, ru == "6317") 
               s3_sw <- ggplot(spvol3_sw, aes(year,volume_m3, fill=species)) + ggtitle("Stand ID 11302 in Shelterwood management color by species") + ylab("Volume (m3/ha)") + xlab("Year") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) + geom_area()
               
               #________________________________________________________________________________________________________
               # GRAPHICS
               
               # BY VOLUME
               grid.arrange(x_cc,x1_cc,x2_cc,x3_cc,x_sw,x1_sw,x2_sw,x3_sw, ncol=4)
               
               # BY SPECIES
               grid.arrange(s_cc,s1_cc,s2_cc,s3_cc,s_sw,s1_sw,s2_sw,s3_sw, ncol=4)
               
               # ALTERNATIVE
               plot <- rbind(x_cc,x_sw,x1_cc,x1_sw,x2_cc,x2_sw,x3_cc,x3_sw)
               
               plot <- ggplot(plot, aes(year,plot))+
                 geom_area()+
                 ggtitle("Title")+
                 theme(plot.title = element_text(hjust = 0.5))+
                 ylab("label title")+
                 theme_bw()
               
               # by species
               plot <- rbind(s_cc,s_sw,s1_cc,s1_sw,s2_cc,s2_sw,s3_cc,s3_sw)
               
               plot <- ggplot(plot, aes(year,plot))+
                 geom_area()+
                 ggtitle("Title")+
                 theme(plot.title = element_text(hjust = 0.5))+
                 ylab("label title")+
                 theme_bw()
               
               # To be implemented with some statistics
               __________________________________________________________
               summary(spvol$volume_m3)
               
               boxplot(spvol$volume_m3)
               
               z <- log10(spvol$volume_m3)
               
               boxplot(z)
               
               volume_year <- hist(spvol$volume_m3) 
               summary (volume_year)
               ___________________________________________________________
               
               
               # Up grading the knowladge on data processing
               
               # Title of the graphics : http://www.sthda.com/english/wiki/ggplot2-title-main-axis-and-legend-titles
               # +ggtitle("theme_tufte()") 
               # GGPlot2 essentials r
               # Machine Learning essentials r
               # Practical Guide for Cluster Analysis essential r (unsupervised machine learning)
               
               
               
               
               
               
               
