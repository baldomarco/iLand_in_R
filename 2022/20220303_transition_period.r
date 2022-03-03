# install.packages("RSQLite")
library(RSQLite)

# Path to search the data
dataroot <- ("C:/iland_data_test/20220217/")

# Name of the database
file_cc <-paste0(dataroot,"Cz_region_20220214_BAU_management_all_stps_and_constrains_small_area.sqlite")   # file to read
file_sw <-paste0(dataroot,"Cz_region_20220214_BAU_SW_management_all_stps_and_constrains_small_area.sqlite")   # file to read

# connect to the database of clearcut model
sqlite.driver <- dbDriver("SQLite")
db1 <- dbConnect(sqlite.driver, dbname = file_cc)  # connect to the file
tables.in.the.file<-dbListTables(db1)           # explore the tables in the file
print(tables.in.the.file)

# connect to the database of clearcut model
sqlite.driver <- dbDriver("SQLite")
db2 <- dbConnect(sqlite.driver, dbname = file_sw)  # connect to the file
tables.in.the.file<-dbListTables(db2)           # explore the tables in the file
print(tables.in.the.file)

#-----------------------------------------------
# READ IN different tables:    (here can read in by table names.... depending on what you have in your outputfile)

carbon_cc <- dbReadTable(db1,"carbon")
# wind <- dbReadTable(db1,"wind")
# barkbeetle <- dbReadTable(db1,"barkbeetle")
# lremoved <- dbReadTable(db1,"landscape_removed")
landscape_cc <- dbReadTable(db1,"landscape")
abeUnit_cc <- dbReadTable(db1, "abeUnit")
dynamicStand_cc <- dbReadTable(db1, "dynamicstand")
# abeStand <- dbReadTable(db1, "abeStand")
# stand <- dbReadTable(db1, "stand")

dbDisconnect(db1)    # close the file
carbon_sw <- dbReadTable(db2,"carbon")
# wind <- dbReadTable(db2,"wind")
# barkbeetle <- dbReadTable(db2,"barkbeetle")
# lremoved <- dbReadTable(db2,"landscape_removed")
landscape_sw <- dbReadTable(db2,"landscape")
abeUnit_sw <- dbReadTable(db2, "abeUnit")
dynamicstand_sw <- dbReadTable(db2, "dynamicstand")
#abeStand <- dbReadTable(db2, "abeStand")
#stand <- dbReadTable(db2, "stand")

dbDisconnect(db2)    # close the file


# Make a plot with ggplot, volume, colored by species for the transitional period for Clear cut management system

library(ggplot2)

ggplot(landscape_cc, aes(year,volume_m3, fill=species))+
  geom_area()

ggplot(landscape_cc, aes(year,volume_m3))+
  geom_line(color = "steelblue")

# Make a plot with ggplot Basal Area by species (in landscape output), for the transitional period

ggplot(landscape_cc, aes(year,basal_area_m2, fill=species))+
  geom_area()

ggplot(landscape_cc, aes(year,basal_area_m2))+
  geom_line(color = "steelblue")

# ggplot(abeStand, aes(year,volume, fill=standid))+   
#   geom_line()

# the same Volume and basal area by species but for Shelterwood management system

ggplot(landscape_sw, aes(year,volume_m3, fill=species))+
  geom_area()

ggplot(landscape_sw, aes(year,volume_m3))+
  geom_line(color = "steelblue")

# Make a plot with ggplot Basal Area by species (in landscape output), for the transitional period

ggplot(landscape_sw, aes(year,basal_area_m2, fill=species))+
  geom_area()

ggplot(landscape_sw, aes(year,basal_area_m2))+
  geom_line(color = "steelblue")


# create the histogram of Volume/ DBH by species
library(dplyr)

#Clear cut

ggplot(landscape_cc, aes(year,dbh_avg_cm, fill=species))+
  geom_area()

ggplot(landscape_cc, aes(year,dbh_avg_cm))+
  geom_line(color = "steelblue")

# Shelterwood

ggplot(landscape_sw, aes(year,dbh_avg_cm, fill=species))+
  geom_area()

ggplot(landscape_sw, aes(year,dbh_avg_cm))+
  geom_line(color = "steelblue")


hist(landscape_cc$year, landscape_cc$dbh_avg_cm)



