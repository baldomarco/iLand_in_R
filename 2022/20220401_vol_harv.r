# install.packages("RSQLite")
library(RSQLite)
library(dplyr)

# Path to search the data
dataroot <- ("C:/lab/iLand/iLand_starting_after_spinup/output/")

# Name of the database
file_cc <-paste0(dataroot,"Cz_region_20220325_BAU_cc_management.sqlite")   # file to read
file_sw <-paste0(dataroot,"Cz_region_20220325_BAU_sw_management.sqlite")   # file to read

# connect to the database of clearcut model
sqlite.driver <- dbDriver("SQLite")
db1 <- dbConnect(sqlite.driver, dbname = file_cc)  # connect to the file
tables.in.the.file1<-dbListTables(db1)           # explore the tables in the file
print(tables.in.the.file1)

# connect to the database of clearcut model
sqlite.driver <- dbDriver("SQLite")
db2 <- dbConnect(sqlite.driver, dbname = file_sw)  # connect to the file
tables.in.the.file2<-dbListTables(db2)           # explore the tables in the file
print(tables.in.the.file2)

#-----------------------------------------------
# READ IN different tables:    (here can read in by table names.... depending on what you have in your outputfile)
carbonflow_cc <- dbReadTable(db1, "carbonflow")
carbon_cc <- dbReadTable(db1,"carbon")
wind_cc <- dbReadTable(db1,"wind")
barkbeetle_cc <- dbReadTable(db1,"barkbeetle")
landscape_cc <- dbReadTable(db1,"landscape")
abeUnit_cc <- dbReadTable(db1, "abeUnit")
dynamicstand_cc <- dbReadTable(db1, "dynamicstand")
abeStand_cc <- dbReadTable(db1, "abeStand")
stand_cc <- dbReadTable(db1, "stand")
dbDisconnect(db1)    # close the file

carbonflow_sw <- dbReadTable(db2, "carbonflow")
carbon_sw <- dbReadTable(db2,"carbon")
wind_sw <- dbReadTable(db2,"wind")
barkbeetle_sw <- dbReadTable(db2,"barkbeetle")
landscape_sw <- dbReadTable(db2,"landscape")
abeUnit_sw <- dbReadTable(db2, "abeUnit")
dynamicstand_sw <- dbReadTable(db2, "dynamicstand")
abeStand_sw <- dbReadTable(db2, "abeStand")
stand_sw <- dbReadTable(db2, "stand")
dbDisconnect(db2)    # close the file


# Make a plot with ggplot, volume, colored by species for the transitional period for Clear cut management system

library(ggplot2)

library(gridExtra)   #  install!!


#-----------------------------------------
g1 <- ggplot(landscape_cc, aes(year,volume_m3, fill=species))+
  geom_area() +
  ggtitle("Clear Cut")+
  ylab("Volume m3/ha")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,600)

g2 <- ggplot(landscape_sw, aes(year,volume_m3, fill=species))+
  geom_area() +
  ggtitle("Shelterwood")+
  ylab("Volume m3/ha")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,600)

#grid.arrange(g1,g2,ncol=2)
grid.arrange(g1,g2,ncol=1)


dim(abeUnit_cc)

## cumulative sum of the volume harvested
# Clear Cut 

abeUnit_cc$cum_harvest_cc <- cumsum(abeUnit_cc$realizedHarvest)

ggplot(abeUnit_cc, aes(x=year, y=cum_harvest_cc)) +
  geom_line() +
  labs(x='year', y='Cumulative harvest')


## cumulative sum of the volume harvested
# shelterwood 

abeUnit_sw$cum_harvest_sw <- cumsum(abeUnit_sw$realizedHarvest)

ggplot(abeUnit_sw, aes(x=year, y=cum_harvest_sw)) +
  geom_line() +
  labs(x='year', y='Cumulative harvest')

# plot the 2 function together for the CC and SW

h1<-data.frame(year=abeUnit_cc$year, harvest=cumsum(abeUnit_cc$realizedHarvest), case="clearcut")
h2<-data.frame(year=abeUnit_sw$year, harvest=cumsum(abeUnit_sw$realizedHarvest), case="shelterwood")

head(h1)
head(h2)

harvests<- rbind(h1,h2)
summary(harvests)
dim(harvests)

ggplot(harvests, aes(year,log(harvest), color=case))+
  geom_line(size=1.2)+
  ggtitle("Realized Cumulative Harvest Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest m3/ha")+
  theme_bw()


#   colums:  year,  harvest,  case (CC or SW)
#-----------------------------------------

a1<-data.frame(year=abeUnit_cc$year, harvest=abeUnit_cc$realizedHarvest, case="clearcut")
a2<-data.frame(year=abeUnit_sw$year, harvest=abeUnit_sw$realizedHarvest, case="shelterwood")

head(a1)
head(a2)

harvests<- rbind(a1,a2)
summary(harvests)
dim(harvests)

ggplot(harvests, aes(year,harvest, color=case))+
  geom_line(size=1.2)+
  ggtitle("Realized Harvest Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest m3/ha")+
  theme_bw()


ggplot(harvests, aes(year,harvest))+
  geom_line(size=1.2)+
  facet_wrap(~case, ncol=1)+
  ggtitle("Realized Harvest Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest m3/ha")+
  theme_bw()

#-----------------------------------------
