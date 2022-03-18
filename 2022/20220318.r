# install.packages("RSQLite")
library(RSQLite)
library(dplyr)
library(fields)
______________________________________________
# Path to search the data
# 1 database with wind disturbances
dataroot <- ("C:/iLand/2022/20220314/")

# 1 Name of the database WIND (w)
file_cc_w <-paste0(dataroot,"Cz_region_20220314_BAU_cc_management.sqlite")   # file to read
file_sw_w <-paste0(dataroot,"Cz_region_20220314_BAU_sw_management.sqlite")   # file to read

#______________________________________________
# connect to the database of clearcut (cc) model with WIND
sqlite.driver <- dbDriver("SQLite")
db1 <- dbConnect(sqlite.driver, dbname = file_cc_w)  # connect to the file
tables.in.the.file<-dbListTables(db1)           # explore the tables in the file
print(tables.in.the.file)

# connect to the database of shelterwood (sw) model with WIND
sqlite.driver <- dbDriver("SQLite")
db2 <- dbConnect(sqlite.driver, dbname = file_sw_w)  # connect to the file
tables.in.the.file<-dbListTables(db2)           # explore the tables in the file
print(tables.in.the.file)

#______________________________________________
# READ IN different tables (present outputs):    (here can read in by table names.... depending on what you have in your outputfile)
# CC_W
carbonflow_cc_w <- dbReadTable(db1, "carbonflow")
carbon_cc_w <- dbReadTable(db1,"carbon")
wind_cc <- dbReadTable(db1,"wind")
landscape_cc_w <- dbReadTable(db1,"landscape")
abeUnit_cc_w <- dbReadTable(db1, "abeUnit")
dynamicstand_cc_w <- dbReadTable(db1, "dynamicstand")
dbDisconnect(db1)    # close the file

# SW_W
carbonflow_sw_w <- dbReadTable(db2, "carbonflow")
carbon_sw_w <- dbReadTable(db2,"carbon")
wind_sw <- dbReadTable(db2,"wind")
landscape_sw_w <- dbReadTable(db2,"landscape")
abeUnit_sw_w <- dbReadTable(db2, "abeUnit")
dynamicstand_sw_w <- dbReadTable(db2, "dynamicstand")
dbDisconnect(db2)    # close the file
#_______________________________________________

#_______________________________________________
# 2 database without wind disturbances
dataroot <- ("C:/iLand/2022/20220315/")

# 2 Name of the database
file_cc <-paste0(dataroot,"Cz_region_20220315_BAU_cc_management.sqlite")   # file to read
file_sw <-paste0(dataroot,"Cz_region_20220315_BAU_sw_management.sqlite")   # file to read

# connect to the database of clearcut model
sqlite.driver <- dbDriver("SQLite")
db3 <- dbConnect(sqlite.driver, dbname = file_cc)  # connect to the file
tables.in.the.file<-dbListTables(db3)           # explore the tables in the file
print(tables.in.the.file)

# connect to the database of shelterwood model
sqlite.driver <- dbDriver("SQLite")
db4 <- dbConnect(sqlite.driver, dbname = file_sw)  # connect to the file
tables.in.the.file<-dbListTables(db4)           # explore the tables in the file
print(tables.in.the.file)

#_______________________________________________
# READ IN different tables:    (here can read in by table names.... depending on what you have in your outputfile)
# CC
carbonflow_cc <- dbReadTable(db3, "carbonflow")
carbon_cc <- dbReadTable(db3,"carbon")
landscape_cc <- dbReadTable(db3,"landscape")
abeUnit_cc <- dbReadTable(db3, "abeUnit")
dynamicstand_cc <- dbReadTable(db3, "dynamicstand")
dbDisconnect(db3)    # close the file

# SW
carbonflow_sw <- dbReadTable(db4, "carbonflow")
carbon_sw <- dbReadTable(db4,"carbon")
landscape_sw <- dbReadTable(db4,"landscape")
abeUnit_sw <- dbReadTable(db4, "abeUnit")
dynamicstand_sw <- dbReadTable(db4, "dynamicstand")
dbDisconnect(db4)    # close the file

#_______________________________________________
# Make a plot with ggplot, volume, colored by species for the transitional period for Clear cut management system

library(ggplot2)
library(gridExtra) # To arrange the graphs in a grid

#_____________________________________________________________________________________
# Plot the transition period wood volume (m3/h) in disturbance regime color by species

# CC
ggplot(landscape_cc_w, aes(year,volume_m3, fill=species))+
  geom_area() +
  ggtitle("Clear Cut Volume Transitional Period by species in wind disturbance regime")+
  theme(plot.title = element_text(hjust = 0.5))

# SW
ggplot(landscape_sw_w, aes(year,volume_m3, fill=species))+
  geom_area() +
  ggtitle("Clear Cut Volume Transitional Period by species in wind disturbance regime")+
  theme(plot.title = element_text(hjust = 0.5))
#_____________________________________________________________
# PLOT THE TANSITION PERIOD (TP) VOLUME BY SPECIE IN COMPARABLE WAY (MULTI-WINDOW)
# TP IN WIND REGIME
#_____________________________________________
g1 <- ggplot(landscape_cc_w, aes(year,volume_m3, fill=species))+
  geom_area() +
  ggtitle("Clear Cut in disturbance regime")+
  ylab("Volume m3/ha")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,350)

g2 <- ggplot(landscape_sw_w, aes(year,volume_m3, fill=species))+
  geom_area() +
  ggtitle("Shelterwood in disturbance regime")+
  ylab("Volume m3/ha")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,350)

#grid.arrange(g1,g2,ncol=2)
grid.arrange(g1,g2,ncol=1)

#______________________________________________
# TP not diturbance regime

g3 <- ggplot(landscape_cc, aes(year,volume_m3, fill=species))+
  geom_area() +
  ggtitle("Clear Cut")+
  ylab("Volume m3/ha")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,350)

g4 <- ggplot(landscape_sw, aes(year,volume_m3, fill=species))+
  geom_area() +
  ggtitle("Shelterwood")+
  ylab("Volume m3/ha")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,350)

#grid.arrange(g1,g2,ncol=2)
grid.arrange(g3,g4,ncol=1)

#______________________________________________
# All the 4 graphics together

grid.arrange(g1,g2,g3,g4,ncol=2)

#______________________________________________
# HARVEST TIME SERIES IN DISTURBANCE REGIME

#-----------------------------------------

a1<-data.frame(year=abeUnit_cc_w$year, harvest=abeUnit_cc_w$realizedHarvest, case="Clear cut in disturbance regime")
a2<-data.frame(year=abeUnit_sw_w$year, harvest=abeUnit_sw_w$realizedHarvest, case="Shelterwood in disturbance regime")

head(a1)
head(a2)

harvests<- rbind(a1,a2)
summary(harvests)
dim(harvests)

x1 <- ggplot(harvests, aes(year,harvest, color=case))+
  geom_line(size=1.2)+
  ggtitle("Realized harvest transitional period in disturbance regime")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest m3/ha")+
  theme_bw()
x1 + theme(plot.title = element_text(hjust = 0.5))

x2 <-ggplot(harvests, aes(year,harvest))+
  geom_line(size=1.2)+
  facet_wrap(~case, ncol=1)+
  ggtitle("Realized harvest transitional period in disturbance regime")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest m3/ha")+
  theme_bw()
x2 + theme(plot.title = element_text(hjust = 0.5))

#_______________________________________________________________________________
# Realized harvest transition period in not disturbance regime

a3<-data.frame(year=abeUnit_cc$year, harvest=abeUnit_cc$realizedHarvest, case="Clear cut")
a4<-data.frame(year=abeUnit_sw$year, harvest=abeUnit_sw$realizedHarvest, case="Shelterwood")

head(a3)
head(a4)

harvests<- rbind(a3,a4)
summary(harvests)
dim(harvests)

x3 <- ggplot(harvests, aes(year,harvest, color=case))+
  geom_line(size=1.2)+
  ggtitle("Realized harvest transitional period")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest m3/ha")+
  theme_bw()
x3 + theme(plot.title = element_text(hjust = 0.5))

x4 <-ggplot(harvests, aes(year,harvest))+
  geom_line(size=1.2)+
  facet_wrap(~case, ncol=1)+
  ggtitle("Realized harvest transitional period")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest m3/ha")+
  theme_bw()
x4 + theme(plot.title = element_text(hjust = 0.5))

#_______________________________________________________________________________
# ALL 4 TOGETHER

harvests<- rbind(a1,a2,a3,a4)

x5 <- ggplot(harvests, aes(year,harvest, color=case))+
  geom_line(size=0.8)+
  ggtitle("Realized harvest transitional period")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest m3/ha")+
  theme_bw()
x5 + theme(plot.title = element_text(hjust = 0.5))



x6 <-ggplot(harvests, aes(year,harvest))+
  geom_line(size=1.2)+
  facet_wrap(~case, ncol=2)+
  ggtitle("Realized harvest transitional period")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest m3/ha")+
  theme_bw()
x6 + theme(plot.title = element_text(hjust = 0.5))

#_______________________________________________________________________________
# PIE CHARTS IN DISTURBANCE REGIME VOLUME BY SPECIES PROPORTION

#-----------------------------------------
landscape_cc_w_0 <- landscape_cc_w %>% filter(year==0)
landscape_cc_w_100 <- landscape_cc_w %>% filter(year==100)
landscape_sw_w_100 <- landscape_sw_w %>% filter(year==100)
landscape_cc_w_200 <- landscape_cc_w %>% filter(year==200)
landscape_sw_w_200 <- landscape_sw_w %>% filter(year==200)
landscape_cc_w_300 <- landscape_cc_w %>% filter(year==300)
landscape_sw_w_300 <- landscape_sw_w %>% filter(year==300)
landscape_cc_w_400 <- landscape_cc_w %>% filter(year==400)
landscape_sw_w_400 <- landscape_sw_w %>% filter(year==400)

b0w<-landscape_cc_w_0 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="initial_stage")
b1w<-landscape_cc_w_100 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clear cut year 100")
b2w<-landscape_sw_w_100 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 100")
b3w<-landscape_cc_w_200 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clear cut year 200")
b4w<-landscape_sw_w_200 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 200")
b5w<-landscape_cc_w_300 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clear cut year 300")
b6w<-landscape_sw_w_300 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 300")
b7w<-landscape_cc_w_400 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clear cut year 400")
b8w<-landscape_sw_w_400 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 400")

#summary(b1)
#sum(b1$perc.vol)

# SELETION OF THE INITIAL AND FINAL STAGE

r1w<-rbind(b0w,b7w,b8w)

x7w <- ggplot(r1w, aes(x="", y=volume_m3, fill=species)) +
  geom_bar(stat="identity", width=1, show.legend = T) +
  facet_wrap(~case, ncol=3)+
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0( round(perc.vol, 1)  )),  position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL)+
  ggtitle("Landscape volume (m3/ha) and species proportions (%) in disturbance regime")+
  theme_bw()
x7w + theme(plot.title = element_text(hjust = 0.5))

# PLOT ALL THE STAGE FOR EVERY 100 YEARS

r_transition_w <-rbind(b1w,b2w,b3w,b4w,b5w,b6w,b7w,b8w)

x8w <- ggplot(r_transition_w, aes(x="", y=volume_m3, fill=species)) +
  geom_bar(stat="identity", width=1, show.legend = T) +
  facet_wrap(~case, ncol=4)+
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0( round(perc.vol, 1)  )),  position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL)+
  ggtitle("Landscape volume (m3/ha) and species proportions (%) in disturbance regime")+
  theme_bw()
x8w + theme(plot.title = element_text(hjust = 0.5))


#_______________________________________________________________________________
# PIE CHARTS IN NOT DISTURBANCE REGIME VOLUME BY SPECIES PROPORTION

#-----------------------------------------
landscape_cc_0 <- landscape_cc_w %>% filter(year==0)
landscape_cc_100 <- landscape_cc_w %>% filter(year==100)
landscape_sw_100 <- landscape_sw_w %>% filter(year==100)
landscape_cc_200 <- landscape_cc_w %>% filter(year==200)
landscape_sw_200 <- landscape_sw_w %>% filter(year==200)
landscape_cc_300 <- landscape_cc_w %>% filter(year==300)
landscape_sw_300 <- landscape_sw_w %>% filter(year==300)
landscape_cc_400 <- landscape_cc_w %>% filter(year==399)
landscape_sw_400 <- landscape_sw_w %>% filter(year==399)

b0<-landscape_cc_0 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="initial_stage")
b1<-landscape_cc_100 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clear cut year 100")
b2<-landscape_sw_100 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 100")
b3<-landscape_cc_200 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clear cut year 200")
b4<-landscape_sw_200 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 200")
b5<-landscape_cc_300 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clear cut year 300")
b6<-landscape_sw_300 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 300")
b7<-landscape_cc_400 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clear cut year 400")
b8<-landscape_sw_400 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 400")

#summary(b1)
#sum(b1$perc.vol)

# SELETION OF THE INITIAL AND FINAL STAGE

r1<-rbind(b0,b7,b8)

x7 <- ggplot(r1, aes(x="", y=volume_m3, fill=species)) +
  geom_bar(stat="identity", width=1, show.legend = T) +
  facet_wrap(~case, ncol=3)+
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0( round(perc.vol, 1)  )),  position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL)+
  ggtitle("Landscape volume (m3/ha) and species proportions (%) ")+
  theme_bw()
x7 + theme(plot.title = element_text(hjust = 0.5))

# PLOT ALL THE STAGE FOR EVERY 100 YEARS

r_transition <-rbind(b1,b2,b3,b4,b5,b6,b7,b8)

x8 <- ggplot(r_transition, aes(x="", y=volume_m3, fill=species)) +
  geom_bar(stat="identity", width=1, show.legend = T) +
  facet_wrap(~case, ncol=4)+
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0( round(perc.vol, 1)  )),  position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL)+
  ggtitle("Landscape volume (m3/ha) and species proportions (%) ")+
  theme_bw()
x8 + theme(plot.title = element_text(hjust = 0.5))

#_______________________________________________________________________________
# Understanding the Basal Area dynamic for selected species
# SPECIES specific BA:

# DISTURBANCE REGIME

species.to.keep<-c("piab", "fasy","qupe", "quro", "poni")
species.to.keep


landscape_cc_w_ba <- landscape_cc_w %>% filter(species %in% species.to.keep)
landscape_sw_w_ba <- landscape_sw_w %>% filter(species %in% species.to.keep)
#head(landscape_cc2)


ba1_w <-ggplot(data=landscape_cc_w_ba, aes(x=year, y=basal_area_m2, color=species)) + 
  geom_line(size=1.2)+
  ggtitle("Clear cut in diturbance regime") +
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area m2/ha")

ba2_w <-ggplot(data=landscape_sw_w_ba, aes(x=year, y=basal_area_m2, color=species)) + 
  geom_line(size=1.2) +
  ggtitle("Shelterwood in diturbance regime")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area m2/ha")

grid.arrange(ba1_w,ba2_w,ncol=1)

#_______________________________________________________________________________
# IN NOT DISTURBANCE REGIME

landscape_cc_ba <- landscape_cc %>% filter(species %in% species.to.keep)
landscape_sw_ba <- landscape_sw %>% filter(species %in% species.to.keep)
#head(landscape_cc2)


ba1 <-ggplot(data=landscape_cc_ba, aes(x=year, y=basal_area_m2, color=species)) + 
  geom_line(size=1.2)+
  ggtitle("Clear cut") +
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area m2/ha")

ba2 <-ggplot(data=landscape_sw_ba, aes(x=year, y=basal_area_m2, color=species)) + 
  geom_line(size=1.2) +
  ggtitle("Shelterwood")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area m2/ha")

grid.arrange(ba1,ba2,ncol=1)

#_______________________________________________________________________________
# BASAL AREA PROPORTION BASED ON DBH CLASSES

library(RColorBrewer)
display.brewer.all()
library(viridis)           
library(colorRamps)

# DISTURBANCE REGIME

area<-landscape_sw_w$area[1]
print(area)

head(dynamicstand_sw_w)


dynamicstand_sw_0_w <- dynamicstand_sw_w %>% filter(year==0)
dynamicstand_cc_400_w <- dynamicstand_cc_w %>% filter(year==400)
dynamicstand_sw_400_w <- dynamicstand_sw_w %>% filter(year==400)

ba_dbh_sw_0_w <- dynamicstand_sw_0_w[,8:24]
ba_dbh_cc_400_w <- dynamicstand_cc_400_w[,8:24]
ba_dbh_sw_400_w <- dynamicstand_sw_400_w[,8:24]

row.names(ba_dbh_sw_0_w) <- dynamicstand_sw_0_w$species
colnames(ba_dbh_sw_0_w) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")
row.names(ba_dbh_sw_400_w) <- dynamicstand_sw_400_w$species
colnames(ba_dbh_sw_400_w) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")
row.names(ba_dbh_cc_400_w) <- dynamicstand_cc_400_w$species
colnames(ba_dbh_cc_400_w) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")


ba_dbh_sw_0_w<-ba_dbh_sw_0_w/area   # divide by the area because of the dynamic stand output
ba_dbh_sw_400_w<-ba_dbh_sw_400_w/area   # divide by the area because of the dynamic stand output
ba_dbh_cc_400_w<-ba_dbh_cc_400_w/area   # divide by the area because of the dynamic stand output

rgb.palette <- colorRampPalette(c("#7F0000", "red", "#FF7F00", "yellow", "#7FFF7F","cyan","#007FFF", "blue", "#00007F"), space = "rgb")

colors<-rgb.palette(17)

names(colors)<-dynamicstand_sw_0_w$species

colors

par(mfrow=c(3,1))
par(mar=c(4,4,4,15))
barplot(as.matrix(ba_dbh_sw_0_w), col = colors, ylab = "Basal area", main = "Year 0 in disturbance regime", cex.main=2, cex.lab=1.5, ylim=c(0,5))

barplot(as.matrix(ba_dbh_sw_400_w), col =colors, ylab = "Basal area", main = "Year 400 shelterwood in disturbance regime", cex.main=2, cex.lab=1.5, ylim=c(0,5))
barplot(as.matrix(ba_dbh_cc_400_w), col = colors, ylab = "Basal area", main = "Year 400 clearcut in disturbance regime", cex.main=2, cex.lab=1.5, ylim=c(0,5))

legend(21,18, legend = names(colors),cex=1.5,fill = colors, xpd = NA)

#_______________________________________________________________________________

area<-landscape_sw$area[1]
print(area)

head(dynamicstand_sw)


dynamicstand_sw_0 <- dynamicstand_sw %>% filter(year==0)
dynamicstand_cc_400 <- dynamicstand_cc %>% filter(year==399)
dynamicstand_sw_400 <- dynamicstand_sw %>% filter(year==399)

ba_dbh_sw_0 <- dynamicstand_sw_0[,8:24]
ba_dbh_cc_400 <- dynamicstand_cc_400[,8:24]
ba_dbh_sw_400 <- dynamicstand_sw_400[,8:24]

row.names(ba_dbh_sw_0) <- dynamicstand_sw_0$species
colnames(ba_dbh_sw_0) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")
row.names(ba_dbh_sw_400) <- dynamicstand_sw_400$species
colnames(ba_dbh_sw_400) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")
row.names(ba_dbh_cc_400) <- dynamicstand_cc_400$species
colnames(ba_dbh_cc_400) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")


ba_dbh_sw_0<-ba_dbh_sw_0/area   # divide by the area because of the dynamic stand output
ba_dbh_sw_400<-ba_dbh_sw_400/area   # divide by the area because of the dynamic stand output
ba_dbh_cc_400<-ba_dbh_cc_400/area   # divide by the area because of the dynamic stand output

#rgb.palette <- colorRampPalette(c("#7F0000", "red", "#FF7F00", "yellow", "#7FFF7F","cyan","#007FFF", "blue", "#00007F"), space = "rgb")

#colors<-rgb.palette(17)

#names(colors)<-dynamicstand_sw_0$species

#colors

par(mfrow=c(3,1))
par(mar=c(4,4,4,15))
barplot(as.matrix(ba_dbh_sw_0), col = colors, ylab = "Basal area", main = "Year 0 ", cex.main=2, cex.lab=1.5, ylim=c(0,5))

barplot(as.matrix(ba_dbh_sw_400), col =colors, ylab = "Basal area", main = "Year 400 shelterwood ", cex.main=2, cex.lab=1.5, ylim=c(0,5))
barplot(as.matrix(ba_dbh_cc_400), col = colors, ylab = "Basal area", main = "Year 400 clearcut", cex.main=2, cex.lab=1.5, ylim=c(0,5))

legend( 21,18, legend = names(colors),cex=1.5,fill = colors, xpd = NA)

#_______________________________________________________________________________



# DEEP UNDERSTANDING BA DBH DYNAMICS




# Working with DPLYR library to filter, group, mutate and arrange

#_______________________________________ CC year 400

dynamicStand_cc_400 <- dynamicStand_cc%>%
  filter(year==399)

ba_dbh_cc_400 <- dynamicStand_cc_400[,8:24]
ba_dbh_cc_400

row.names(ba_dbh_cc_400) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","qupe","algl","potr","poni","tico","saca")
ba_dbh_cc_400

colnames(ba_dbh_cc_400) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")

# barplot(as.matrix(ba_dbh_cc_400))

#_________________________________________ CC year 0

dynamicStand_cc_0 <- dynamicStand_cc%>%
  filter(year==0)

ba_dbh_cc_0 <- dynamicStand_cc_0[,8:24]
# ba_dbh_cc_0

row.names(ba_dbh_cc_0) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops")
# ba_dbh_cc_0

colnames(ba_dbh_cc_0) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")

# barplot(as.matrix(ba_dbh_cc_0))

#_________________________________________ SW year 400

dynamicstand_sw_400 <- dynamicstand_sw%>%
  filter(year==399)

ba_dbh_sw_400 <- dynamicstand_sw_400[,8:24]
# ba_dbh_cc_0

row.names(ba_dbh_sw_400) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","qupe","algl","potr","poni","tico","saca")
# ba_dbh_cc_0

colnames(ba_dbh_sw_400) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")

# barplot(as.matrix(ba_dbh_cc_0))


#_________________________________________ SW year 0

dynamicstand_sw_0 <- dynamicstand_sw%>%
  filter(year==0)

ba_dbh_sw_0 <- dynamicstand_sw_0[,8:24]


row.names(ba_dbh_sw_0) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops")


colnames(ba_dbh_sw_0) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")


#________________________________________ CC year 100

dynamicStand_cc_100 <- dynamicStand_cc%>%
  filter(year==100)

ba_dbh_cc_100 <- dynamicStand_cc_100[,8:24]

row.names(ba_dbh_cc_100) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca")

colnames(ba_dbh_cc_100) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")

#_________________________________________ CC year 200

dynamicStand_cc_200 <- dynamicStand_cc%>%
  filter(year==200)

ba_dbh_cc_200 <- dynamicStand_cc_200[,8:24]

row.names(ba_dbh_cc_200) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","qupe","algl","potr","poni","tico","saca")

colnames(ba_dbh_cc_200) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")

#_________________________________________ CC year 300

dynamicStand_cc_300 <- dynamicStand_cc%>%
  filter(year==300)

ba_dbh_cc_300 <- dynamicStand_cc_300[,8:24]

row.names(ba_dbh_cc_300) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","qupe","algl","potr","poni","tico","saca")

colnames(ba_dbh_cc_300) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")


#_________________________________________ SW year 100

dynamicstand_sw_100 <- dynamicstand_sw%>%
  filter(year==100)

ba_dbh_sw_100 <- dynamicstand_sw_100[,8:24]

row.names(ba_dbh_sw_100) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops")

colnames(ba_dbh_sw_100) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")


#_________________________________________ SW year 200

dynamicstand_sw_200 <- dynamicstand_sw%>%
  filter(year==200)

ba_dbh_sw_200 <- dynamicstand_sw_200[,8:24]

row.names(ba_dbh_sw_200) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","qupe","algl","potr","poni","tico","saca")

colnames(ba_dbh_sw_200) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")


#_________________________________________ SW year 300

dynamicstand_sw_300 <- dynamicstand_sw%>%
  filter(year==300)

ba_dbh_sw_300 <- dynamicstand_sw_300[,8:24]

row.names(ba_dbh_sw_300) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","qupe","algl","potr","poni","tico","saca")

colnames(ba_dbh_sw_300) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")

#_______________________________________________________ Plotting in bar chart and using color palettes

# TO ADD THE COLOURS 

library(RColorBrewer)
#display.brewer.all()
library(viridis)           
library(colorRamps)

# Trying other palette

cl <- c("#00007F", "blue", "#007FFF", "cyan", "#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000", "pink", "darkgreen", "violet", "black")
cl2 <- c("#00007F", "blue", "#007FFF", "cyan", "#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000", "pink", "brown", "orange", "green")
cl3 <- c("#1B9E77","#D95F02", "#7570B3", "#E7298A", "#66A61E", "#E6AB02", "#A6761D", "#666666")

barplot(as.matrix(ba_dbh), col = cl)
barplot(as.matrix(ba_dbh), col = viridis(17))
barplot(as.matrix(ba_dbh), col = rgb.palette(17))


rgb.palette <- colorRampPalette(c("#7F0000", "red", "#FF7F00", "yellow", "#7FFF7F","cyan","#007FFF", "blue", "#00007F"),
                                space = "rgb")


#   BAR PLOT CC 0 __________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_cc_0), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Clear cut Landscape Basal Area divided in DBH classes by species Tran. Period year 0", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=1.1,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT CC 100 __________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_cc_100), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Clear cut Landscape Basal Area divided in DBH classes by species Tran. Period year 100", cex.main=2, cex.lab=1.5)

#   Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=1.1,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT CC 200 __________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_cc_200), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Clear cut Landscape Basal Area divided in DBH classes by species Tran. Period year 200", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=1.1,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT CC 300 __________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_cc_300), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Clear cut Landscape Basal Area divided in DBH classes by species Tran. Period year 300", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=1.1,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT CC 400 __________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_cc_400), 
        col = rgb.palette(17), 
        ylab = "Landscape BA (m2)",
        main = "Clear cut Landscape Basal Area divided in DBH classes by species Tran. Period year 400",
        cex.main=2, cex.lab=1.5)

#   Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=1.1,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT SW 0__________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_sw_0), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Shelterwood Landscape Basal Area divided in DBH classes by species Tran. Period year 0", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=1.1,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT SW 100 __________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_sw_100), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Shelterwood Landscape Basal Area divided in DBH classes by species Tran. Period year 100", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=1.1,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT SW 200__________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_sw_200), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Shelterwood Landscape Basal Area divided in DBH classes by species Tran. Period year 200", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=1.1,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT SW 300__________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_sw_300), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Shelterwood Landscape Basal Area divided in DBH classes by species Tran. Period year 300", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=1.1,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT SW 400 __________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_sw_400), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Shelterwood Landscape Basal Area divided in DBH classes by species Tran. Period year 400", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=1.1,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________
#_______________________________________________________________________________
# FINISHED DEEP UNDERSTANDING BA DBH DYNAMICS



# link for edit the labels and the x and y titles

######### IMPORTANT #############  http://www.sthda.com/english/wiki/add-titles-to-a-plot-in-r-software

# legend("top", c("finalcut", "thinning/regcut","salvaged"), cex=1, bty="n", fill=colors, text.font=2)
# leggend, (position, names/variables, size, bty?- contorn?, color filling, text font) 

# barplot(ba_dbh$if_dbh_5_basalarea_0_sum)  to plot only one column with bar charth

# have a look at this website   https://statisticsglobe.com/barplot-in-r


# ggplot(data_ggp, aes(x = group, y = values)) +        # Create barchart with ggplot2
#  geom_bar(stat = "identity")


# hist(dynamicStand_cc$dbh_mean, main= 'Clear Cut V-DBH Transitional Period')

# hist(dynamicstand_sw$dbh_mean, abeUnit_sw$volume, main= 'Shalterwood Vol-DBH Transitional Period')



# barplot(dynamicStand_cc$year, dynamicStand_cc$dbh_mean, main= 'Clear Cut V-DBH Transitional Period')




#_____________________________________________________________________________________________________
# Wind disturbance impact in the landscape volume in percentages

killed_volume_cc <- sum(wind_cc$killedVolume)                # 1601620 m3
killed_volume_cc
killed_volume_per_year_cc <- killed_volume_cc/400            # 4014.085
killed_volume_per_year_cc
killed_volume_per_year_cc_ha <- killed_volume_per_year_cc/17749.26
killed_volume_per_year_cc_ha                                 # 0.226155 m3

_____________________________________________

killed_volume_sw <- sum(wind_sw$killedVolume)                # 1362593 m3
killed_volume_sw
killed_volume_per_year_sw <- killed_volume_sw/400            # 3415.021
killed_volume_per_year_sw
killed_volume_per_year_sw_ha <- killed_volume_per_year_sw/17749.26
killed_volume_per_year_sw_ha                                 # 0.1924036 m3                        


dfnew1_cc <- landscape_cc[,c(1,8)]

df_vol_cc = dfnew1_cc %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')

dfnew1_sw <- landscape_sw[,c(1,8)]

df_vol_sw = dfnew1_sw %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year_cc <- df_vol_cc %>% mutate(perc.vol=100*0.226155/tot_vol)

prop_killed_vol_ha_year_sw <- df_vol_sw %>% mutate(perc.vol=100*0.1924036/tot_vol)

par(mfrow = c(1,2))

hist(prop_killed_vol_ha_year_cc$perc.vol, main = "Landscape proportion of killed volume (m3/ha) by wind per year in CC",cex.main = 1.5, xlab = "Killed volume / Total volume (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,120))

legend("topright", c("0.226155 m3"), cex = 0.9, title = "Average killed volume (m3/ha) per year", text.font = 3, bg='lightpink')

# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(prop_killed_vol_ha_year_sw$perc.vol, main = "Landscape proportion of killed volume (m3/ha) by wind per year in SW",cex.main = 1.5, xlab = "Killed volume / Total volume (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,120))

legend("topright", c("0.1924036 m3"), cex = 0.9, title = "Average killed volume (m3/ha) per year", text.font = 3, bg='lightpink')
