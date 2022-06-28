# install.packages("RSQLite")
library(RSQLite)
library(dplyr)
library(ggplot2)
library(gridExtra)


#_______________________________________________________________________________
# Path to search the data
dataroot <- ("C:/iLand/2022/20220420/1/")                        # Root for the selection of the data

# CREATE NEW EMPTY DATAFRAME
removals<-c()
lnd<-c()
aUnit<-c()

# NAMES OF THE DATABESES VARIABLES
cases <-c("case1a", "case1b","case2a","case2b","case3a","case3b")

#cases <- c("SW9","SW10","SW11","SW12")

# ALTERNATIE WAY
#fs <- c("aaa","bbb","ccc","ddd")                                      # ALTERNATIVE WAY AAA,BBB,CCC,DDD ARE THE NAMES OF THE DBs
#fs <- c("Cz_region_20220325_BAU_sw_management_brow_0.6")


#_______________________________________________________________________________
# FOR CYCLE FOR THE IMPORT AND ANALYSIS OF THE LANDSCAPE VOLUME AND VOLUME HARVESTED


 for (i in (1:length(cases)))  {                                        # We read in the files in the loop. The "i" is for the x-> 1:i 

                                                                          # "for" = for argument, "(in"= in, "1"= first element of the for cycle to analysis, ": length(cases)))" = throgh the length of the object cases  
# PAY ATTENTION FROM HERE FOR TESTING
  
 # i <- 1                                                                 # to test but remember to don't run also the }
  
  case<-cases[i]                                                      # ORDINATION OF THE CASE TO IMPORT AS DATABASE
  
  
# Name of the database
file <-paste0(dataroot, case, ".sqlite")   # file to read here the case is always the actual case in the loop

                                                                       # "file"= name of the object, "paste0"+ function to create a NAME for a computer path of selection of data/objects

# ALTERNATIVE WAY
#f <-paste0(dataroot,fs,".sqlite")

print(file)

# connect to the database of clearcut model
sqlite.driver <- dbDriver("SQLite")
db1 <- dbConnect(sqlite.driver, dbname = file)  # connect to the file
tables.in.the.file<-dbListTables(db1)           # explore the tables in the file
print(tables.in.the.file)


#-----------------------------------------------
landscape <- dbReadTable(db1,"landscape")
abeUnit <- dbReadTable(db1, "abeUnit")
abeStandRemoval <- dbReadTable(db1,"abeStandRemoval")

#carbon <- dbReadTable(db1,"carbon")
# wind <- dbReadTable(db1,"wind")
#carbonflow <- dbReadTable(db1, "carbonflow")
dbDisconnect(db1)    # close the file

landscape.area<-landscape$area[1]



# Make the 3 categories of removals:

activity.names<-unique(abeStandRemoval$activity)    # here I list all different type of activites

swcuts<- grepl("sw",activity.names)     # I look for only which has "sw" this grepl gives TRUE/FALSE
activity.names.sw<-activity.names[swcuts] # collect the activity names with sw
activity.names.notsw<-activity.names[!swcuts]  # collect the activity names withOUT sw

#print(activity.names.sw)
#print(activity.names.notsw)

# Here I filter only the listed activity names and calculate thinning/finalcut values for every year 
# (each line is per ha for a stand, so I scale with the area, sum up all the harvest on the landscape and then divide it with the whole area to get again per ha)

ab.regcuts<- data.frame(abeStandRemoval %>% filter(activity %in% activity.names.sw)    %>% 
                             group_by(year)   %>%   summarise(volume=sum(volumeThinning*area)/landscape.area, type="regcut", run=case))

ab.finalcuts<- data.frame(abeStandRemoval %>% filter(activity %in% activity.names.sw)    %>% 
                               group_by(year)   %>%   summarise(volume=sum(volumeFinal*area)/landscape.area, type="finalcut", run=case))

ab.thinnig<- data.frame(abeStandRemoval %>% filter(activity %in% activity.names.notsw)    %>% 
                             group_by(year)   %>%   summarise(volume=sum(volumeThinning*area)/landscape.area, type="thinning", run=case))

if (length(activity.names[swcuts])==0) {
  
  ab.finalcuts<- data.frame(abeStandRemoval %>% filter(activity %in% activity.names.notsw)    %>% 
                              group_by(year)   %>%   summarise(volume=sum(volumeFinal*area)/landscape.area, type="finalcut", run=case))
  
}

removals<-rbind(removals,ab.regcuts,ab.finalcuts,ab.thinnig)


# Collect landscape data:
landscape<- (landscape %>% mutate(run=case))
lnd<-rbind(lnd, landscape)

# Collect abeUnit data
abeUnit<-(abeUnit %>% mutate(run=case))
aUnit<-rbind(aUnit, abeUnit)



}  # end of loop


# TO SUMMARIZE THE CUTTING ACTIVITIES
values<-data.frame(removals %>% group_by(run, type) %>% summarise(volume=mean(volume)))
print(values)
values_sum <- values %>%
  filter(run == "case1b", type=="finalcut")

values_sum


# NEED TO OPEN A PDF WRITER AND GIVE IT THE ROOT, THE NAME, AND THE SIZE

pdf(paste0(dataroot, "20220420a.pdf"), height=8, width=12)
#pdf(paste0(dataroot, "20220414b.pdf"), height=5, width=15)
#pdf(paste0(dataroot, "20220414c.pdf"), height=10, width=25)



#_______________________________________________________________________________
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
#_______________________________________________________________________________


# STARTING PLOTS

# column diagram
ggplot(removals, aes(year, volume, fill=factor(type, levels=c( "regcut","finalcut","thinning"))))+
  geom_bar(position="stack", stat="identity")+
  facet_wrap(~run, ncol=1)+
  labs(x = "Year",y="Removed volume m3/ha",fill = "Removal")+
  scale_fill_manual(values=c("#4897D8","#FFDB5C","#FA6E59"))+               #"#B7B8B6","#34675C","#B3C100" grey and greens
  theme_bw()

# Make a plot with ggplot, volume, colored by species for the transitional period for Clear cut management system
#-------------------------------------------------------------------------------

ggplot(lnd, aes(year,volume_m3, fill=factor(species, levels=new_order_gg)))+
  geom_area() +
  scale_fill_manual(values=cols[new_order_gg], guide=guide_legend(reverse=TRUE))+
  ggtitle("Clear Cut")+
  facet_wrap(~run, ncol=1)+
  labs(x = "Year",y="Volume m3/ha",fill = "Species")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylim(0,400)+
  theme_bw()

#-------------------------------------------------------------------------------

ggplot(aUnit, aes(year,realizedHarvest, color=case))+
  geom_line(size=1.2, show.legend = F)+
  facet_wrap(~run, ncol=1)+
  ylim(4.5,15.5)+
  ggtitle("Realized Harvest Transitional Period")+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Realized harvest m3/ha")+
  theme_bw()


#-------------------------------------------------------------------------------

# SPECIES specificaly BA:
species.to.keep<-c("piab", "fasy","qupe", "psme")


lnd2 <- lnd %>% filter(species %in% species.to.keep)

ggplot(data=lnd2, aes(x=year, y=basal_area_m2, color=species)) + 
  geom_line(size=1.2)+
  ggtitle("Clear cut") +
  facet_wrap(~run, ncol=1)+
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area m2/ha")+  theme_bw()


dev.off()

#________________________________________________________________________THE END

Laura Dobor & Marco Baldo
