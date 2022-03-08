# install.packages("RSQLite")
library(RSQLite)



file<-"D:/iLand/TEST3_folder/output/subregion_medium_test1.sqlite"   # file to read


sqlite.driver <- dbDriver("SQLite")
db1 <- dbConnect(sqlite.driver, dbname = file)  # connect to the file
tables.in.the.file<-dbListTables(db1)           # explore the tables in the file
print(tables.in.the.file)


#-----------------------------------------------
# READ IN different tables:    (here can read in by table names.... depending on what you have in your outputfile)

carbon <- dbReadTable(db1,"carbon")
carbonflow <- dbReadTable(db1,"carbonflow")
# wind <- dbReadTable(db1,"wind")
# barkbeetle <- dbReadTable(db1,"barkbeetle")
# lremoved <- dbReadTable(db1,"landscape_removed")
landscape <- dbReadTable(db1,"landscape")
abeStand <- dbReadTable(db1, "abeStand")
stand <- dbReadTable(db1, "stand")
abeStandRemoval <- dbReadTable(db1, "abeStandRemoval")

dbDisconnect(db1)    # close the file

# Make a plot with ggplot, volume, colored by species....

library(ggplot2)
ggplot(carbonflow, aes(year,GPP))+
  geom_area()

ggplot(carbonflow, aes(year,NPP))+
  geom_area()

ggplot(carbonflow, aes(year,NEP))+
  geom_area()

ggplot(carbonflow, aes(year,cumNPP))+
  geom_area()

ggplot(carbonflow, aes(year,cumRh))+
  geom_area()

ggplot(carbonflow, aes(year,cumNEP))+
  geom_area()
# ggplot(abeStand, aes(year,volume, fill=standid))+   
#   geom_line()
