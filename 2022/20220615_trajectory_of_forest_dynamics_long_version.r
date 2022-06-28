#_______________________________________________________________________________
# Loop to see into the transitional period but interatly

# install.packages("RSQLite")
library(RSQLite)
library(dplyr)
library(tidyr)
library(ggplot2)
library(gridExtra)   
library(fields)


#-------------------------------------------------------------------------------
# Path to search the data
#dataroot <- ("C:/iLand/2022/20220422_browsing_test/all_cc/")
dataroot <- ("C:/iLand/2022/20220604_final_test/DB_final/")                        # Root for the selection of the data in the computer

# CREATE NEW EMPTY DATAFRAME                                                 # this is needed to create the data frames at the end of the loop 

removals<-c()

lnd<-c()

aUnit<-c()

bb <-c()

w <- c()

damage.all<-c()

dys <- c()

variables.all <- c()


# NAMES OF THE DATABESES CREATED FOR ANY SIMULATION
#cases <-c("B0_Tby0_PRby0","B0_Tby5_PRby0","B1_Tby0_PRby0", "B1_Tby5_PRby0", "Btot_Tby0_PRby0", "Btot_Tby5_PRby0")  # to say what select

#-------------------------------------------------------------------------------
# FOR CYCLE FOR THE IMPORT AND ANALYSIS OF THE LANDSCAPE VOLUME AND VOLUME HARVESTED

all_v <- list.files(dataroot, ".sqlite")                              # alternative way to select all the databases within a folder


for (i in (1:length(all_v)))  {                                       # We read in the files in the loop. The "i" is for the x-> 1:i 
  
  # "for" = for argument, "(in"= in, "1"= first element of the for cycle to analysis, ": length(cases)))" = through the length of the object cases  
  # PAY ATTENTION this part HERE is just FOR TESTING
  
  #i<-1                                                               # to test but remember to don't run also the }
  
                                                                      # ORDINATION OF THE CASE TO IMPORT AS DATABASE see line 45 the loop will be as long as number of cases
  
  
  # Name of the database
  file <-paste0(dataroot, all_v[i])                            # File to read here the case is always the actual case in the loop
  
  
  case<- strsplit(all_v[i],".s")[[1]][1]
  
  # "file"= name of the object, "paste0"+ function to create a NAME for a computer path of selection of data/objects
  
  # ALTERNATIVE WAY
  # f <-paste0(dataroot,fs,".sqlite")
  
  print(file)
  
  # connect to the database of clear cut model
  sqlite.driver <- dbDriver("SQLite")
  db1 <- dbConnect(sqlite.driver, dbname = file)  # connect to the file
  tables.in.the.file<-dbListTables(db1)           # explore the tables in the file
  print(tables.in.the.file)
  
  
  #-----------------------------------------------------------------------------
  # LOAD THE DATABASE
  
  landscape <- dbReadTable(db1,"landscape")
  abeUnit <- dbReadTable(db1, "abeUnit")
  abeStandRemoval <- dbReadTable(db1,"abeStandRemoval")
  barkbeetle <- dbReadTable(db1,"barkbeetle")
  wind <- dbReadTable(db1,"wind")
  dynamicstand <- dbReadTable(db1,"dynamicstand")
  carbon <- dbReadTable(db1,"carbon")
  carbonflow <- dbReadTable(db1, "carbonflow")
  
  dbDisconnect(db1)    # close the file
  
  
  #-----------------------------------------------------------------------------
  # CREATE THE Picea Abies PROPORTION AT LANDSCAPE SCALE
  
  # spec_prop = landscape %>% group_by(year)  %>%
  #  summarise(tot_vol = sum(volume_m3),
   #           .groups = 'drop')
  
  
  #count_ha_tot
  #count_ha_sp
  #prop_sp <- spec_prop %>% mutate(perc.sp=100*count_ha_sp/count_ha_tot)
  
  
  #prop_killed_vol_ha_year
  #summary(prop_killed_vol_ha_year)
  
  
  #-----------------------------------------------------------------------------
  # CREATE SHANNON VARIABLE
  
  annual.data<-landscape %>% group_by(year) %>% filter(year>0) %>% summarize(VOL.tot=sum(volume_m3), BA.tot=sum(basal_area_m2), count.tot=sum(count_ha))
  annual.spec.data<-landscape %>% group_by(year, species) %>%  filter(year>0) %>% summarize(VOL=(volume_m3), BA=(basal_area_m2), count=sum(count_ha))
  
  print(head(annual.data))
  print(head(annual.spec.data))
  
  S<-landscape %>% group_by(year) %>% filter(volume_m3>0 & year>0) %>% summarise(n=n())   # number of species in each year  (added the filter to count non-zero volumes, now it is okay)
  print(S$n)
  
  
  t<-annual.spec.data %>% right_join(annual.data, by="year")  %>% 
    mutate(prop.VOL=VOL/VOL.tot, prop.BA=BA/BA.tot, prop.count=count/count.tot) %>% 
    filter(prop.VOL>0)  # here I also filtering them to have only records with m3>0
  
  #https://www.statology.org/shannon-diversity-index/
  #https://www.statology.org/shannon-diversity-index-calculator/
  
  # Shannon diversity index (SDI): this is already Shannon.... that extra step by dividing the by S$n is making equitability index based on the link above.
  # so maybe we can make shannon based on BA, VOL and number of trees.... (? can discuss or save all 3 and will see...)
  
  H.BA<-t %>% group_by(year) %>% summarize(H=-1*sum(prop.BA*log(prop.BA)))
  H.VOL<-t %>% group_by(year) %>% summarize(H=-1*sum(prop.VOL*log(prop.VOL)))
  H.count<-t %>% group_by(year) %>% summarize(H=-1*sum(prop.count*log(prop.count)))   # here I just put the proportion of number of trees
  set.panel(3,1)
  plot(H.BA)
  plot(H.VOL)
  plot(H.count)
  
  #The higher the value of H, the higher the diversity of species in a particular community. 
  #The lower the value of H, the lower the diversity. 
  #A value of H = 0 indicates a community that only has one species.
  
  
  # Shannon Equitability Index (SEI).... maybe we do not need this at all.....
  SEI<-H.BA$H/log(S$n)
  SEI[which(is.na(SEI)==T)]<-0
  
  # Pioneer species proportion based on BA
  
  earlyspecs<-c("lade","acps","frex","cabe","bepe","alin","algl","acca","acpl","soau","soar","coav","alvi","potr","poni","ulgl","saca","rops")
  
  early.spec.prop<-t %>% filter(species %in% earlyspecs) %>% summarize(BA=sum(prop.BA))
    
  esp<-data.frame(year=c(1:max(landscape$year)))
  esp<-esp %>% left_join(early.spec.prop, by="year")
  esp$BA[which(is.na(esp$BA)==T)]<-0
  
  #-----------------------------------------------------------------------------
  # CREATE THE DATA FRAME FOR ADD VARIABLES ABOUT CARBON IN THE FINAL DATA FRAME
  
  ab.tot.c<- data.frame(carbon %>% 
                          group_by(year) %>% 
                          summarise(tot_carbon=sum(stem_c, branch_c, foliage_c, coarseRoot_c, fineRoot_c, regeneration_c, snags_c, snagsOther_c, downedWood_c, litter_c, soil_c)))
  
  
  #-----------------------------------------------------------------------------
  # CREATE A NEW DATA FRAME TO WORK ON THE SPECIFIC VARIABLES NEEDED 
  
  head(landscape)
  head(dynamicstand)
  
  # TO UNDERSTAND THE OPERATORS %>% AND %IN% HAVE TO STUDY THEM IN DATACAMP AND IN DPLER CRAN PACKAGES
  
  ab.lnd.v<- data.frame(landscape %>% 
                          group_by(year) %>% 
                          filter(year>0) %>%
                          summarise(tot_volume=sum(volume_m3),living_c=sum(total_carbon_kg), count_ha=sum(count_ha), tot_ba=sum(basal_area_m2),npp=sum(NPP_kg), LAI=sum(LAI), sapling=sum(cohort_count_ha),growth_m3=sum(gwl_m3)))

  
  dynamicstand_1 <-dynamicstand %>% filter(year>0)                            # THIS IS NEEDED FOR MAKE THE DATA FRAME dynamicstand OF THE SAME SIZE OF THE carbon AND carbonflow. WE DID THE SAME FOR THE SELECTED VARIABLES IN LANDSCAPE
  
  # CREATE THE NEW DATA FRAME FOR VARIABLES 
  
  variables <- data.frame(case=case,
                          year=dynamicstand_1$year,
                          h=dynamicstand_1$height_mean,
                          dbh=dynamicstand_1$dbh_mean,
                          age=dynamicstand_1$age_mean,
                          Rh=carbonflow$Rh,
                          NPP=carbonflow$NPP,
                          GPP=carbonflow$GPP,
                          NEP=carbonflow$NEP,
                          H.count=H.count$H,
                          H.VOL=H.VOL$H,
                          H.BA=H.BA$H,
                          SEI=SEI,
                          esp_BA_prop=esp$BA)
  
  # ADD LANDSCAPE VARIABLES AT V DATA FRAME
  
  variables = inner_join(variables, ab.lnd.v, by="year")
  variables = inner_join(variables, ab.tot.c, by="year")
  
  # variables[which(is.na(damage$wind)==TRUE)] <-0                              # FOR MAKE THE na = 0 !!!! "
 
   head(variables)
  
  #-----------------------------------------------------------------------------
  # CREATE THE CALCULATION FOR DAMAGES LOOK LINE 370
  
  landscape.area<-landscape$area[1]                                             # CREATE THE VARIABLE FOR LANDSCAPE AREA          
  
  lnd_volume = landscape %>% group_by(year)  %>%                                # CREATE THE SUMMARIZATION OF THE SPECIES VOLUME PROPORTION TO CREATE A TOTAL LANDSCAPE VOLUME
    summarise(tot_vol = sum(volume_m3),
              .groups = 'drop')
  
  head(lnd_volume)                                                              
  
  # wind and barkbeetle merging:
  
  head(barkbeetle)
  head(wind)
  
  
  damage <- data.frame(year=barkbeetle$year,                                      # CREATE THE DATA FRAME FOR FOR DAMAGE OF BARKBEETLE
                       barkbeetle=barkbeetle$killedVolume, 
                       case=case)
  
  # ADD WIND IMPACT IN THE DAMAGE DATA FRAME
  damage<-left_join(damage,wind[,c(1,8)],by=("year"))                           # LEFT_JOIN IS A FUNCTION TO JOIN A VARIABLE IN THIS CASE COLUMN 1 AND 2 AND MANY ROWS BASE ON YEAR VARIABLE NUMBER OF ROWS
  damage<-left_join(damage,lnd_volume,by=("year"))                              # ADD THE LANDSCAPE VOLUME IN THE DAMAGE DATA FRAME
  colnames(damage)<-c("year","barkbeetle","case","wind","volume")               # GIVE THE NAME AT EVERY VARIABLE
  
  # damage$wind[which(is.na(damage$wind)==TRUE)] <-0                            # FOR MAKE THE na = 0 !!!! "
  
  head(damage)
  
  #-----------------------------------------------------------------------------
  # Make the 3 categories of removals:
  
  activity.names<-unique(abeStandRemoval$activity)                              # here I list all different type of activities
  
  swcuts<- grepl("sw",activity.names)                                           # I look for only which has "sw" this grepl gives TRUE/FALSE
  activity.names.sw<-activity.names[swcuts]                                     # collect the activity names with sw
  activity.names.notsw<-activity.names[!swcuts]                                 # collect the activity names withOUT sw
  
  #print(activity.names.sw)
  #print(activity.names.notsw)
  
  # Here I filter only the listed activity names and calculate thinning/finalcut values for every year 
  # (each line is per ha for a stand, so I scale with the area, sum up all the harvest on the landscape and then divide it with the whole area to get again per ha)
  
  # TO UNDERSTAND THE OPERATORS %>% AND %IN% HAVE TO STUDY THEM IN DATACAMP AND IN DPLER CRAN PACKAGES
  
  ab.regcuts<- data.frame(abeStandRemoval %>% filter(activity %in% activity.names.sw)    %>% 
                            group_by(year)   %>%   summarise(volume=sum(volumeThinning*area)/landscape.area, type="regcut", run=case))
  
  ab.finalcuts<- data.frame(abeStandRemoval %>% filter(activity %in% activity.names.sw)    %>% 
                              group_by(year)   %>%   summarise(volume=sum(volumeFinal*area)/landscape.area, type="finalcut", run=case))
  
  ab.thinnig<- data.frame(abeStandRemoval %>% filter(activity %in% activity.names.notsw)    %>% 
                            group_by(year)   %>%   summarise(volume=sum(volumeThinning*area)/landscape.area, type="thinning", run=case))
  
  ab.salvaged<- data.frame(abeStandRemoval %>% filter(activity %in% activity.names.sw)    %>% 
                             group_by(year)   %>%   summarise(volume=sum(volumeSalvaged*area)/landscape.area, type="salvager", run=case))
  
  # CREATE A FOR CYCLE INTO THE FOR CYCLE
  if (length(activity.names[swcuts])==0) {
    
    ab.finalcuts<- data.frame(abeStandRemoval %>% filter(activity %in% activity.names.notsw)    %>% 
                                group_by(year)   %>%   summarise(volume=sum(volumeFinal*area)/landscape.area, type="finalcut", run=case))
    
  }                                                                             # CLOSE THE litte FOR CYCLE
  
  
  # CREATE THE VARIABLE FOR THE DIFFERENT WOOD REMOVAL ACTIVITY
  removals<-rbind(removals,ab.regcuts,ab.finalcuts,ab.thinnig,ab.salvaged)
  
  # Collect landscape data FOR CREATE THE VARIABLE LND FOR ALL THE RUNS
  landscape<- (landscape %>% mutate(run=case))
  lnd<-rbind(lnd, landscape)
  
  # Collect abeUnit data FOR CREATE THE VARIABLE ABEUNIT FOR ALL THE RUNS
  abeUnit<-(abeUnit %>% mutate(run=case))
  aUnit<-rbind(aUnit, abeUnit)
  
  # Collect barkbeetle data FOR CREATE THE VARIABLE BB FOR ALL THE RUNS
  barkbeetle <-(barkbeetle %>% mutate(run=case))
  bb <-rbind(bb, barkbeetle)
  
  # Collect wind data FOR CREATE THE VARIABLE WIND FOR ALL THE RUNS
  wind <-(wind %>% mutate(run=case))
  w <-rbind(w, wind)
  
  # Collect dynamicstand data FOR CREATE THE VARIABLE WIND FOR ALL THE RUNS
  dynamicstand <-(dynamicstand %>% mutate(run=case))
  dys <-rbind(dys, dynamicstand)
  
  # CREATE THE VARIABLE DAMAGE FOR ALL THE RUNS
  damage.all<-rbind(damage.all, damage)                                         # PUT ALL THE DAMAGE RUNS INTO A SINGLE DATAFRAME WITH DIFF CASES TO BE PLOT ALL TOGETHER IN LINE 370
  
  # CREATE THE VARIABLES DF FOR ALL THE RUNS
  variables.all<-rbind(variables.all, variables) 
  
}                                                                               # CLOSE THE WHOLE FOR CYCLE


write.csv(variables.all, "C:/iLand/2022/20220604_final_test/DB_final/variables.all_20220627.csv", row.names = FALSE)

# quote=FALSE

#-------------------------------------------------------------------------------
# STATISTICS: TO SUMMARIZE THE CUTTING ACTIVITIES

values<-data.frame(removals %>% 
                     group_by(run, type) %>% 
                     summarise(volume=mean(volume)))
print(values)

# STAT ON FINALCUT
summary(values %>% filter(run == "B0_Tby0_PRby0", type=="finalcut"))     
summary(values %>% filter(run == "B0_Tby5_PRby0", type=="finalcut"))
summary(values %>% filter(run == "B1_Tby0_PRby0", type=="finalcut"))
summary(values %>% filter(run == "B1_Tby5_PRby0", type=="finalcut"))
summary(values %>% filter(run == "Btot_Tby0_PRby0", type=="finalcut"))
summary(values %>% filter(run == "Btot_Tby5_PRby0", type=="finalcut"))

# STAT ON REGCUT
summary(values %>% filter(run == "B0_Tby0_PRby0", type=="regcut"))     
summary(values %>% filter(run == "B0_Tby5_PRby0", type=="regcut"))
summary(values %>% filter(run == "B1_Tby0_PRby0", type=="regcut"))
summary(values %>% filter(run == "B1_Tby5_PRby0", type=="regcut"))
summary(values %>% filter(run == "Btot_Tby0_PRby0", type=="regcut"))
summary(values %>% filter(run == "Btot_Tby5_PRby0", type=="regcut"))

# STAT ON THINNING
summary(values %>% filter(run == "B0_Tby0_PRby0", type=="thinning"))     
summary(values %>% filter(run == "B0_Tby5_PRby0", type=="thinning"))
summary(values %>% filter(run == "B1_Tby0_PRby0", type=="thinning"))
summary(values %>% filter(run == "B1_Tby5_PRby0", type=="thinning"))
summary(values %>% filter(run == "Btot_Tby0_PRby0", type=="thinning"))
summary(values %>% filter(run == "Btot_Tby5_PRby0", type=="thinning"))


# STAT ON Salvaging
summary(values %>% filter(run == "B0_Tby0_PRby0", type=="salvager"))     
summary(values %>% filter(run == "B0_Tby5_PRby0", type=="salvager"))
summary(values %>% filter(run == "B1_Tby0_PRby0", type=="salvager"))
summary(values %>% filter(run == "B1_Tby5_PRby0", type=="salvager"))
summary(values %>% filter(run == "Btot_Tby0_PRby0", type=="salvager"))
summary(values %>% filter(run == "Btot_Tby5_PRby0", type=="salvager"))

#  to have the results you have to decide only one type at time
#  values_sum <- values %>% filter(run == "brow0", type=="finalcut", type == "thinning", type == "regcut")
#  values_sum

#-------------------------------------------------------------------------------
# PDF NAME NEED TO OPEN A PDF WRITER AND GIVE IT THE ROOT, THE NAME, AND THE SIZE

pdf(paste0(dataroot, "20220611_final_test_sw.pdf"), height=8, width=12)
# pdf(paste0(dataroot, "20220428_sw.pdf"), height=8, width=12)
# pdf(paste0(dataroot, "20220414c.pdf"), height=10, width=25)



#-------------------------------------------------------------------------------
# This tells the colors:

species.we.have<-unique(lnd$species)                                            # IT IS SAYING WHICH SPECIES WE HAVE IN THE DATABASE IN THIS CASE LANDSCAPE


# LIST OF ALL POSSIBLE SPECIES

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


# COLORATION ORDER FOR ALL THE POSSIBLE SPECIES

new_order_gg.all=c("alvi","alin", "acpl", "rops","bepe" ,"coav", "casa", "ulgl", "tipl",  "soau", "soar", "saca",  "pini", "pice",
                   "poni", "algl", "tico", "potr",  "frex","cabe", "acps",  "lade", "abal",  "qupu", "qupe","quro","pisy", "fasy", "piab")


# This will show at the end only the species we really have on the landscape. 

cols<-cols.all[names(cols.all) %in% species.we.have]
new_order_gg<- new_order_gg.all[new_order_gg.all %in% species.we.have]

# STARTING PLOTS

#-------------------------------------------------------------------------------
# COLUMN DIAGRAM PLOT ON THE HARVEST

ggplot(removals, aes(year, volume, fill=factor(type, levels=c( "regcut","finalcut","thinning","salvager"))))+
  geom_bar(position="stack", stat="identity")+
  facet_wrap(~run, ncol=1)+
  labs(x = "Year",y="Removed volume m3/ha",fill = "Removal")+
  scale_fill_manual(values=c("#4897D8","#FFDB5C","#FA6E59","#B3C100"))+               #"#B7B8B6","#34675C","#B3C100" grey and greens
  theme_bw()

# Make a plot with ggplot, volume, colored by species for the transitional period for Clear cut management system
#-------------------------------------------------------------------------------
# PLOT LANDSCAPE VOLUME PLOT FOR CASES (GEOM AREA)

g1 <- ggplot(lnd, aes(year,volume_m3, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  ggtitle("Landscape Volume by species")+
  facet_wrap(~run, ncol=1)+
  labs(x = "Year",y="Volume [m3/ha]",fill = "Species")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,500)+
  theme_bw()


#-------------------------------------------------------------------------------
# (SHOULD BE REALIZED) PLOT 2 "Y" AXIS WITH relationship between realized harvest and volume increasing in the landscape
# Total realized harvest at landscape level in average per ha

g2 <- ggplot(aUnit, aes(year,realizedHarvest, color=case))+
  geom_line(size=1.2, show.legend = F)+
  facet_wrap(~run, ncol=1)+
  ylim(0,45)+
  ggtitle("Realized Harvest Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest [m3/ha]")+
  theme_bw()


#-------------------------------------------------------------------------------

# SPECIES specificaly BA:

#species.to.keep<-c("piab","pisy", "fasy","qupe")

#lnd2 <- lnd %>% filter(species %in% species.to.keep)

#ggplot(data=lnd2, aes(x=year, y=basal_area_m2, colour=species)) + 
#  geom_line(size=1.2)+
#  scale_colour_manual(values = c("#76BA1B","#006600", "#A4DE02", "orange"))+
#  ggtitle("Clearcut management in brow pressure 0") +
#  theme(plot.title = element_text(hjust = 0.5))+
#  ylab("Basal area [m2/ha]")+
#  theme_bw()

#-------------------------------------------------------------------------------
# PLOT BASAL AREA GEOM_LINE AT LANDSCAPE LEVEL BY SPECIES SELECTED

# SPECIES specificaly BA:

species.to.keep<-c("piab", "fasy","qupe", "pisy")


lnd2 <- lnd %>% filter(species %in% species.to.keep)

b1 <- ggplot(data=lnd2, aes(x=year, y=basal_area_m2, color=species)) + 
  geom_line(size=1.2)+
  ggtitle("Basal area by species") +
  facet_wrap(~run, ncol=1)+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area [m2/ha]")+  
  theme_bw()

#-------------------------------------------------------------------------------
# PLOT TOTAL AVG BASAL AREA AT LANDSCAPE LEVEL BY SPECIES

g3 <- ggplot(lnd, aes(year, basal_area_m2, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  ggtitle("Total Basal Area")+
  facet_wrap(~run, ncol=1)+
  labs(x = "Year",y="Basal Area [m2/ha]",fill = "Species")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme_bw()

#-------------------------------------------------------------------------------
# PLOT SUM BASAL AREA AT LANDSCAPE

b2 <- ggplot(data=dys, aes(x=year, y=basalarea_sum/landscape.area, color="red")) + 
  geom_line(size=1.2)+
  ggtitle("Avarege Basal area") +
  facet_wrap(~run, ncol=1)+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area [m2/ha]")+  
  theme_bw()

#-------------------------------------------------------------------------------
# PLOT DBH GEOM_LINE AT LANDSCAPE LEVEL BY SPECIES

species.to.keep<-c("piab", "fasy","qupe", "pisy")


lnd2 <- lnd %>% filter(species %in% species.to.keep)

b3 <- ggplot(data=lnd2, aes(x=year, y=dbh_avg_cm, color=species)) + 
  geom_line(size=1.2)+
  ggtitle("Avarage DBH by species") +
  facet_wrap(~run, ncol=1)+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("DBH [cm]")+  
  theme_bw()


#-------------------------------------------------------------------------------
# PLOT DBH GEOM_AREA AT LANDSCAPE LEVEL AVARAGE ALL SP TOGETHER

g4 <- ggplot(data=dys, aes(x=year, y=dbh_mean)) + 
  geom_area(size=1.2)+
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  ggtitle("Avarage DBH by species") +
  facet_wrap(~run, ncol=1)+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("DBH [cm]")+  
  theme_bw()

# SD DBH / try with violin plots

# ggplot(data=dys, aes(x=year, y=dbh_sd)) + 
#  geom_area(size=1.2)+
#  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
#  ggtitle("Avarage DBH by species") +
#  facet_wrap(~run, ncol=1)+
#  theme(plot.title = element_text(hjust = 0.5))+
#  ylab("DBH [cm]")+  
#  theme_bw()

#-------------------------------------------------------------------------------
# PLOT NUMBER OF STEMS GEOM_LINE AT LANDSCAPE LEVEL BY SPECIES

# lnd2 <- lnd %>% filter(species %in% species.to.keep)    --- ADD IF YOU WANT SELECT SPECIES TO KEEP

b4 <- ggplot(data=lnd2, aes(x=year, y=count_ha, color=species)) + 
  geom_line(size=1.2)+
  ggtitle("N. individual stems by species") +
  facet_wrap(~run, ncol=1)+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Individual stems")+  
  theme_bw()


#-------------------------------------------------------------------------------
# PLOT NUMBER OF STEMS GEOM_AREA AT LANDSCAPE LEVEL BY SPECIES

g5 <- ggplot(lnd, aes(x=year, y=count_ha, fill=factor(species, levels=new_order_gg)))+ 
  geom_area(size=1.2)+
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  ggtitle("N. individual stems by species") +
  facet_wrap(~run, ncol=1)+
  labs(x = "Year",y="Individual Stems", fill = "Species")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme_bw()

#-------------------------------------------------------------------------------
# PLOT HEIGHT GEOM_LINE AT LANDSCAPE LEVEL BY SPECIES

# lnd2 <- lnd %>% filter(species %in% species.to.keep)    ---   ADD IF YOU WANT SELECT SPECIES TO KEEP

b5 <- ggplot(data=lnd2, aes(x=year, y=height_avg_m, color=species)) + 
  geom_line(size=1.2)+
  ggtitle("Avarage Height by species") +
  facet_wrap(~run, ncol=1)+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Height [m]")+  
  theme_bw()


#-------------------------------------------------------------------------------
# PLOT TOTAL HEIGHT GEOM_AREA AT LANDSCAPE LEVEL BY SPECIES

g6 <- ggplot(dys, aes(x=year, y=height_mean))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  ggtitle("Total Avarage Height")+
  facet_wrap(~run, ncol=1)+
  labs(x = "Year",y="Height [m]")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme_bw()

# AGE 

g7 <- ggplot(dys, aes(x=year, y=age_mean))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  ggtitle("Avarage Tree Age")+
  facet_wrap(~run, ncol=1)+
  labs(x = "Year",y="Age [years]")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme_bw()


#-------------------------------------------------------------------------------
# Total Carbon in Kg (total_carbon_kg	double	total carbon in living biomass (aboveground compartments and roots) of all living trees (including regeneration layer) (kg/ha))

g8 <- ggplot(lnd, aes(year, total_carbon_kg, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  ggtitle("Total Carbon in Living Biomass")+
  facet_wrap(~run, ncol=1)+
  labs(x = "Year",y="[kg/ha]",fill = "Species")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme_bw()

#-------------------------------------------------------------------------------
# PLOT LAI AT LANDSCAPE LEVEL BY SPECIES

g9 <- ggplot(lnd, aes(year, LAI, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  ggtitle("LAI index by species")+
  facet_wrap(~run, ncol=1)+
  labs(x = "Year",y="LAI index",fill = "Species")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme_bw()


#-------------------------------------------------------------------------------
# PLOT NPP AT LANDSCAPE LEVEL BY SPECIES

g10 <- ggplot(lnd, aes(year, NPP_kg, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  ggtitle("Net Primary Productivity")+
  facet_wrap(~run, ncol=1)+
  labs(x = "Year",y="NPP [kg/ha]",fill = "Species")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme_bw()


#grid.arrange(g1,g2,g3,g4,g5,g6,g7,g8,g9,g10, ncol=10)

#grid.arrange(b1,b2,b3,b4,b5,ncol=5)

grid.arrange(g1,g5,g6, ncol=3)

grid.arrange(g1,g5,g4, ncol=3)

#-------------------------------------------------------------------------------
# PLOT SECOND Y AXIS FOR KILLED VOLUME BY DISTURBANCES IN LANDSCAPE AVG LINE 75

area<-lnd$area[1]
ylim.bb <- c(0, 600000)                                                                                          # in this example, precipitation look the link down
ylim.w <- c(0, 1700000) 

b <- diff(ylim.bb)/diff(ylim.w)
a <- ylim.bb[1] - b*ylim.w[1] 
# TO MAKE 2 LINE AND 2 DIFFERENT SCALE PLOT "https://stackoverflow.com/questions/3099219/ggplot-with-2-y-axes-on-each-side-and-different-scales"
ggplot(damage.all,aes(year,barkbeetle/area))+
  geom_col(fill="pink",col="pink")+
  geom_point(aes(y = a+ wind/area*b), data = damage.all,size=2) +
  scale_y_continuous(name="Barkbeetle damage [m3/ha]", sec.axis = sec_axis(~ (. - a)/b,name = "Wind damage [m3/ha]"))+
  facet_wrap(~case, ncol=1)+
  theme_bw()


(damage.all %>% group_by(case) %>% summarise(mean(barkbeetle/area),mean(na.omit(wind/area))))                    # SUMMARISE THE DAMAGE IMPACT IN NUMERIC VALUES AND IN MEAN FOR BOTH BB AD WIND


#-------------------------------------------------------------------------------
# PLOT SECOND Y AXIS IN RELATIVE KILLED VOLUME BY DISTURBANCES IN LANDSCAPE AVG

ylim.bb <- c(0, 600000)                                                                                                      # In this example, precipitation look the link down
ylim.w <- c(0, 1700000)                                                                                                      # SET THE LIMIT OF THE AXIS IN THIS CASE BASED ON M3

b <- diff(ylim.bb)/diff(ylim.w)                                                                                              # MATHEMATIC FUCTION TO CREATE THE RIGHT SCALE VALUE BASED ON THE DATA YOU HAVE
a <- ylim.bb[1] - b*ylim.w[1] 

# TO MAKE 2 LINE AND 2 DIFFERENT SCALE PLOT "https://stackoverflow.com/questions/3099219/ggplot-with-2-y-axes-on-each-side-and-different-scales"
ggplot(damage.all,aes(year,barkbeetle/area/volume))+                                                                         # THE DATA WE WANT TO PLOT 1' DATASET BARKBEETLE IN THIS CASE
  geom_col(fill="pink",col="pink")+                                             
  geom_point(aes(y = a + wind/area/volume*b), data = damage.all,size=2) +                                                    # SECOND Y AXIS TO PLOT IN THE SAME PLOT WIND RELATIVE DAMAGE IN TERMS OF LANDSCAPE VOLUME. DATA IS WHERE YPU TAKE THE DATA FOR THAT FUNCTION.
  scale_y_continuous(name="Barkbeetle relative damage", sec.axis = sec_axis(~ (. - a)/b,name = "Wind relative damage"))+
  facet_wrap(~case, ncol=1)+
  theme_bw()
# SET THE SCALE OF THE Y AXIS. NAME IS THE NAME OF THE LABEL. FIRST Y AXIS SCALE REFERENCE ONE. SEC_AXIS SET THE SECOND AXIS TILDE ATTACH, (.,A)/B IS THE FORMULA.                                          
rel_damage <- (damage.all %>% group_by(case) %>% summarise((barkbeetle/area/volume),(wind/area/volume)))



########################################################## CLOSE EVERY PLOT


dev.off()

#________________________________________________________________________THE END




#_______________________________________________________________________________

# NEW KILLED VOLUME CALCULATION INCLUDING BARK BEETLE
# Make the disturbance impact:

# Wind AND bark beetle disturbance impact in the landscape volume in percentages
# wind and bark beetle regime

#_______________________________________________________________________________


killed_volume_w  <- sum(w$killedVolume)                   
killed_volume_w 
killed_volume_bb <- sum(bb$killedVolume)                  
killed_volume_bb
killed_volume_dist <- killed_volume_w + killed_volume_bb   
killed_volume_dist
killed_volume_per_year_dist  <- killed_volume_dist/400            
killed_volume_per_year_dist 
killed_volume_per_year_dist_ha <- killed_volume_per_year_dist/17749.26
killed_volume_per_year_dist_ha                                         


# FILTER AND GROUP FOR THE NEEDED COLUMNS AND GROUP BY YEAR TO CREATE NEW DATAFRAMES FOR THE % ANALSIS ON THE KILLED VOLUME PER YEAR

dfnew1  <- lnd[,c(1,8)]

df_vol = dfnew1 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year <- df_vol %>% mutate(perc.vol=100*killed_volume_per_year_dist_ha/tot_vol)
prop_killed_vol_ha_year
summary(prop_killed_vol_ha_year)


hist(prop_killed_vol_ha_year$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind and bark beetles per year in CC",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD")

##______________________________________________________

# New data base

# ADD compone the DATA FRAME
damage<-left_join(damage,wind[,c(1,8)],by=("year"))                           # LEFT_JOIN IS A FUNCTION TO JOIN A VARIABLE IN THIS CASE COLUMN 1 AND 2 AND MANY ROWS BASE ON YEAR VARIABLE NUMBER OF ROWS
damage<-left_join(damage,lnd_volume,by=("year"))                              # ADD THE LANDSCAPE VOLUME IN THE DAMAGE DATA FRAME
colnames(damage)<-c("year","barkbeetle","case","wind","volume")               # GIVE THE NAME AT EVERY VARIABLE
