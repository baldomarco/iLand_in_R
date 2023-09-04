# install.packages("RSQLite")
library(RSQLite)

# Path to search the data
dataroot <- ("C:/iLand/20220307/")

# Name of the database
file_cc <-paste0(dataroot,"Cz_region_20220303_BAU_management.sqlite")   # file to read
file_sw <-paste0(dataroot,"Cz_region_20220303_BAU_SW_management.sqlite")   # file to read

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
carbonflow_cc <- dbReadTable(db1, "carbonflow")
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

carbonflow_sw <- dbReadTable(db2, "carbonflow")
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
  geom_area() +
  ggtitle("Clear Cut Volume Transitional Period by species")+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(abeUnit_cc, aes(year,volume))+
  geom_line(color = "steelblue") +
  ggtitle("Clear Cut Volume Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(abeUnit_cc, aes(year,realizedHarvest))+
  geom_line(color = "steelblue") +
  ggtitle("Clear Cut Realized Harvest Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(carbonflow_cc, aes(year,NPP))+
  geom_line(color = "steelblue") +
  ggtitle("Clear Cut NPP Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(landscape_cc, aes(year,LAI))+
  geom_area(color = "steelblue") +
  ggtitle("Clear Cut LAI Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))

# x <- c(carbonflow_cc$GPP, carbonflow_cc$NPP, carbonflow_cc$Rh, carbonflow_cc$NEP, carbonflow_cc$cumNPP, carbonflow_cc$cumRh, carbonflow_cc$cumNEP)

# make the species C kg time series single line per species

ggplot(data=landscape_cc, aes(x=year, y=total_carbon_kg, color=species)) + 
  geom_line()+
  ggtitle("Total Carbon per species time series in Clear cut") +
  theme(plot.title = element_text(hjust = 0.5))

#create pie chart
ggplot(landscape_cc, aes(x="", y=volume_m3, fill=species)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0)+
  ggtitle("Pie chart 400y avarage of landscape volume (m3) per species in Clear cut")

ggplot(landscape_cc, aes(x="", y=volume_m3, fill=species)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  theme_void()+
  ggtitle("Pie chart 400y avarage of landscape volume (m3) per species in Clear cut")

ggplot(landscape_cc, aes(x="", y=volume_m3, fill=species)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0(volume_m3, "%")), position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL)+
  ggtitle("Pie chart 400y avarage of landscape volume (m3) per species in Clear cut")

ggplot(landscape_cc, aes(x="", y=volume_m3, fill=species)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0(volume_m3, "%")), position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL) +
  theme_classic() +
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()) +
  # to work you have add all the color for variable...-> scale_fill_manual(values=c("#FF5733", "#75FF33", "#33DBFF", "#BD33FF"))+
  ggtitle("Pie plot of avarage of 400y of landscape volume (m3) per species in Clear cut")

# Make a plot with ggplot Basal Area by species (in landscape output), for the transitional period

ggplot(landscape_cc, aes(year,basal_area_m2, fill=species))+
  geom_area() +
  ggtitle("Clear Cut Basal Area Transitional Period by species")+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data=landscape_cc, aes(x=year, y=basal_area_m2, color=species)) + 
  geom_line() +
  ggtitle("Basal Area per species time series in Clear cut")+
  theme(plot.title = element_text(hjust = 0.5))


# ggplot(dynamicStand_cc, aes(year,basalarea_sum))+
#  geom_line(color = "steelblue") +
#  ggtitle("Clear Cut Basal Area Transitional Period")+
#  theme(plot.title = element_text(hjust = 0.5))


# ggplot(abeStand, aes(year,volume, fill=standid))+   
#   geom_line()

# the same Volume and basal area by species but for Shelterwood management system

ggplot(landscape_sw, aes(year,volume_m3, fill=species))+
  geom_area() +
  ggtitle("Shelterwood Volume Transitional Period by species")+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(abeUnit_sw, aes(year,volume))+
  geom_line(color = "steelblue") +
  ggtitle("SW Volume Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(abeUnit_sw, aes(year,realizedHarvest))+
  geom_line(color = "steelblue") +
  ggtitle("SW Realized Harvest Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(carbonflow_sw, aes(year,NPP))+
  geom_line(color = "steelblue") +
  ggtitle("SW NPP Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(landscape_sw, aes(year,LAI))+
  geom_area(color = "steelblue") +
  ggtitle("SW LAI Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))

# x <- c(carbonflow_cc$GPP, carbonflow_cc$NPP, carbonflow_cc$Rh, carbonflow_cc$NEP, carbonflow_cc$cumNPP, carbonflow_cc$cumRh, carbonflow_cc$cumNEP)

# make the species C kg time series single line per species

ggplot(data=landscape_sw, aes(x=year, y=total_carbon_kg, color=species)) + 
  geom_line()+
  ggtitle("Total Carbon per species time series in Shalterwood") +
  theme(plot.title = element_text(hjust = 0.5))

#create pie chart
ggplot(landscape_sw, aes(x="", y=volume_m3, fill=species)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0)+
  ggtitle("Pie chart 400y avarage of landscape volume (m3) per species in Shlterwood")

ggplot(landscape_sw, aes(x="", y=volume_m3, fill=species)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  theme_void()+
  ggtitle("Pie chart 400y avarage of landscape volume (m3) per species in Shalterwood")

ggplot(landscape_sw, aes(x="", y=volume_m3, fill=species)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0(volume_m3, "%")), position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL)+
  ggtitle("Pie chart 400 y avarage of landscape volume (m3) per species in Shalterwood")

ggplot(landscape_sw, aes(x="", y=volume_m3, fill=species)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0(volume_m3, "%")), position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL) +
  theme_classic() +
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()) +
  # to work you have add all the color for variable...-> scale_fill_manual(values=c("#FF5733", "#75FF33", "#33DBFF", "#BD33FF"))+
  ggtitle("Pie plot of avarage of 400y of landscape volume (m3) per species in Clear cut")

# Make a plot with ggplot Basal Area by species (in landscape output), for the transitional period

ggplot(landscape_sw, aes(year,basal_area_m2, fill=species))+
  geom_area() +
  ggtitle("Shalterwood Basal Area Transitional Period by species")+
  theme(plot.title = element_text(hjust = 0.5))

ggplot(data=landscape_sw, aes(x=year, y=basal_area_m2, color=species)) + 
  geom_line() +
  ggtitle("Basal Area per species time series in shalterwood")+
  theme(plot.title = element_text(hjust = 0.5))


# create the histogram of Volume/ DBH by species
# library(dplyr)

#Clear cut

ggplot(landscape_cc, aes(year,dbh_avg_cm, fill=species))+
  geom_area() +
  ggtitle("Clear Cut DBH Transitional Period by species")+
  theme(plot.title = element_text(hjust = 0.5))


# work with the filter to separate the species

#ggplot(dynamicStand_cc, aes(year, dbh_mean, fill=species)) +
#  geom_point() +
#  stat_smooth()

ggplot(data=dynamicStand_cc, aes(x=year,y=dbh_mean, color=species))+
  geom_line() +
  ggtitle("DBH mean Transitional Period by species in Clear Cut")+
  theme(plot.title = element_text(hjust = 0.5))


# Shelterwood

ggplot(landscape_sw, aes(year,dbh_avg_cm, fill=species))+
  geom_area() +
  ggtitle("Shelterwood DBH Transitional Period by species")+
  theme(plot.title = element_text(hjust = 0.5))


#ggplot(landscape_sw, aes(year,dbh_avg_cm))+
#  geom_line(color = "steelblue") +
#  ggtitle("Shelterwood DBH Transitional Period")+
#  theme(plot.title = element_text(hjust = 0.5))

ggplot(data=dynamicStand_cc, aes(x=year,y=dbh_mean, color=species))+
  geom_line() +
  ggtitle("DBH mean Transitional Period by species in Clear Cut")+
  theme(plot.title = element_text(hjust = 0.5))



hist(landscape_cc$year, landscape_cc$dbh_avg_cm, main= 'Clear Cut DBH Transitional Period')

hist(landscape_sw$year, landscape_sw$dbh_avg_cm, main= 'Shalterwood DBH Transitional Period')

########################  Relation between DBH and Volume in the transition period

# Clear cut

ggplot(landscape_cc, aes(volume_m3,dbh_avg_cm, fill=species))+
  geom_area() +
  ggtitle("Clear Cut V-DBH Transitional Period by species")+
  theme(plot.title = element_text(hjust = 0.5))


ggplot(landscape_cc, aes(volume_m3,dbh_avg_cm))+
  geom_line(color = "steelblue") +
  ggtitle("Clear Cut V-DBH Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))


# Shelterwood

ggplot(landscape_sw, aes(volume_m3,dbh_avg_cm, fill=species))+
  geom_area() +
  ggtitle("Shelterwood V-DBH Transitional Period by species")+
  theme(plot.title = element_text(hjust = 0.5))


ggplot(landscape_sw, aes(volume_m3,dbh_avg_cm))+
  geom_line(color = "steelblue") +
  ggtitle("Shelterwood V-DBH Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))


hist(dynamicStand_cc$dbh_mean, main= 'Clear Cut V-DBH Transitional Period')

hist(dynamicstand_sw$dbh_mean, abeUnit_sw$volume, main= 'Shalterwood Vol-DBH Transitional Period')


#________________________________________________________________________________________________________________

ggplot(dynamicStand_cc, aes(year, if_dbh_40_and_dbh_60_volume_0_sum, fill=species))+
  geom_area() +
  ggtitle("Clear cut Volume based on DBH class 20-40cm Transitional Period by species")+
  theme(plot.title = element_text(hjust = 0.5))


ggplot(dynamicstand_sw, aes(year, if_dbh_40_and_dbh_60_volume_0_sum, fill=species))+
  geom_area() +
  ggtitle("Shelterwood Volume based on DBH class 20-40cm Transitional Period by species")+
  theme(plot.title = element_text(hjust = 0.5))




ggplot(data=dynamicstand_sw, aes(x=year, y= X_if_dbh_20_and_dbh_40_volume_0_sum, color=species)) + 
  geom_line() +
  ggtitle("Basal Area per species time series in shalterwood")+
  theme(plot.title = element_text(hjust = 0.5))


plot(dynamicstand_sw$year, dynamicstand_sw$if_dbh_40_and_dbh_60_volume_0_sum)


library(dplyr)

dynamicStand_cc %>%
  filter (year==0, species=="piab")

dynamicStand_cc %>%
  filter (year==400, species=="piab")

dynamicStand_cc %>%
  filter (species=="piab")%>%
  arrange(X_if_dbh_20_and_dbh_40_volume_0_sum)

landscape_cc %>%
  filter(species=="piab","fasy","")%>%
  mutate(volume_piab= sum(volume_m3))
  
  
  
  
#plot(dynamicStand_cc$species$piab, X_if_dbh_20_and_dbh_40_volume_0_sum)

# Report 

# needed to work properly with latex

tinytex::install_tinytex()
tinytex::tlmgr_update()

# libraries needed for knitr report

library (knitr)
library (tinytex)         # librerie necessarie


# vedi la funzione stitch e trova altri template da qui. https://rdrr.io/cran/knitr/man/stitch.html
# I hided only warnings #delete the warning, message and codes in the report.
# To hide the warnings use the code here or go in the link to study other functionalities

knitr::opts_chunk$set(warning = FALSE, message = FALSE, echo = TRUE)

stitch("C:/lab/tp_report.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))  
