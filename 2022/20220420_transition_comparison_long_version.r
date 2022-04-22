
# install.packages("RSQLite")
library(RSQLite)
library(dplyr)
library(fields)
#______________________________________________
# Path to search the data
# 1 database with wind disturbances
dataroot <- ("C:/iLand/2022/20220420/wind_bb/")

# 1 Name of the database for wind + bark beetles 
file_cc_wb <-paste0(dataroot,"Cz_region_20220325_BAU_cc_management.sqlite")   # file to read
file_sw_wb <-paste0(dataroot,"Cz_region_20220325_BAU_sw_management.sqlite")   # file to read

#______________________________________________
# connect to the database of clearcut (cc) model with WIND abd BB
sqlite.driver <- dbDriver("SQLite")
db1 <- dbConnect(sqlite.driver, dbname = file_cc_wb)  # connect to the file
tables.in.the.file<-dbListTables(db1)           # explore the tables in the file
print(tables.in.the.file)

# connect to the database of shelterwood (sw) model with WIND and BB
sqlite.driver <- dbDriver("SQLite")
db2 <- dbConnect(sqlite.driver, dbname = file_sw_wb)  # connect to the file
tables.in.the.file<-dbListTables(db2)           # explore the tables in the file
print(tables.in.the.file)

#______________________________________________
# READ IN different tables (present outputs):    (here can read in by table names.... depending on what you have in your outputfile)
# CC_WB
abeStand_cc_wb <- dbReadTable(db1, "abeStand")
abeStandRemoval_cc_wb <- dbReadTable(db1, "abeStandRemoval")
abeUnit_cc_wb <- dbReadTable(db1, "abeUnit")
barkbeetle_cc_wb <- dbReadTable(db1,"barkbeetle")
carbon_cc_wb <- dbReadTable(db1,"carbon")
carbonflow_cc_wb <- dbReadTable(db1, "carbonflow")
dynamicstand_cc_wb <- dbReadTable(db1, "dynamicstand")
landscape_cc_wb <- dbReadTable(db1,"landscape")
wind_cc_wb <- dbReadTable(db1,"wind")
dbDisconnect(db1)    # close the file

# SW_WB
abeStand_sw_wb <- dbReadTable(db2, "abeStand")
abeStandRemoval_sw_wb <- dbReadTable(db2, "abeStandRemoval")
abeUnit_sw_wb <- dbReadTable(db2, "abeUnit")
barkbeetle_sw_wb <- dbReadTable(db2,"barkbeetle")
carbon_sw_wb <- dbReadTable(db2,"carbon")
carbonflow_sw_wb <- dbReadTable(db2, "carbonflow")
dynamicstand_sw_wb <- dbReadTable(db2, "dynamicstand")
landscape_sw_wb <- dbReadTable(db2,"landscape")
wind_sw_wb <- dbReadTable(db2,"wind")
dbDisconnect(db2)    # close the file
#_______________________________________________

#_______________________________________________
# 2 database without wind disturbances
dataroot <- ("C:/iLand/2022/20220420/wind/")

# 2 Name of the database
file_cc_w <-paste0(dataroot,"Cz_region_20220325_BAU_cc_management.sqlite")   # file to read
file_sw_w <-paste0(dataroot,"Cz_region_20220325_BAU_sw_management.sqlite")   # file to read

# connect to the database of clearcut model
sqlite.driver <- dbDriver("SQLite")
db3 <- dbConnect(sqlite.driver, dbname = file_cc_w)  # connect to the file
tables.in.the.file<-dbListTables(db3)           # explore the tables in the file
print(tables.in.the.file)

# connect to the database of shelterwood model
sqlite.driver <- dbDriver("SQLite")
db4 <- dbConnect(sqlite.driver, dbname = file_sw_w)  # connect to the file
tables.in.the.file<-dbListTables(db4)           # explore the tables in the file
print(tables.in.the.file)

#_______________________________________________
# READ IN different tables:    (here can read in by table names.... depending on what you have in your output file)
# CC in wind
abeStand_cc_w <- dbReadTable(db3, "abeStand")
abeStandRemoval_cc_w <- dbReadTable(db3, "abeStandRemoval")
abeUnit_cc_w <- dbReadTable(db3, "abeUnit")
#barkbeetle_cc_w <- dbReadTable(db3,"barkbeetle")
carbon_cc_w <- dbReadTable(db3,"carbon")
carbonflow_cc_w <- dbReadTable(db3, "carbonflow")
dynamicstand_cc_w <- dbReadTable(db3, "dynamicstand")
landscape_cc_w <- dbReadTable(db3,"landscape")
wind_cc_w <- dbReadTable(db3,"wind")
dbDisconnect(db3)    # close the file

# SW in wind
abeStand_sw_w <- dbReadTable(db4, "abeStand")
abeStandRemoval_sw_w <- dbReadTable(db4, "abeStandRemoval")
abeUnit_sw_w <- dbReadTable(db4, "abeUnit")
#barkbeetle_sw_w <- dbReadTable(db4,"barkbeetle")
carbon_sw_w <- dbReadTable(db4,"carbon")
carbonflow_sw_w <- dbReadTable(db4, "carbonflow")
dynamicstand_sw_w <- dbReadTable(db4, "dynamicstand")
landscape_sw_w <- dbReadTable(db4,"landscape")
wind_sw_w <- dbReadTable(db4,"wind")
dbDisconnect(db4)    # close the file
#_______________________________________________
# Make a plot with ggplot, volume, colored by species for the transitional period for Clear cut management system

#_______________________________________________
# 3 database without wind disturbances
dataroot <- ("C:/iLand/2022/20220420/no_disturbance/")

# 3 Name of the database
file_cc <-paste0(dataroot,"Cz_region_20220325_BAU_cc_management.sqlite")   # file to read
file_sw <-paste0(dataroot,"Cz_region_20220325_BAU_sw_management.sqlite")   # file to read

# connect to the database of clearcut model
sqlite.driver <- dbDriver("SQLite")
db5 <- dbConnect(sqlite.driver, dbname = file_cc)  # connect to the file
tables.in.the.file<-dbListTables(db5)           # explore the tables in the file
print(tables.in.the.file)

# connect to the database of shelterwood model
sqlite.driver <- dbDriver("SQLite")
db6 <- dbConnect(sqlite.driver, dbname = file_sw)  # connect to the file
tables.in.the.file<-dbListTables(db6)           # explore the tables in the file
print(tables.in.the.file)

#_______________________________________________
# READ IN different tables:    (here can read in by table names.... depending on what you have in your output file)
# CC in wind
abeStand_cc <- dbReadTable(db5, "abeStand")
abeStandRemoval_cc <- dbReadTable(db5, "abeStandRemoval")
abeUnit_cc <- dbReadTable(db5, "abeUnit")
#barkbeetle_cc <- dbReadTable(db5,"barkbeetle")
carbon_cc <- dbReadTable(db5,"carbon")
carbonflow_cc <- dbReadTable(db5, "carbonflow")
dynamicstand_cc <- dbReadTable(db5, "dynamicstand")
landscape_cc <- dbReadTable(db5,"landscape")
wind_cc <- dbReadTable(db5,"wind")
dbDisconnect(db5)    # close the file

# SW in wind
abeStand_sw <- dbReadTable(db6, "abeStand")
abeStandRemoval_sw <- dbReadTable(db6, "abeStandRemoval")
abeUnit_sw <- dbReadTable(db6, "abeUnit")
#barkbeetle_sw <- dbReadTable(db6,"barkbeetle")
carbon_sw <- dbReadTable(db6,"carbon")
carbonflow_sw <- dbReadTable(db6, "carbonflow")
dynamicstand_sw <- dbReadTable(db6, "dynamicstand")
landscape_sw <- dbReadTable(db6,"landscape")
wind_sw <- dbReadTable(db6,"wind")
dbDisconnect(db6)    # close the file
#_______________________________________________
library(ggplot2)
library(gridExtra) # To arrange the graphs in a grid

# SET THE COLORS
# this tells the colors:
species.we.have<-unique(landscape_cc_wb$species)

cols.all=c( "rops"="#e0e0e0", "acpl"="#A9A9A9",   "alin"="#696969", "alvi"="#2e2e2e",
            "bepe"="#fadfad", 
            "casa"="#7eeadf", "coav"="#20c6b6",  
            "tipl"="#645394", "ulgl"="#311432" ,
            "saca"="#D8BFD8",  "soar"="#DDA0DD", "soau"="#BA55D3",
            "pice"="#D27D2D", "pini"="#a81c07",
            "algl"="#2ECBE9","tico"="#128FC8",  "potr"="#00468B","poni"="#5BAEB7",
            "frex"="#fe9cb5","cabe"="#fe6181","acps"="#fe223e",
            "lade"="#FFFE71","abal"="#FFD800", "pisy"="#A4DE02",
            "fasy"="#76BA1B", "piab"="#006600",
            "quro"="#FF7F00", "qupe"="#FF9900", "qupu"="#CC9900" 
)

new_order_gg.all=c("alvi","alin", "acpl", "rops","bepe" ,"coav", "casa", "ulgl", "tipl",  "soau", "soar", "saca",  "pini", "pice",
                   "poni", "algl", "tico", "potr",  "frex","cabe", "acps",  "lade", "abal",  "qupu", "qupe","quro","pisy", "fasy", "piab")


# This will show at the end only the species we really have on the landscape. 

cols<-cols.all[names(cols.all) %in% species.we.have]
new_order_gg<- new_order_gg.all[new_order_gg.all %in% species.we.have]

#_____________________________________________________________________________________
# Plot the transition period wood volume (m3/h) in disturbance regime color by species

# CC WB
ggplot(landscape_cc_wb, aes(year,volume_m3, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(title = "Species", reverse=TRUE))+
  ggtitle("Clearcut management") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) +
  ylab("Volume [m3/ha]") + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) +
  xlab("Year") + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,400)

# SW WB
ggplot(landscape_sw_wb, aes(year,volume_m3, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(title = "Species", reverse=TRUE))+
  ggtitle("Shelterwood management") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) +
  ylab("Volume [m3/ha]") + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) +
  xlab("Year") + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,400)
#_____________________________________________________________
# PLOT THE TANSITION PERIOD (TP) VOLUME BY SPECIE IN COMPARABLE WAY (MULTI-WINDOW)
# TP IN WIND AND BARK BEETLE REGIME 
#_____________________________________________
g1 <- ggplot(landscape_cc_wb, aes(year,volume_m3, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(title = "Species", reverse=TRUE))+
  ggtitle("Clearcut management in wind and bark beetle regime") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) +
  ylab("Volume [m3/ha]") + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) +
  xlab("Year") + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,400)

g2 <- ggplot(landscape_sw_wb, aes(year,volume_m3, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(title = "Species", reverse=TRUE))+
  ggtitle("Shelterwood management in wind and bark beetle regime") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) +
  ylab("Volume [m3/ha]") + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) +
  xlab("Year") + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,400)

#grid.arrange(g1,g2,ncol=2)
grid.arrange(g1,g2,ncol=1)

#______________________________________________
# TP in only wind regime

g3 <- ggplot(landscape_cc_w, aes(year,volume_m3, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(title = "Species", reverse=TRUE))+
  ggtitle("Clearcut management in wind regime") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) +
  ylab("Volume [m3/ha]") + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) +
  xlab("Year") + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,400)

g4 <- ggplot(landscape_sw_w, aes(year,volume_m3, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(title = "Species", reverse=TRUE))+
  ggtitle("Shelterwood management in wind regime") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) +
  ylab("Volume [m3/ha]") + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) +
  xlab("Year") + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,400)

#grid.arrange(g1,g2,ncol=2)
grid.arrange(g3,g4,ncol=1)

#______________________________________________
# All the 4 graphics together

grid.arrange(g1,g2,g3,g4,ncol=1)

# PLOT THE TANSITION PERIOD (TP) VOLUME BY SPECIE IN COMPARABLE WAY (MULTI-WINDOW)
# TP IN WIND AND BARK BEETLE REGIME 
#_____________________________________________
g5 <- ggplot(landscape_cc, aes(year,volume_m3, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(title = "Species", reverse=TRUE))+
  ggtitle("Clearcut management in wind not disturbances") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) +
  ylab("Volume [m3/ha]") + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) +
  xlab("Year") + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,400)

g6 <- ggplot(landscape_sw, aes(year,volume_m3, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(title = "Species", reverse=TRUE))+
  ggtitle("Shelterwood management not disturbance") + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=22)) +
  ylab("Volume [m3/ha]") + theme(axis.title.y = element_text(size = rel(1.8), angle = 90)) +
  xlab("Year") + theme(axis.title.x = element_text(size = rel(1.8), angle = 00)) +
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,400)

#grid.arrange(g1,g2,ncol=2)
grid.arrange(g5,g6,ncol=1)

# ALL 6 TOGETHER
grid.arrange(g1,g2,g3,g4,g5,g6,ncol=2)

#______________________________________________
# HARVEST TIME SERIES IN wind and bark beetle DISTURBANCE REGIME
#----------------------------------------------

a1<-data.frame(year=abeUnit_cc_wb$year, harvest=abeUnit_cc_wb$realizedHarvest, case="Clearcut_wb")
a2<-data.frame(year=abeUnit_sw_wb$year, harvest=abeUnit_sw_wb$realizedHarvest, case="Shelterwood_wb")

head(a1)
head(a2)

harvests<- rbind(a1,a2)
summary(a1)
summary(a2)
summary(harvests)
dim(harvests)

x1 <- ggplot(harvests, aes(year,harvest, color=case))+
  geom_line(size=1.2)+
  ggtitle("Realized transitional period total harvest in wind and bark beetle regime")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest [m3/ha]")+
  ylim(0,15)+
  theme_bw()
x1 + theme(plot.title = element_text(hjust = 0.5))

x2 <-ggplot(harvests, aes(year,harvest))+
  geom_line(size=1.2)+
  facet_wrap(~case, ncol=1)+
  ggtitle("Realized transitional period total harvest in wind and bark beetle regime")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest [m3/ha]")+
  ylim(0,25)+
  theme_bw()
x2 + theme(plot.title = element_text(hjust = 0.5))

#_______________________________________________________________________________
# Realized harvest transition period in not disturbance regime

a3<-data.frame(year=abeUnit_cc_w$year, harvest=abeUnit_cc_w$realizedHarvest, case="Clearcut_w")
a4<-data.frame(year=abeUnit_sw_w$year, harvest=abeUnit_sw_w$realizedHarvest, case="Shelterwood_w")

head(a3)
head(a4)

harvests<- rbind(a3,a4)
summary(a3)
summary(a4)
summary(harvests)
dim(harvests)

x3 <- ggplot(harvests, aes(year,harvest, color=case))+
  geom_line(size=1.2)+
  ggtitle("Realized transitional period total harvest in wind regime")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest [m3/ha]")+
  ylim(0,25)+
  theme_bw()
x3 + theme(plot.title = element_text(hjust = 0.5))

x4 <-ggplot(harvests, aes(year,harvest))+
  geom_line(size=1.2)+
  facet_wrap(~case, ncol=1)+
  ggtitle("Realized transitional period total harvest in wind regime")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest [m3/ha]")+
  ylim(0,25)+
  theme_bw()
x4 + theme(plot.title = element_text(hjust = 0.5))

#_______________________________________________________________________________
# NO DISTURBANCE

# HARVEST TIME SERIES IN DISTURBANCE REGIME
#----------------------------------------------

a5<-data.frame(year=abeUnit_cc$year, harvest=abeUnit_cc$realizedHarvest, case="Clearcut")
a6<-data.frame(year=abeUnit_sw$year, harvest=abeUnit_sw$realizedHarvest, case="Shelterwood")

head(a5)
head(a6)

harvests<- rbind(a5,a6)
summary(a5)
summary(a6)
summary(harvests)
dim(harvests)

x5 <- ggplot(harvests, aes(year,harvest, color=case))+
  geom_line(size=1.2)+
  ggtitle("Realized transitional period total harvest not disturbance")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest [m3/ha]")+
  ylim(0,25)+
  theme_bw()
x5 + theme(plot.title = element_text(hjust = 0.5))

x6 <-ggplot(harvests, aes(year,harvest))+
  geom_line(size=1.2)+
  facet_wrap(~case, ncol=1)+
  ggtitle("Realized transitional period total harvest not disturbance")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest [m3/ha]")+
  ylim(0,25)+
  theme_bw()
x6 + theme(plot.title = element_text(hjust = 0.5))

# ALL 6 TOGETHER

harvests<- rbind(a1,a2,a3,a4,a5,a6)

x7 <- ggplot(harvests, aes(year,harvest, color=case))+
  geom_line(size=0.8)+
  ggtitle("Realized harvest transitional period")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest m3/ha")+
  ylim(0,25)+
  theme_bw()
x7 + theme(plot.title = element_text(hjust = 0.5))



x8 <-ggplot(harvests, aes(year,harvest))+
  geom_line(size=1.2)+
  facet_wrap(~case, ncol=1)+
  ggtitle("Realized harvest transitional period")+
  #theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest m3/ha")+
  ylim(0,25)+
  theme_bw()
x8 + theme(plot.title = element_text(hjust = 0.5))

#_______________________________________________________________________________
# PIE CHARTS IN wind and bark beetle REGIME VOLUME BY SPECIES PROPORTION

#-----------------------------------------
landscape_cc_wb_0 <- landscape_cc_wb %>% filter(year==0)
landscape_cc_wb_100 <- landscape_cc_wb %>% filter(year==100)
landscape_sw_wb_100 <- landscape_sw_wb %>% filter(year==100)
landscape_cc_wb_200 <- landscape_cc_wb %>% filter(year==200)
landscape_sw_wb_200 <- landscape_sw_wb %>% filter(year==200)
landscape_cc_wb_300 <- landscape_cc_wb %>% filter(year==300)
landscape_sw_wb_300 <- landscape_sw_wb %>% filter(year==300)
landscape_cc_wb_400 <- landscape_cc_wb %>% filter(year==400)
landscape_sw_wb_400 <- landscape_sw_wb %>% filter(year==400)

b0wb<-landscape_cc_wb_0 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Initial stage")
b1wb<-landscape_cc_wb_100 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clearcut year 100")
b2wb<-landscape_sw_wb_100 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 100")
b3wb<-landscape_cc_wb_200 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clearcut year 200")
b4wb<-landscape_sw_wb_200 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 200")
b5wb<-landscape_cc_wb_300 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clearcut year 300")
b6wb<-landscape_sw_wb_300 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 300")
b7wb<-landscape_cc_wb_400 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clearcut year 400")
b8wb<-landscape_sw_wb_400 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 400")

#summary(b1)
#sum(b1$perc.vol)

# SELETION OF THE INITIAL AND FINAL STAGE

r1wb<-rbind(b0wb,b7wb,b8wb)

x7wb <- ggplot(r1wb, aes(x="", y=volume_m3, fill=factor(species,levels=new_order_gg))) +
  geom_bar(stat="identity", width=1, show.legend = T) +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  facet_wrap(~case, ncol=3)+
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0( round(perc.vol, 1)  )),  position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL)+
  ggtitle("Species proportions [%] based on landscape volume [m3/ha] in wind and bark beetle regime")+
  theme_bw()
x7wb + theme(plot.title = element_text(hjust = 0.5))

# PLOT ALL THE STAGE FOR EVERY 100 YEARS

r_transition_wb <-rbind(b0wb,b1wb,b2wb,b3wb,b4wb,b5wb,b6wb,b7wb,b8wb)

x8wb <- ggplot(r_transition_wb, aes(x="", y=volume_m3, fill=factor(species,levels=new_order_gg))) +
  geom_bar(stat="identity", width=1, show.legend = T) +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  facet_wrap(~case, ncol=5)+
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0( round(perc.vol, 1)  )),  position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL)+
  ggtitle("Species proportions [%] based on landscape volume [m3/ha] in wind and bark beetle regime")+
  theme_bw()
x8wb + theme(plot.title = element_text(hjust = 0.5))


#_______________________________________________________________________________
# PIE CHARTS IN WIND REGIME VOLUME BY SPECIES PROPORTION

#-----------------------------------------
landscape_cc_w_0 <- landscape_cc_w %>% filter(year==0)
landscape_cc_w_100 <- landscape_cc_w %>% filter(year==100)
landscape_sw_w_100 <- landscape_sw_w %>% filter(year==100)
landscape_cc_w_200 <- landscape_cc_w %>% filter(year==200)
landscape_sw_w_200 <- landscape_sw_w %>% filter(year==200)
landscape_cc_w_300 <- landscape_cc_w %>% filter(year==300)
landscape_sw_w_300 <- landscape_sw_w %>% filter(year==300)
landscape_cc_w_400 <- landscape_cc_w %>% filter(year==399)
landscape_sw_w_400 <- landscape_sw_w %>% filter(year==399)

b0w<-landscape_cc_w_0 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Initial_stage")
b1w<-landscape_cc_w_100 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clearcut year 100")
b2w<-landscape_sw_w_100 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 100")
b3w<-landscape_cc_w_200 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clearcut year 200")
b4w<-landscape_sw_w_200 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 200")
b5w<-landscape_cc_w_300 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clearcut year 300")
b6w<-landscape_sw_w_300 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 300")
b7w<-landscape_cc_w_400 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clearcut year 400")
b8w<-landscape_sw_w_400 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 400")

#summary(b1)
#sum(b1$perc.vol)


# Only Wind Regime
# SELETION OF THE INITIAL AND FINAL STAGE

r1w<-rbind(b0w,b7w,b8w)

x7w <- ggplot(r1w, aes(x="", y=volume_m3, fill=factor(species,levels=new_order_gg))) +
  geom_bar(stat="identity", width=1, show.legend = T) +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  facet_wrap(~case, ncol=3)+
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0( round(perc.vol, 1)  )),  position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL)+
  ggtitle("Species proportions [%] based on landscape volume [m3/ha] in wind regime ")+
  theme_bw()
x7w + theme(plot.title = element_text(hjust = 0.5))

# PLOT ALL THE STAGE FOR EVERY 100 YEARS

r_transition_w<-rbind(b0w,b1w,b2w,b3w,b4w,b5w,b6w,b7w,b8w)

x8w <- ggplot(r_transition_w, aes(x="", y=volume_m3, fill=factor(species,levels=new_order_gg))) +
  geom_bar(stat="identity", width=1, show.legend = T) +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  facet_wrap(~case, ncol=5)+
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0( round(perc.vol, 1)  )),  position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL)+
  ggtitle("Species proportions [%] based on landscape volume [m3/ha] in wind regime")+
  theme_bw()
x8w + theme(plot.title = element_text(hjust = 0.5))

#_______________________________________________________________________________
# PIE CHARTS no disturbance VOLUME BY SPECIES PROPORTION

#-----------------------------------------
landscape_cc_0 <- landscape_cc %>% filter(year==0)
landscape_cc_100 <- landscape_cc %>% filter(year==100)
landscape_sw_100 <- landscape_sw %>% filter(year==100)
landscape_cc_200 <- landscape_cc %>% filter(year==200)
landscape_sw_200 <- landscape_sw %>% filter(year==200)
landscape_cc_300 <- landscape_cc %>% filter(year==300)
landscape_sw_300 <- landscape_sw %>% filter(year==300)
landscape_cc_400 <- landscape_cc %>% filter(year==399)
landscape_sw_400 <- landscape_sw %>% filter(year==399)

b0<-landscape_cc_0 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Initial_stage")
b1<-landscape_cc_100 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clearcut year 100")
b2<-landscape_sw_100 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 100")
b3<-landscape_cc_200 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clearcut year 200")
b4<-landscape_sw_200 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 200")
b5<-landscape_cc_300 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clearcut year 300")
b6<-landscape_sw_300 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 300")
b7<-landscape_cc_400 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Clearcut year 400")
b8<-landscape_sw_400 %>% mutate( sumvol=sum(volume_m3)) %>% mutate(perc.vol=100*volume_m3/sumvol, case="Shelterwood year 400")

#summary(b1)
#sum(b1$perc.vol)


# Only Wind Regime
# SELETION OF THE INITIAL AND FINAL STAGE

r1<-rbind(b0,b7,b8)

x9 <- ggplot(r1, aes(x="", y=volume_m3, fill=factor(species,levels=new_order_gg))) +
  geom_bar(stat="identity", width=1, show.legend = T) +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  facet_wrap(~case, ncol=3)+
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0( round(perc.vol, 1)  )),  position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL)+
  ggtitle("Species proportions [%] based on landscape volume [m3/ha] in wind regime ")+
  theme_bw()
x9 + theme(plot.title = element_text(hjust = 0.5))

# PLOT ALL THE STAGE FOR EVERY 100 YEARS

r_transition<-rbind(b0,b1,b2,b3,b4,b5,b6,b7,b8)

x10 <- ggplot(r_transition, aes(x="", y=volume_m3, fill=factor(species,levels=new_order_gg))) +
  geom_bar(stat="identity", width=1, show.legend = T) +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  facet_wrap(~case, ncol=5)+
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0( round(perc.vol, 1)  )),  position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL)+
  ggtitle("Species proportions [%] based on landscape volume [m3/ha] in wind regime")+
  theme_bw()
x10 + theme(plot.title = element_text(hjust = 0.5))

#_______________________________________________________________________________
# Understanding the Basal Area dynamic for selected species
# SPECIES specific BA:

# Wind and Bark Beetle REGIME

species.to.keep<-c("piab","pisy", "fasy","qupe")
species.to.keep

landscape_cc_wb_ba <- landscape_cc_wb %>% filter(species %in% species.to.keep)
landscape_sw_wb_ba <- landscape_sw_wb %>% filter(species %in% species.to.keep)
#head(landscape_cc2)

#  Example how manually color lines in ggplot2
#  ggplot(dat.m, aes(wave, value, colour = variable)) + geom_line() + 
#  scale_colour_manual(values = c('pink','orange','white'))

ba1_wb <-ggplot(data=landscape_cc_wb_ba, aes(x=year, y=basal_area_m2, colour=species)) + 
  geom_line(size=1.2)+
  scale_colour_manual(values = c("#76BA1B","#006600", "#A4DE02", "orange"))+
  ggtitle("Clearcut management in wind and bark beetle regime") +
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area [m2/ha]")+
  theme_bw()
  
ba2_wb <-ggplot(data=landscape_sw_wb_ba, aes(x=year, y=basal_area_m2, colour=species)) + 
  geom_line(size=1.2) +
  scale_colour_manual(values = c("#76BA1B","#006600", "#A4DE02", "orange"))+
  ggtitle("Shelterwood management in wind and bark beetle regime")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area [m2/ha]")+
  theme_bw()

grid.arrange(ba1_wb,ba2_wb,ncol=1)

#_______________________________________________________________________________
# IN wind DISTURBANCE REGIME

landscape_cc_w_ba <- landscape_cc_w %>% filter(species %in% species.to.keep)
landscape_sw_w_ba <- landscape_sw_w %>% filter(species %in% species.to.keep)
#head(landscape_cc2)

#  Example how manually color lines in ggplot2
#  ggplot(dat.m, aes(wave, value, colour = variable)) + geom_line() + 
#  scale_colour_manual(values = c('pink','orange','white'))

ba3_w <-ggplot(data=landscape_cc_w_ba, aes(x=year, y=basal_area_m2, colour=species)) + 
  geom_line(size=1.2)+
  scale_colour_manual(values = c("#76BA1B","#006600", "#A4DE02", "orange"))+
  ggtitle("Clearcut management in wind regime") +
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area [m2/ha]")+
  theme_bw()

ba4_w <-ggplot(data=landscape_sw_w_ba, aes(x=year, y=basal_area_m2, colour=species)) + 
  geom_line(size=1.2) +
  scale_colour_manual(values = c("#76BA1B","#006600", "#A4DE02", "orange"))+
  ggtitle("Shelterwood management in wind regime")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area [m2/ha]")+
  theme_bw()

grid.arrange(ba3_w,ba4_w,ncol=1)
#_________________________________________________________________________________
# IN NOT DISTURBANCE REGIME

landscape_cc_ba <- landscape_cc %>% filter(species %in% species.to.keep)
landscape_sw_ba <- landscape_sw %>% filter(species %in% species.to.keep)
#head(landscape_cc2)

#  Example how manually color lines in ggplot2
#  ggplot(dat.m, aes(wave, value, colour = variable)) + geom_line() + 
#  scale_colour_manual(values = c('pink','orange','white'))

ba5 <-ggplot(data=landscape_cc_ba, aes(x=year, y=basal_area_m2, colour=species)) + 
  geom_line(size=1.2)+
  scale_colour_manual(values = c("#76BA1B","#006600", "#A4DE02", "orange"))+
  ggtitle("Clearcut management not disturbance") +
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area [m2/ha]")+
  theme_bw()

ba6 <-ggplot(data=landscape_sw_ba, aes(x=year, y=basal_area_m2, colour=species)) + 
  geom_line(size=1.2) +
  scale_colour_manual(values = c("#76BA1B","#006600", "#A4DE02", "orange"))+
  ggtitle("Shelterwood management not disturbance")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area [m2/ha]")+
  theme_bw()

grid.arrange(ba5,ba6,ncol=1)
# ALL THE SIX TOGETHER

grid.arrange(ba1_wb, ba2_wb, ba3_w, ba4_w,ba5, ba6, ncol=2)

#_______________________________________________________________________________
# BASAL AREA PROPORTION BASED ON DBH CLASSES

#_______________________________________________________________________________
# BASAL AREA PROPORTION BASED ON DBH CLASSES
# Make the distribution of the Basal Area by DBH classes and species composition

area<-landscape_sw_wb$area[1]
print(area)
new_order_gg2=c("piab", "abal", "lade", "pisy", "fasy", "quro", "acps", "frex", "cabe", "bepe", "qupe", "algl", "potr", "poni", "tico", "saca", "rops")


#_______________________________________________________________________________
# IN WIND AND BARK BEETLE REGIME

dynamicstand_sw_wb_0 <- dynamicstand_sw_wb %>% filter(year==0)
dynamicstand_cc_wb_400 <- dynamicstand_cc_wb %>% filter(year==400)
dynamicstand_sw_wb_400 <- dynamicstand_sw_wb %>% filter(year==400)

ba_dbh_sw_wb_0 <- dynamicstand_sw_wb_0[,8:24]
ba_dbh_cc_wb_400 <- dynamicstand_cc_wb_400[,8:24]
ba_dbh_sw_wb_400 <- dynamicstand_sw_wb_400[,8:24]

row.names(ba_dbh_sw_wb_0) <- dynamicstand_sw_wb_0$species
colnames(ba_dbh_sw_wb_0) <- c("DBH5","DBH10","DBH15","DBH20","DBH25","DBH30","DBH35","DBH40","DBH45","DBH50","DBH55","DBH60","DBH65","DBH70","DBH75","DBH80","DBH_max")
row.names(ba_dbh_sw_wb_400) <- dynamicstand_sw_wb_400$species
colnames(ba_dbh_sw_wb_400) <- c("DBH5","DBH10","DBH15","DBH20","DBH25","DBH30","DBH35","DBH40","DBH45","DBH50","DBH55","DBH60","DBH65","DBH70","DBH75","DBH80","DBH_max")
row.names(ba_dbh_cc_wb_400) <- dynamicstand_cc_wb_400$species
colnames(ba_dbh_cc_wb_400) <- c("DBH5","DBH10","DBH15","DBH20","DBH25","DBH30","DBH35","DBH40","DBH45","DBH50","DBH55","DBH60","DBH65","DBH70","DBH75","DBH80","DBH_max")


ba_dbh_sw_wb_0<-ba_dbh_sw_wb_0/area       # divide by the area because of the dynamic stand output
ba_dbh_sw_wb_400<-ba_dbh_sw_wb_400/area   # divide by the area because of the dynamic stand output
ba_dbh_cc_wb_400<-ba_dbh_cc_wb_400/area   # divide by the area because of the dynamic stand output


par(mfrow=c(3,1))
par(mar=c(4,4,4,15))
barplot(as.matrix(ba_dbh_sw_wb_0), col = cols[new_order_gg2], ylab = "Basal area [m3/ha]", ylim=c(0,5), main = "Basal area of initial forest stage", cex.main=1, cex.lab=1)
#legend("topright",                                
#       legend = new_order_gg2,
#       cex=0.9,
#       fill = cols[new_order_gg2])


barplot(as.matrix(ba_dbh_cc_wb_400), col = cols[new_order_gg2], ylab = "Basal area [m3/ha]",  ylim=c(0,5),main = "Basal area of forest at age 400 CC", cex.main=1, cex.lab=1)
#legend("topright",                                
#       legend = new_order_gg2,
#       cex=0.9,
#       fill = cols[new_order_gg2])


barplot(as.matrix(ba_dbh_sw_wb_400), col = cols[new_order_gg2], ylab = "Basal area [m3/ha]",  ylim=c(0,5), main = "Basal area of forest at age 400 SW", cex.main=1, cex.lab=1)
#legend("topright",                                
#       legend = new_order_gg2,
#       cex=0.9,
#       fill = cols[new_order_gg2])

legend(21,12.5,legend = new_order_gg2,cex=1,fill = cols[new_order_gg2], xpd = NA)

#_______________________________________________________________________________

#_______________________________________________________________________________
# IN WIND REGIME

dynamicstand_sw_w_0 <- dynamicstand_sw_w %>% filter(year==0)
dynamicstand_cc_w_400 <- dynamicstand_cc_w %>% filter(year==400)
dynamicstand_sw_w_400 <- dynamicstand_sw_w %>% filter(year==400)

ba_dbh_sw_w_0 <- dynamicstand_sw_w_0[,8:24]
ba_dbh_cc_w_400 <- dynamicstand_cc_w_400[,8:24]
ba_dbh_sw_w_400 <- dynamicstand_sw_w_400[,8:24]

row.names(ba_dbh_sw_w_0) <- dynamicstand_sw_w_0$species
colnames(ba_dbh_sw_w_0) <- c("DBH5","DBH10","DBH15","DBH20","DBH25","DBH30","DBH35","DBH40","DBH45","DBH50","DBH55","DBH60","DBH65","DBH70","DBH75","DBH80","DBH_max")
row.names(ba_dbh_sw_w_400) <- dynamicstand_sw_w_400$species
colnames(ba_dbh_sw_w_400) <- c("DBH5","DBH10","DBH15","DBH20","DBH25","DBH30","DBH35","DBH40","DBH45","DBH50","DBH55","DBH60","DBH65","DBH70","DBH75","DBH80","DBH_max")
row.names(ba_dbh_cc_w_400) <- dynamicstand_cc_w_400$species
colnames(ba_dbh_cc_w_400) <- c("DBH5","DBH10","DBH15","DBH20","DBH25","DBH30","DBH35","DBH40","DBH45","DBH50","DBH55","DBH60","DBH65","DBH70","DBH75","DBH80","DBH_max")


ba_dbh_sw_w_0<-ba_dbh_sw_w_0/area       # divide by the area because of the dynamic stand output
ba_dbh_sw_w_400<-ba_dbh_sw_w_400/area   # divide by the area because of the dynamic stand output
ba_dbh_cc_w_400<-ba_dbh_cc_w_400/area   # divide by the area because of the dynamic stand output


par(mfrow=c(3,1))
par(mar=c(4,4,4,15))
barplot(as.matrix(ba_dbh_sw_w_0), col = cols[new_order_gg2], ylab = "Basal area [m3/ha]", ylim=c(0,5), main = "Basal area of initial forest stage", cex.main=1, cex.lab=1)
#legend("topright",                                
#       legend = new_order_gg2,
#       cex=0.9,
#       fill = cols[new_order_gg2])


barplot(as.matrix(ba_dbh_cc_w_400), col = cols[new_order_gg2], ylab = "Basal area [m3/ha]",  ylim=c(0,5),main = "Basal area of forest at age 400 CC wind", cex.main=1, cex.lab=1)
#legend("topright",                                
#       legend = new_order_gg2,
#       cex=0.9,
#       fill = cols[new_order_gg2])

barplot(as.matrix(ba_dbh_sw_w_400), col = cols[new_order_gg2], ylab = "Basal area [m3/ha]",  ylim=c(0,5), main = "Basal area of forest at age 400 SW wind", cex.main=1, cex.lab=1)
#legend("topright",                                
#       legend = new_order_gg2,
#       cex=0.9,
#       fill = cols[new_order_gg2])

legend(21,12.5,legend = new_order_gg2,cex=0.9,fill = cols[new_order_gg2], xpd = NA)

#_______________________________________________________________________________

#_______________________________________________________________________________
# IN not disturbance REGIME

dynamicstand_sw_0 <- dynamicstand_sw %>% filter(year==0)
dynamicstand_cc_400 <- dynamicstand_cc %>% filter(year==400)
dynamicstand_sw_400 <- dynamicstand_sw %>% filter(year==400)

ba_dbh_sw_0 <- dynamicstand_sw_0[,8:24]
ba_dbh_cc_400 <- dynamicstand_cc_400[,8:24]
ba_dbh_sw_400 <- dynamicstand_sw_400[,8:24]

row.names(ba_dbh_sw_0) <- dynamicstand_sw_0$species
colnames(ba_dbh_sw_0) <- c("DBH5","DBH10","DBH15","DBH20","DBH25","DBH30","DBH35","DBH40","DBH45","DBH50","DBH55","DBH60","DBH65","DBH70","DBH75","DBH80","DBH_max")
row.names(ba_dbh_sw_400) <- dynamicstand_sw_400$species
colnames(ba_dbh_sw_400) <- c("DBH5","DBH10","DBH15","DBH20","DBH25","DBH30","DBH35","DBH40","DBH45","DBH50","DBH55","DBH60","DBH65","DBH70","DBH75","DBH80","DBH_max")
row.names(ba_dbh_cc_400) <- dynamicstand_cc_400$species
colnames(ba_dbh_cc_400) <- c("DBH5","DBH10","DBH15","DBH20","DBH25","DBH30","DBH35","DBH40","DBH45","DBH50","DBH55","DBH60","DBH65","DBH70","DBH75","DBH80","DBH_max")


ba_dbh_sw_0<-ba_dbh_sw_0/area       # divide by the area because of the dynamic stand output
ba_dbh_sw_400<-ba_dbh_sw_400/area   # divide by the area because of the dynamic stand output
ba_dbh_cc_400<-ba_dbh_cc_400/area   # divide by the area because of the dynamic stand output


par(mfrow=c(3,1))
par(mar=c(4,4,4,15))
barplot(as.matrix(ba_dbh_sw_0), col = cols[new_order_gg2], ylab = "Basal area [m3/ha]", ylim=c(0,5), main = "Basal area of initial forest stage", cex.main=1, cex.lab=1)
#legend("topright",                                
#       legend = new_order_gg2,
#       cex=0.9,
#       fill = cols[new_order_gg2])


barplot(as.matrix(ba_dbh_cc_400), col = cols[new_order_gg2], ylab = "Basal area [m3/ha]",  ylim=c(0,5),main = "Basal area of forest at age 400 CC", cex.main=1, cex.lab=1)
#legend("topright",                                
#       legend = new_order_gg2,
#       cex=0.9,
#       fill = cols[new_order_gg2])

barplot(as.matrix(ba_dbh_sw_400), col = cols[new_order_gg2], ylab = "Basal area [m3/ha]",  ylim=c(0,5), main = "Basal area of forest at age 400 SW", cex.main=1, cex.lab=1)
#legend("topright",                                
#       legend = new_order_gg2,
#       cex=0.9,
#       fill = cols[new_order_gg2])

legend(21,12.5,legend = new_order_gg2,cex=0.9,fill = cols[new_order_gg2], xpd = NA)

#_______________________________________________________________________________


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

legend(22,24, legend = names(colors),cex=1.5,fill = colors, xpd = NA)

#_______________________________________________________________________________

# DEEP UNDERSTANDING BA DBH DYNAMICS

# Working with DPLYR library to filter, group, mutate and arrange

#_______________________________________ CC year 400

dynamicstand_cc_400 <- dynamicstand_cc%>%
  filter(year==399)

ba_dbh_cc_400 <- dynamicstand_cc_400[,8:24]
ba_dbh_cc_400

row.names(ba_dbh_cc_400) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","qupe","algl","potr","poni","tico","saca")
ba_dbh_cc_400

colnames(ba_dbh_cc_400) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")

# barplot(as.matrix(ba_dbh_cc_400))

#_________________________________________ CC year 0

dynamicstand_cc_0 <- dynamicstand_cc%>%
  filter(year==0)

ba_dbh_cc_0 <- dynamicstand_cc_0[,8:24]
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

dynamicstand_cc_100 <- dynamicstand_cc%>%
  filter(year==100)

ba_dbh_cc_100 <- dynamicstand_cc_100[,8:24]

row.names(ba_dbh_cc_100) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca", "rops")

colnames(ba_dbh_cc_100) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")

#_________________________________________ CC year 200

dynamicstand_cc_200 <- dynamicstand_cc%>%
  filter(year==200)

ba_dbh_cc_200 <- dynamicstand_cc_200[,8:24]

row.names(ba_dbh_cc_200) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","qupe","algl","potr","poni","tico","saca")

colnames(ba_dbh_cc_200) <- c("dbh5","dbh10","dbh15","dbh20","dbh25","dbh30","dbh35","dbh40","dbh45","dbh50","dbh55","dbh60","dbh65","dbh70","dbh75","db80","dbh_max")

#_________________________________________ CC year 300

dynamicstand_cc_300 <- dynamicstand_cc%>%
  filter(year==300)

ba_dbh_cc_300 <- dynamicstand_cc_300[,8:24]

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

row.names(ba_dbh_sw_200) <- c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","qupe","algl","potr","poni","tico","saca", "rops")

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

barplot(as.matrix(ba_dbh_cc_0), col = cl)
barplot(as.matrix(ba_dbh_cc_0), col = viridis(17))
barplot(as.matrix(ba_dbh_cc_0), col = rgb.palette(17))


rgb.palette <- colorRampPalette(c("#7F0000", "red", "#FF7F00", "yellow", "#7FFF7F","cyan","#007FFF", "blue", "#00007F"),
                                space = "rgb")

dev.off()

#   BAR PLOT CC 0 __________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_cc_0), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Clear cut Landscape Basal Area divided in DBH classes by species Tran. Period year 0", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=0.9,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT CC 100 __________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_cc_100), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Clear cut Landscape Basal Area divided in DBH classes by species Tran. Period year 100", cex.main=2, cex.lab=1.5)

#   Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=0.9,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT CC 200 __________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_cc_200), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Clear cut Landscape Basal Area divided in DBH classes by species Tran. Period year 200", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=0.9,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT CC 300 __________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_cc_300), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Clear cut Landscape Basal Area divided in DBH classes by species Tran. Period year 300", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=0.9,
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
       cex=0.9,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT SW 0__________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_sw_0), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Shelterwood Landscape Basal Area divided in DBH classes by species Tran. Period year 0", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=0.9,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT SW 100 __________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_sw_100), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Shelterwood Landscape Basal Area divided in DBH classes by species Tran. Period year 100", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=0.9,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT SW 200__________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_sw_200), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Shelterwood Landscape Basal Area divided in DBH classes by species Tran. Period year 200", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=0.9,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT SW 300__________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_sw_300), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Shelterwood Landscape Basal Area divided in DBH classes by species Tran. Period year 300", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=0.9,
       fill = rgb.palette(17))

#   BAR PLOT __________________________________________________________________________________________________________________

#   BAR PLOT SW 400 __________________________________________________________________________________________________________________

barplot(as.matrix(ba_dbh_sw_400), col = rgb.palette(17), ylab = "Landscape BA (m2)", main = "Shelterwood Landscape Basal Area divided in DBH classes by species Tran. Period year 400", cex.main=2, cex.lab=1.5)

# Add legend to barplot

legend("topright",                                
       legend = c("piab","abal","lade","pisy","fasy","quro","acps","frex","cabe","bepe","qupe","algl","potr","poni","tico","saca","rops"),
       cex=0.9,
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

#_____________________________________________

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

hist(prop_killed_vol_ha_year_cc$perc.vol, main = "Landscape proportion of killed volume (m3/ha) by wind per year in CC",cex.main = 1.5, xlab = "Killed volume / Total volume (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,140))

legend("topright", c("0.226155 m3"), cex = 0.9, title = "Average killed volume (m3/ha) per year", text.font = 3, bg='lightpink')

# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(prop_killed_vol_ha_year_sw$perc.vol, main = "Landscape proportion of killed volume (m3/ha) by wind per year in SW",cex.main = 1.5, xlab = "Killed volume / Total volume (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,140))

legend("topright", c("0.1924036 m3"), cex = 0.9, title = "Average killed volume (m3/ha) per year", text.font = 3, bg='lightpink')

#____________________________________________________________________________________________________________________________________
#_________________________________________________________________________________________________________________
#   NEW KILLED VOLUME CALCULATION INCLUDING BARK BEETLE


# Wind AND bark beetle disturbance impact in the landscape volume in percentages
# wind and bark beetle regime

killed_volume_cc_w_wb <- sum(wind_cc_wb$killedVolume)                   # 5929296 m3
killed_volume_cc_w_wb
killed_volume_cc_bb_wb <- sum(barkbeetle_cc_wb$killedVolume)            # 4706904
killed_volume_cc_bb_wb
killed_volume_cc_dist_wb <- killed_volume_cc_w_wb + killed_volume_cc_bb_wb   # 10636200
killed_volume_cc_dist_wb
killed_volume_per_year_cc_wb <- killed_volume_cc_dist_wb/400            # 26590.5 
killed_volume_per_year_cc_wb
killed_volume_per_year_cc_ha_wb <- killed_volume_per_year_cc_wb/17749.26
killed_volume_per_year_cc_ha_wb                                         # 1.498119 m3   # 1.747298

#_____________________________________________

killed_volume_sw_w_wb <- sum(wind_sw_wb$killedVolume)                   # 5407252 m3
killed_volume_sw_w_wb
killed_volume_sw_bb_wb <- sum(barkbeetle_sw_wb$killedVolume)            # 4388046
killed_volume_sw_bb_wb
killed_volume_sw_dist_wb <- killed_volume_sw_w_wb + killed_volume_sw_bb_wb  # 9795297
killed_volume_sw_dist_wb
killed_volume_per_year_sw_wb <- killed_volume_sw_dist_wb/400            # 24488.24
killed_volume_per_year_sw_wb
killed_volume_per_year_sw_ha_wb <- killed_volume_per_year_sw_wb/17749.26
killed_volume_per_year_sw_ha_wb                                         # 1.379677 m3                       


# FILTER AND GROUP FOR THE NEEDED COLUMNS AND GROUP BY YEAR TO CREATE NEW DATAFRAMES FOR THE % ANALSIS ON THE KILLED VOLUME PER YEAR

dfnew1_cc_wb <- landscape_cc_wb[,c(1,8)]

df_vol_cc_wb = dfnew1_cc_wb %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')

dfnew1_sw_wb <- landscape_sw_wb[,c(1,8)]

df_vol_sw_wb = dfnew1_sw_wb %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year_cc_wb <- df_vol_cc_wb %>% mutate(perc.vol=100*killed_volume_per_year_cc_ha_wb/tot_vol)
prop_killed_vol_ha_year_cc_wb
summary(prop_killed_vol_ha_year_cc_wb)

prop_killed_vol_ha_year_sw_wb <- df_vol_sw_wb %>% mutate(perc.vol=100*killed_volume_per_year_sw_ha_wb/tot_vol)
prop_killed_vol_ha_year_sw_wb
summary(prop_killed_vol_ha_year_sw_wb)

par(mfrow = c(1,2))

hist(prop_killed_vol_ha_year_cc_wb$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind and bark beetles per year in CC",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD", ylim = c(0,90))

legend("topright", c("1.50 m3 / 0.55 %"), cex = 0.55, title = "Average killed volume [m3/ha/year] / avarage % on total volume", text.font = 3, bg='lightpink')

# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(prop_killed_vol_ha_year_sw_wb$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind and bark beetles per year in SW",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD", ylim = c(0,90))

legend("topright", c("1.38 m3 / 0.53 %"), cex = 0.55, title = "Average killed volume [m3/ha/year] / avarage % on total volume", text.font = 3, bg='lightpink')


### year by year relative proportion ##

# FILTER AND GROUP FOR THE NEEDED COLUMNS AND GROUP BY YEAR TO CREATE NEW DATAFRAMES FOR THE % ANALSIS ON THE KILLED VOLUME PER YEAR

bb_killvol_ha_cc_wb <- barkbeetle_cc_wb$killedVolume/abeUnit_cc_wb$area
bb_killvol_ha_sw_wb <- barkbeetle_sw_wb$killedVolume/abeUnit_sw_wb$area

# Add a column of variables in this case volume killed in % of the total ha avg
dist_per_cc_wb <- abeUnit_cc_wb %>% mutate(perc.vol=100*bb_killvol_ha_cc_wb/abeUnit_cc_wb$volume)
summary(dist_per_cc_wb)

dist_per_sw_wb <- abeUnit_sw_wb %>% mutate(perc.vol=100*bb_killvol_ha_sw_wb/abeUnit_sw_wb$volume)
summary(dist_per_sw_wb)

par(mfrow = c(1,2))  # 763 m3 of difference in CC than in SW

# natural logarithm is based on the "Euler's number" = e ≈ 2,71828183

hist(dist_per_cc_wb$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by bark beetles per year in CC",cex.main = 1, xlab = " [Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD",xlim = c(0,6), ylim = c(0,100))

legend("topright", c("0.655 m3 / 0.240 %"), cex = 0.55, title = "Average percentage of killed volume [m3/ha/year] by bark beetle", text.font = 3, bg='lightpink')
# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(dist_per_sw_wb$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by bark beetles per year in SW",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD",xlim = c(0,6), ylim = c(0,100))

legend("topright", c("0.612 m3 / 0.232 %"), cex = 0.55, title = "Average percentage of killed volume [m3/ha/year] by bark beetle", text.font = 3, bg='lightpink')

#_________________________________________________________________________________________________
# Only wind
# Wind disturbance impact in the landscape volume in percentages

killed_volume_cc_w <- sum(wind_cc_w$killedVolume)                # 7261776 m3
killed_volume_cc_w
killed_volume_per_year_cc_w <- killed_volume_cc_w/400            # 18154.44
killed_volume_per_year_cc_w
killed_volume_per_year_cc_ha_w <- killed_volume_per_year_cc_w/17749.26
killed_volume_per_year_cc_ha_w                                 # 1.022828 m3

#_____________________________________________

killed_volume_sw_w <- sum(wind_sw_w$killedVolume)                # 7040383 m3
killed_volume_sw_w
killed_volume_per_year_sw_w <- killed_volume_sw_w/400            # 17600.96
killed_volume_per_year_sw_w
killed_volume_per_year_sw_ha_w <- killed_volume_per_year_sw_w/17749.26
killed_volume_per_year_sw_ha_w                                   # 0.9916446 m3                        


dfnew1_cc_w <- landscape_cc_w[,c(1,8)]

df_vol_cc_w = dfnew1_cc_w %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')

dfnew1_sw_w <- landscape_sw_w[,c(1,8)]

df_vol_sw_w = dfnew1_sw_w %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year_cc_w <- df_vol_cc_w %>% mutate(perc.vol=100*killed_volume_per_year_cc_ha_w/tot_vol)
summary(prop_killed_vol_ha_year_cc_w)

prop_killed_vol_ha_year_sw_w <- df_vol_sw_w %>% mutate(perc.vol=100*killed_volume_per_year_sw_ha_w/tot_vol)
summary(prop_killed_vol_ha_year_sw_w)

par(mfrow = c(1,2))

hist(prop_killed_vol_ha_year_cc_w$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind per year in CC",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD", ylim = c(0,60))

legend("topright", c("1.023 m3 / 0.344 %"), cex = 0.55, title = "Average killed volume [m3/ha/year] / avarage % on total volume", text.font = 3, bg='lightpink')

# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(prop_killed_vol_ha_year_sw_w$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind per year in SW",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD", ylim = c(0,60))

legend("topright", c("0.992 m3 / 0.350 %"), cex = 0.55, title = "Average killed volume [m3/ha/yea] / avarage % on total volume", text.font = 3, bg='lightpink')
