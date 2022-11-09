#-------------------------------------------WIND TABLE AUTOMATISED CREATION IN R FOR ILAND WIND EVENT AND DISTURBANCE WIND MODULE-------------------------------#

dataroot<-"C:/iLand/wind/random_wind_event_new_script/"

a<-read.table(paste0(dataroot,"wind10.txt"), header=T)

a

a$modules.wind.dayOfYear<-1
a$modules.wind.speed<-0
a$modules.wind.direction<-0
a$modules.wind.duration<-0
a$model.climate.co2concentration<-367

a

# Put set seed function to create consistent time series every time # in this script we did not need this because we are creating random series
year <- sample(1:300, 70, replace=F)

year <- sort(year, decreasing=FALSE)

# this is the serie appearing for the simulation in Forest Recovery after disturbances experimental design
events<-which(a$year==4|a$year==6|a$year==9|a$year==10|a$year==13|a$year==16|a$year==17|a$year==19|a$year==25|a$year==34|a$year==35|a$year==40|a$year==46|a$year==47|a$year==62|a$year==65|a$year==66|a$year==69|a$year==77|a$year==78|a$year==83|a$year==89|a$year==90|a$year==97|a$year==99|a$year==100|a$year==102|a$year==115|a$year==120|a$year==123|a$year==124|a$year==128|a$year==133|a$year==136|a$year==137|a$year==152|a$year==154|a$year==162|a$year==169|a$year==172|a$year==178|a$year==180|a$year==188|a$year==189|a$year==190|a$year==192|a$year==199|a$year==200|a$year==204|a$year==208|a$year==214|a$year==217|a$year==218|a$year==225|a$year==232|a$year==247|a$year==248|a$year==249|a$year==257|a$year==261|a$year==264|a$year==266|a$year==270|a$year==273|a$year==276|a$year==278|a$year==284|a$year==285|a$year==291|a$year==298)


events


a$modules.wind.speed[events]<- round(runif(70, 5.0, 7.5), 1)   # change the row argument of the event in this case speed
a$modules.wind.direction[events]<-round(runif(70, 1, 360), 0)  # wind direction random # change the row of direction
a$modules.wind.duration[events]<- round(runif(70, 30, 90), 0)  # 90 min you can put the function runif(70, 30, 90) # 60 min always - you can use "rep" function - rep(60, 70) 
a$modules.wind.dayOfYear[events]<-round(runif(70, 1, 365), 0)  # day of the year random

write.table(a,paste0(dataroot,"wind.txt"), col.names = T, quote=F, row.names=F, sep=" ")


# the sample can be used to select the years randomly, just set "replace=F"  not to have more events in the same year
# the sample function is good for the time randomization (give to us random numbers in a range together only integers)
x <- sample(1:300, 5, replace=F)
x


# this gives 10 numbers in the range of 5->7.5   but not only integers
# the runif function is good for wind speed randomization (give to us random numbers in a specific range)
# for examples -> https://www.statology.org/runif-in-r/

x2 <- round(runif(100, 5.0, 7.5), 1) # one number after the comma
x2

write.table(x2,paste0(dataroot,".txt"), col.names = T, quote=F, row.names=F, sep=" ")


# better
set.seed(5) # to make it reproducible

x2 <- round(runif(100, 5.0, 7.5), 1)
x2

write.table(x2,paste0(dataroot,"run1.txt"), col.names = T, quote=F, row.names=F, sep=" ")


