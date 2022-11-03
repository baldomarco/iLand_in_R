# RANDOMIZATION OF THE VARIABLE SELECTION AND TRANSPORTATION INTO A TEXT OR EXCEL FILE

# PAST SCRIPT FROM SLOVAKIA REGION - DR LAURA DOBOR -

# GENERATE WIND EVENTS 
# between 5% and 95% of Gumbel for Ganovce
# TO UNDERSTAND THE SCRIPT YOU NEED AN ILAND WIND TABLE!!

mn<-14.7                                                                         # MINIMAL WIND SPEED IN M/S
mx<-21.1                                                                         # MAXIMAL WIND SPEED

                                                                                 # FOR CYCLE FOR GENERATING 10 TIMES THE SAME PROCEDURE
for (i in 1:10) {
  a<-runif(5,mn,mx)                                                              # runif function generate random values in an array look at for examples -> https://www.statology.org/runif-in-r/                            
                                                                                 # https://www.statology.org/runif-in-r/
print(round(a[order(a)],2))                                                      # order a array in ascending order till 2 decimal digits 
print(summary(a))                                                                # print statistical summary and mean
print(mean(a))  
}

w1<-c(15.25, 15.27, 16.60, 18.22, 18.42)                                         # creation of vectors from the upper run wind speed randomization and ordination
w2<-c(15.15, 16.36, 16.80, 19.39, 19.62)
w3<-c(14.85, 15.12, 15.40, 17.30, 19.10)
w4<-c(15.43, 16.53, 16.70, 16.96, 17.84)
w5<-c(14.72, 14.77, 15.60, 19.46, 19.97)

wd<-c(251,245,248,64,257)                                                        # create an array with winds direction in angles
doy<-c(50,15,230,83,354)                                                         # create an array with day of the year

set.panel()                                                                      # needs library "fields"
plot(w1, ylim=c(14.7,21.1), pch=19, cex=2)                                       # plotting the wind sequence
points(w2, pch=19, col="red", cex=2)
points(w3, pch=19, col="orange", cex=2)
points(w4, pch=19, col="green", cex=2)
points(w5, pch=19, col="blue", cex=2)

mean(w1)
mean(w2)
mean(w3)
mean(w4)
mean(w5)


#-------------------------------------------------------------------------------------------------------
# MODIFY TIME EVENT FIRST

dataroot<-"D:/___PRAGA/wind/testing_few_wind_events_for_azure/Rotation/"                                 # ROOT OF THE DATA IN OUR ENVIRONMENT I.G. HARD DISK

# Generate events: between 5% and 95% of Gumbel for Ganovce
mn<-14.7
mx<-21.1

for (i in 1:10) {
  a<-runif(6,mn,mx)
  print('------------------')
  print(round(a[order(a)],2))
  print(summary(a))
  print(mean(a))  
}

lighter<-c(16.26, 18.53,15.74,16.83,  15.09,16.44)                                                       # CREATE AN ARRAY OF WIND SPEED

winds<-c("w1","w2")                                                                                      # WE HAVE 2 WIND REGIME OR SEQUENCE                                  
scens<-c("refclim", "RCP45","RCP85")                                                                     # WE HAVE 3 CLIMATE SCENARIOS
                                                                                                         # HERE WE ARE CREATING A LOOP TO GENERATE 3X2 = 6 WIND TABLES
for (j in 1:3) {

for (i in 1:2)   {

    
a<-read.table(paste0(dataroot,winds[i],"_", scens[j],".txt"), header=T)                                  # READ A WIND TABLE ALREADY DONE. THIS IS A TXT FILE

                                                                                                         # FROM THE ORIGINAL CHANGE THE VARIABLES INSEDE
a$modules.wind.dayOfYear<-1                                                                              # DAY 1 FOR ALL THE YEARS AND SPEED 0 M/S - DIRECTION 0 ANGLE - DURATION 0 MIN
a$modules.wind.speed<-0
a$modules.wind.direction<-0
a$modules.wind.duration<-0
if (scens[j]=="refclim") a$model.climate.co2concentration<-380                                           # REPLACE IN THE TABLE COLUMN model.climate.co2concentration WITH VALUE 380 ppm # if ARGOMENT NEEDS TO SPECIFY A CASE E.G. DO THE LINE IF YOU ARE IN REFERENCE CLIMATE (refclim)

events<-which(a$year==20|a$year==50|a$year==80|a$year==110|a$year==140|a$year==170)                      # CREATE WITH THE which FUNCTION THE YEAR TO BE SELECTED AS EVENT IN WHICH IS HAPPENING THE WIND STORM

events


a$modules.wind.speed[events]<-lighter                                                                    # PUT THE ARRAY OF THE lighter VECTOR IN THE YEAR ROWS OF THE EVENT SELECTION. THIS CHANGE FROM 0 TO THE WIND SPEED GENERATED RANDOMLY IN THE RANDOM YEAR SELECTED


a$modules.wind.direction[events]<-c(64,245,248,64,245,248)                                               # WIND DIRECTION
if (winds[i]=="w1") a$modules.wind.duration[events]<-c(90,90,90,90,90,90)                                # ARRAY FOR THE EVENTS WIND DURATION NB HERE WE HAVE 2 CASES w1, w2. THEY DIFFER FROM THE DURATIION 60 OR 90 MIN
if (winds[i]=="w2") a$modules.wind.duration[events]<-c(60,60,60,60,60,60)
a$modules.wind.dayOfYear[events]<-c(83,15,230,83,15,230)                                                 # DAY OF THE YEAR




write.table(a,paste0(dataroot,winds[i],"_",scens[j],"_upto2200.txt"), col.names = T, quote=F,row.names=F, sep=" ")     # WRITE A TABLE WITH THE a DATAFRAME GENERATED TILL NOW, GIVING THE NAME wind i (w1,w2), _ , and scenarion, scen j, and upto2200, format tex.

                                                                                                                       # DO IT IN LOOP
}

}

# the sample can be used to select the years randomly, just set "replace=F"  not to have more events in the same year
# the sample function is good for the time randomization (give to us random numbers in a range together only integers)
x <- sample(1:10, 5, replace=T)
x


# this gives 10 numbers in the range of 5->7.5   but not only integers
# the runif function is good for wind speed randomization (give to us random numbers in a range together with not integers)
x2 <- runif(10, 5.0, 7.5)
x2
