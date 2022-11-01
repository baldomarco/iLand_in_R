# RANDOMIZATION OF THE VARIABLE SELECTION AND TRANSPORTATION INTO A EXCEL FILE


# GENERATE WIND EVENTS
# between 5% and 95% of Gumbel for Ganovce

#14.7

mn<-14.7
mx<-21.1

for (i in 1:10) {
  a<-runif(5,mn,mx)

print(round(a[order(a)],2))
print(summary(a))
print(mean(a))  
}

w1<-c(15.25, 15.27, 16.60, 18.22, 18.42)
w2<-c(15.15, 16.36, 16.80, 19.39, 19.62)
w3<-c(14.85, 15.12, 15.40, 17.30, 19.10)
w4<-c(15.43, 16.53, 16.70, 16.96, 17.84)
w5<-c(14.72, 14.77, 15.60, 19.46, 19.97)

wd<-c(251,245,248,64,257)
doy<-c(50,15,230,83,354)

set.panel()
plot(w1, ylim=c(14.7,21.1), pch=19, cex=2)
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

dataroot<-"D:/___PRAGA/wind/testing_few_wind_events_for_azure/Rotation/"

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

lighter<-c(16.26, 18.53,15.74,16.83,  15.09,16.44)

winds<-c("w1","w2")
scens<-c("refclim", "RCP45","RCP85")

for (j in 1:3) {

for (i in 1:2)   {

    
a<-read.table(paste0(dataroot,winds[i],"_", scens[j],".txt"), header=T)


a$modules.wind.dayOfYear<-1
a$modules.wind.speed<-0
a$modules.wind.direction<-0
a$modules.wind.duration<-0
if (scens[j]=="refclim") a$model.climate.co2concentration<-380

events<-which(a$year==20|a$year==50|a$year==80|a$year==110|a$year==140|a$year==170)

events


a$modules.wind.speed[events]<-lighter


a$modules.wind.direction[events]<-c(64,245,248,64,245,248)
if (winds[i]=="w1") a$modules.wind.duration[events]<-c(90,90,90,90,90,90)
if (winds[i]=="w2") a$modules.wind.duration[events]<-c(60,60,60,60,60,60)
a$modules.wind.dayOfYear[events]<-c(83,15,230,83,15,230)




write.table(a,paste0(dataroot,winds[i],"_",scens[j],"_upto2200.txt"), col.names = T, quote=F,row.names=F, sep=" ")


}

}
