#_____________________________________________________________________________________________________
# Wind disturbance impact in the landscape volume in percentages
# BROWSING PRESSURE 0

killed_volume_cc_brow0 <- sum(wind_cc_brow0$killedVolume)                         # 1601620 m3
killed_volume_cc_brow0
killed_volume_per_year_cc_brow0 <- killed_volume_cc_brow0/400            # 4014.085
killed_volume_per_year_cc_brow0
killed_volume_per_year_cc_ha_brow0 <- killed_volume_per_year_cc_brow0/abeUnit_cc_brow0$area
killed_volume_per_year_cc_ha_brow0                                       # 0.226155 m3

#_____________________________________________

killed_volume_sw_brow0 <- sum(wind_sw_brow0$killedVolume)                # 1362593 m3
killed_volume_sw_brow0
killed_volume_per_year_sw_brow0 <- killed_volume_sw_brow0/400            # 3415.021
killed_volume_per_year_sw_brow0
killed_volume_per_year_sw_ha_brow0 <- killed_volume_per_year_sw_brow0/abeUnit_cc_brow0$area
killed_volume_per_year_sw_ha_brow0                                       # 0.1924036 m3                        


dfnew1_cc_brow0 <- landscape_cc_brow0[,c(1,8)]

df_vol_cc_brow0 = dfnew1_cc_brow0 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')

dfnew1_sw_brow0 <- landscape_sw_brow0[,c(1,8)]

df_vol_sw_brow0 = dfnew1_sw_brow0 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year_cc_brow0 <- df_vol_cc_brow0 %>% mutate(perc.vol= 100 * killed_volume_per_year_cc_ha_brow0/tot_vol)

prop_killed_vol_ha_year_sw_brow0 <- df_vol_sw_brow0 %>% mutate(perc.vol=100*killed_volume_per_year_sw_ha_brow0/tot_vol)

par(mfrow = c(1,2))

hist(prop_killed_vol_ha_year_cc_brow0$perc.vol, main = "Landscape proportion of killed volume (m3/ha) by wind per year in CC brow 0",cex.main = 1.5, xlab = "Killed volume / Total volume (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,140))

legend("topright", c(" m3"), cex = 0.9, title = "Average killed volume (m3/ha) per year", text.font = 3, bg='lightpink')

# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(prop_killed_vol_ha_year_sw_brow0$perc.vol, main = "Landscape proportion of killed volume (m3/ha) by wind per year in SW brow 0",cex.main = 1.5, xlab = "Killed volume / Total volume (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,140))

legend("topright", c(" m3"), cex = 0.9, title = "Average killed volume (m3/ha) per year", text.font = 3, bg='lightpink')

#____________________________________________________________________________________________________________________________________
#_________________________________________________________________________________________________________________
#   NEW KILLED VOLUME CALCULATION INCLUDING BARK BEETLE


# Wind AND bark beetle disturbance impact in the landscape volume in percentages
# wind and bark beetle regime

killed_volume_cc_brow0 <- sum(wind_cc_brow0$killedVolume)                     # 5929296 m3
killed_volume_cc_brow0
killed_volume_cc_bb_brow0 <- sum(barkbeetle_cc_brow0$killedVolume)            # 4706904
killed_volume_cc_bb_brow0
killed_volume_cc_dist_brow0 <- killed_volume_cc_brow0 + killed_volume_cc_bb_brow0   # 10636200
killed_volume_cc_dist_brow0
killed_volume_per_year_cc_brow0 <- killed_volume_cc_dist_brow0/400            # 26590.5 
killed_volume_per_year_cc_brow0
killed_volume_per_year_cc_ha_brow0 <- killed_volume_per_year_cc_brow0/abeUnit_cc_brow0$area
killed_volume_per_year_cc_ha_brow0                                            # 1.498119 m3   # 1.747298

#_____________________________________________

killed_volume_sw_brow0 <- sum(wind_sw_brow0$killedVolume)                     # 5407252 m3
killed_volume_sw_brow0
killed_volume_sw_bb_brow0 <- sum(barkbeetle_sw_brow0$killedVolume)            # 4388046
killed_volume_sw_bb_brow0
killed_volume_sw_dist_brow0 <- killed_volume_sw_brow0 + killed_volume_sw_bb_brow0  # 9795297
killed_volume_sw_dist_brow0
killed_volume_per_year_sw_brow0 <- killed_volume_sw_dist_brow0/400            # 24488.24
killed_volume_per_year_sw_brow0
killed_volume_per_year_sw_ha_brow0 <- killed_volume_per_year_sw_brow0/abeUnit_cc_brow0$area
killed_volume_per_year_sw_ha_brow0                                            # 1.379677 m3                       


# FILTER AND GROUP FOR THE NEEDED COLUMNS AND GROUP BY YEAR TO CREATE NEW DATAFRAMES FOR THE % ANALSIS ON THE KILLED VOLUME PER YEAR

dfnew1_cc_brow0 <- landscape_cc_brow0[,c(1,8)]

df_vol_cc_brow0 = dfnew1_cc_brow0 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')

dfnew1_sw_brow0 <- landscape_sw_brow0[,c(1,8)]

df_vol_sw_brow0 = dfnew1_sw_brow0 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year_cc_brow0 <- df_vol_cc_brow0 %>% mutate(perc.vol=100*killed_volume_per_year_cc_ha_brow0/tot_vol)
prop_killed_vol_ha_year_cc_brow0
summary(prop_killed_vol_ha_year_cc_brow0)

prop_killed_vol_ha_year_sw_brow0 <- df_vol_sw_brow0 %>% mutate(perc.vol=100*killed_volume_per_year_sw_ha_brow0/tot_vol)
prop_killed_vol_ha_year_sw_brow0
summary(prop_killed_vol_ha_year_sw_brow0)

par(mfrow = c(1,2))

hist(prop_killed_vol_ha_year_cc_brow0$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind and bark beetles per year in CC brow 0",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD", ylim = c(0,90))

legend("topright", c("m3 / %"), cex = 0.55, title = "Average killed volume [m3/ha/year] / avarage % on total volume", text.font = 3, bg='lightpink')

# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(prop_killed_vol_ha_year_sw_brow0$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind and bark beetles per year in SW brow 0",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD", ylim = c(0,90))

legend("topright", c("m3 /  %"), cex = 0.55, title = "Average killed volume [m3/ha/year] / avarage % on total volume", text.font = 3, bg='lightpink')


### year by year relative proportion ##

# FILTER AND GROUP FOR THE NEEDED COLUMNS AND GROUP BY YEAR TO CREATE NEW DATAFRAMES FOR THE % ANALSIS ON THE KILLED VOLUME PER YEAR

bb_killvol_ha_cc_brow0 <- barkbeetle_cc_brow0$killedVolume/abeUnit_cc_brow0$area
bb_killvol_ha_sw_brow0 <- barkbeetle_sw_brow0$killedVolume/abeUnit_sw_brow0$area

# Add a column of variables in this case volume killed in % of the total ha avg
dist_per_cc_brow0 <- abeUnit_cc_brow0 %>% mutate(perc.vol=100*bb_killvol_ha_cc_brow0/abeUnit_cc_brow0$volume)
summary(dist_per_cc_brow0)

dist_per_sw_brow0 <- abeUnit_sw_brow0 %>% mutate(perc.vol=100*bb_killvol_ha_sw_brow0/abeUnit_sw_brow0$volume)
summary(dist_per_sw_brow0)

par(mfrow = c(1,2))  # 763 m3 of difference in CC than in SW

# natural logarithm is based on the "Euler's number" = e ??? 2,71828183

hist(log(dist_per_cc_brow0$perc.vol), main = "Landscape proportion of killed volume [m3/ha] by bark beetles per year in CC brow 0",cex.main = 1, xlab = " [Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD",xlim = c(-15,3), ylim = c(0,90))

legend("topright", c(" m3 /  %"), cex = 0.55, title = "Average percentage of killed volume [m3/ha/year] by bark beetle", text.font = 3, bg='lightpink')
# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(log(dist_per_sw_brow0$perc.vol), main = "Landscape proportion of killed volume [m3/ha] by bark beetles per year in SW brow 0",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD",xlim = c(-15,3), ylim = c(0,90))

legend("topright", c(" m3 /  %"), cex = 0.55, title = "Average percentage of killed volume [m3/ha/year] by bark beetle", text.font = 3, bg='lightpink')

#_________________________________________________________________________________________________
#_________________________________________________________________________________________________
# Wind disturbance impact in the landscape volume in percentages
# BROWSING PRESSURE 0.3

killed_volume_cc_brow0.3 <- sum(wind_cc_brow0.3$killedVolume)                # 1601620 m3
killed_volume_cc_brow0.3
killed_volume_per_year_cc_brow0.3 <- killed_volume_cc_brow0.3/400            # 4014.085
killed_volume_per_year_cc_brow0.3
killed_volume_per_year_cc_ha_brow0.3 <- killed_volume_per_year_cc_brow0.3/17749.26
killed_volume_per_year_cc_ha_brow0.3                                 # 0.226155 m3

#_____________________________________________

killed_volume_sw_brow0.3 <- sum(wind_sw_brow0.3$killedVolume)                # 1362593 m3
killed_volume_sw_brow0.3
killed_volume_per_year_sw_brow0.3 <- killed_volume_sw_brow0.3/400            # 3415.021
killed_volume_per_year_sw_brow0.3
killed_volume_per_year_sw_ha_brow0.3 <- killed_volume_per_year_sw_brow0.3/17749.26
killed_volume_per_year_sw_ha_brow0.3                                 # 0.1924036 m3                        


dfnew1_cc_brow0.3 <- landscape_cc_brow0.3[,c(1,8)]

df_vol_cc_brow0.3 = dfnew1_cc_brow0.3 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')

dfnew1_sw_brow0.3 <- landscape_sw_brow0.3[,c(1,8)]

df_vol_sw_brow0.3 = dfnew1_sw_brow0.3 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year_cc_brow0.3 <- df_vol_cc_brow0.3 %>% mutate(perc.vol=100*killed_volume_per_year_cc_ha_brow0.3/tot_vol)

prop_killed_vol_ha_year_sw_brow0.3 <- df_vol_sw_brow0.3 %>% mutate(perc.vol=100*killed_volume_per_year_sw_ha_brow0.3/tot_vol)

par(mfrow = c(1,2))

hist(prop_killed_vol_ha_year_cc_brow0.3$perc.vol, main = "Landscape proportion of killed volume (m3/ha) by wind per year in CC brow 0.3",cex.main = 1.5, xlab = "Killed volume / Total volume (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,140))

legend("topright", c(" m3"), cex = 0.9, title = "Average killed volume (m3/ha) per year", text.font = 3, bg='lightpink')

# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(prop_killed_vol_ha_year_sw_brow0.3$perc.vol, main = "Landscape proportion of killed volume (m3/ha) by wind per year in SW brow 0.3",cex.main = 1.5, xlab = "Killed volume / Total volume (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,140))

legend("topright", c(" m3"), cex = 0.9, title = "Average killed volume (m3/ha) per year", text.font = 3, bg='lightpink')

#____________________________________________________________________________________________________________________________________
#_________________________________________________________________________________________________________________
#   NEW KILLED VOLUME CALCULATION INCLUDING BARK BEETLE


# Wind AND bark beetle disturbance impact in the landscape volume in percentages
# wind and bark beetle regime

killed_volume_cc_brow0.3 <- sum(wind_cc_brow0.3$killedVolume)                   # 5929296 m3
killed_volume_cc_brow0.3
killed_volume_cc_bb_brow0.3 <- sum(barkbeetle_cc_brow0.3$killedVolume)            # 4706904
killed_volume_cc_bb_brow0.3
killed_volume_cc_dist_brow0.3 <- killed_volume_cc_brow0.3 + killed_volume_cc_bb_brow0.3   # 10636200
killed_volume_cc_dist_brow0.3
killed_volume_per_year_cc_brow0.3 <- killed_volume_cc_dist_brow0.3/400            # 26590.5 
killed_volume_per_year_cc_brow0.3
killed_volume_per_year_cc_ha_brow0.3 <- killed_volume_per_year_cc_brow0.3/17749.26
killed_volume_per_year_cc_ha_brow0.3                                         # 1.498119 m3   # 1.747298

#_____________________________________________

killed_volume_sw_brow0.3 <- sum(wind_sw_brow0.3$killedVolume)                   # 5407252 m3
killed_volume_sw_brow0.3
killed_volume_sw_bb_brow0.3 <- sum(barkbeetle_sw_brow0.3$killedVolume)            # 4388046
killed_volume_sw_bb_brow0.3
killed_volume_sw_dist_brow0.3 <- killed_volume_sw_brow0.3 + killed_volume_sw_bb_brow0.3  # 9795297
killed_volume_sw_dist_brow0.3
killed_volume_per_year_sw_brow0.3 <- killed_volume_sw_dist_brow0.3/400            # 24488.24
killed_volume_per_year_sw_brow0.3
killed_volume_per_year_sw_ha_brow0.3 <- killed_volume_per_year_sw_brow0.3/17749.26
killed_volume_per_year_sw_ha_brow0.3                                         # 1.379677 m3                       


# FILTER AND GROUP FOR THE NEEDED COLUMNS AND GROUP BY YEAR TO CREATE NEW DATAFRAMES FOR THE % ANALSIS ON THE KILLED VOLUME PER YEAR

dfnew1_cc_brow0.3 <- landscape_cc_brow0.3[,c(1,8)]

df_vol_cc_brow0.3 = dfnew1_cc_brow0.3 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')

dfnew1_sw_brow0.3 <- landscape_sw_brow0.3[,c(1,8)]

df_vol_sw_brow0.3 = dfnew1_sw_brow0.3 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year_cc_brow0.3 <- df_vol_cc_brow0.3 %>% mutate(perc.vol=100*killed_volume_per_year_cc_ha_brow0.3/tot_vol)
prop_killed_vol_ha_year_cc_brow0.3
summary(prop_killed_vol_ha_year_cc_brow0.3)

prop_killed_vol_ha_year_sw_brow0.3 <- df_vol_sw_brow0.3 %>% mutate(perc.vol=100*killed_volume_per_year_sw_ha_brow0.3/tot_vol)
prop_killed_vol_ha_year_sw_brow0.3
summary(prop_killed_vol_ha_year_sw_brow0.3)

par(mfrow = c(1,2))

hist(prop_killed_vol_ha_year_cc_brow0.3$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind and bark beetles per year in CC brow 0.3",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD", ylim = c(0,90))

legend("topright", c(" m3 / %"), cex = 0.55, title = "Average killed volume [m3/ha/year] / avarage % on total volume", text.font = 3, bg='lightpink')

# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(prop_killed_vol_ha_year_sw_brow0.3$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind and bark beetles per year in SW brow 0.3",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD", ylim = c(0,90))

legend("topright", c(" m3 / %"), cex = 0.55, title = "Average killed volume [m3/ha/year] / avarage % on total volume", text.font = 3, bg='lightpink')


### year by year relative proportion ##

# FILTER AND GROUP FOR THE NEEDED COLUMNS AND GROUP BY YEAR TO CREATE NEW DATAFRAMES FOR THE % ANALSIS ON THE KILLED VOLUME PER YEAR

bb_killvol_ha_cc_brow0.3 <- barkbeetle_cc_brow0.3$killedVolume/abeUnit_cc_brow0.3$area
bb_killvol_ha_sw_brow0.3 <- barkbeetle_sw_brow0.3$killedVolume/abeUnit_sw_brow0.3$area

# Add a column of variables in this case volume killed in % of the total ha avg
dist_per_cc_brow0.3 <- abeUnit_cc_brow0.3 %>% mutate(perc.vol=100*bb_killvol_ha_cc_brow0.3/abeUnit_cc_brow0.3$volume)
summary(dist_per_cc_brow0.3)

dist_per_sw_brow0.3 <- abeUnit_sw_brow0.3 %>% mutate(perc.vol=100*bb_killvol_ha_sw_brow0.3/abeUnit_sw_brow0.3$volume)
summary(dist_per_sw_brow0.3)

par(mfrow = c(1,2))  # 763 m3 of difference in CC than in SW

# natural logarithm is based on the "Euler's number" = e ??? 2,71828183

hist(log(dist_per_cc_brow0.3$perc.vol), main = "Landscape proportion of killed volume [m3/ha] by bark beetles per year in CC brow 0.3",cex.main = 1, xlab = " [Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD",xlim = c(-15,3), ylim = c(0,90))

legend("topright", c(" m3 /  %"), cex = 0.55, title = "Average percentage of killed volume [m3/ha/year] by bark beetle", text.font = 3, bg='lightpink')
# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(log(dist_per_sw_brow0.3$perc.vol), main = "Landscape proportion of killed volume [m3/ha] by bark beetles per year in SW brow 0.3",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD",xlim = c(-15,3), ylim = c(0,90))

legend("topright", c(" m3 /  %"), cex = 0.55, title = "Average percentage of killed volume [m3/ha/year] by bark beetle", text.font = 3, bg='lightpink')


#_________________________________________________________________________________________________
#_________________________________________________________________________________________________
# Wind disturbance impact in the landscape volume in percentages
# BROWSING PRESSURE 0.8

killed_volume_cc_brow0.8 <- sum(wind_cc_brow0.8$killedVolume)                # 1601620 m3
killed_volume_cc_brow0.8
killed_volume_per_year_cc_brow0.8 <- killed_volume_cc_brow0.8/400            # 4014.085
killed_volume_per_year_cc_brow0.8
killed_volume_per_year_cc_ha_brow0.8 <- killed_volume_per_year_cc_brow0.8/17749.26
killed_volume_per_year_cc_ha_brow0.8                                 # 0.226155 m3

#_____________________________________________

killed_volume_sw_brow0.8 <- sum(wind_sw_brow0.8$killedVolume)                # 1362593 m3
killed_volume_sw_brow0.8
killed_volume_per_year_sw_brow0.8 <- killed_volume_sw_brow0.8/400            # 3415.021
killed_volume_per_year_sw_brow0.8
killed_volume_per_year_sw_ha_brow0.8 <- killed_volume_per_year_sw_brow0.8/17749.26
killed_volume_per_year_sw_ha_brow0.8                                 # 0.1924036 m3                        


dfnew1_cc_brow0.8 <- landscape_cc_brow0.8[,c(1,8)]

df_vol_cc_brow0.8 = dfnew1_cc_brow0.8 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')

dfnew1_sw_brow0.8 <- landscape_sw_brow0.8[,c(1,8)]

df_vol_sw_brow0.8 = dfnew1_sw_brow0.8 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year_cc_brow0.8 <- df_vol_cc_brow0.8 %>% mutate(perc.vol=100*killed_volume_per_year_cc_ha_brow0.8/tot_vol)

prop_killed_vol_ha_year_sw_brow0.8 <- df_vol_sw_brow0.8 %>% mutate(perc.vol=100*killed_volume_per_year_sw_ha_brow0.8/tot_vol)

par(mfrow = c(1,2))

hist(prop_killed_vol_ha_year_cc_brow0.8$perc.vol, main = "Landscape proportion of killed volume (m3/ha) by wind per year in CC brow 0.8",cex.main = 1.5, xlab = "Killed volume / Total volume (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,140))

legend("topright", c(" m3"), cex = 0.9, title = "Average killed volume (m3/ha) per year", text.font = 3, bg='lightpink')

# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(prop_killed_vol_ha_year_sw_brow0.8$perc.vol, main = "Landscape proportion of killed volume (m3/ha) by wind per year in SW brow 0.8",cex.main = 1.5, xlab = "Killed volume / Total volume (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,140))

legend("topright", c(" m3"), cex = 0.9, title = "Average killed volume (m3/ha) per year", text.font = 3, bg='lightpink')

#____________________________________________________________________________________________________________________________________
#_________________________________________________________________________________________________________________
#   NEW KILLED VOLUME CALCULATION INCLUDING BARK BEETLE


# Wind AND bark beetle disturbance impact in the landscape volume in percentages
# wind and bark beetle regime

killed_volume_cc_brow0.8 <- sum(wind_cc_brow0.8$killedVolume)                   # 5929296 m3
killed_volume_cc_brow0.8
killed_volume_cc_bb_brow0.8 <- sum(barkbeetle_cc_brow0.8$killedVolume)            # 4706904
killed_volume_cc_bb_brow0.8
killed_volume_cc_dist_brow0.8 <- killed_volume_cc_brow0.8 + killed_volume_cc_bb_brow0.8   # 10636200
killed_volume_cc_dist_brow0.8
killed_volume_per_year_cc_brow0.8 <- killed_volume_cc_dist_brow0.8/400            # 26590.5 
killed_volume_per_year_cc_brow0.8
killed_volume_per_year_cc_ha_brow0.8 <- killed_volume_per_year_cc_brow0.8/17749.26
killed_volume_per_year_cc_ha_brow0.8                                            # 1.498119 m3   # 1.747298

#_____________________________________________

killed_volume_sw_brow0.8 <- sum(wind_sw_brow0.8$killedVolume)                   # 5407252 m3
killed_volume_sw_brow0.8
killed_volume_sw_bb_brow0.8 <- sum(barkbeetle_sw_brow0.8$killedVolume)            # 4388046
killed_volume_sw_bb_brow0.8
killed_volume_sw_dist_brow0.8 <- killed_volume_sw_brow0.8 + killed_volume_sw_bb_brow0.8  # 9795297
killed_volume_sw_dist_brow0.8
killed_volume_per_year_sw_brow0.8 <- killed_volume_sw_dist_brow0.8/400            # 24488.24
killed_volume_per_year_sw_brow0.8
killed_volume_per_year_sw_ha_brow0.8 <- killed_volume_per_year_sw_brow0.8/17749.26
killed_volume_per_year_sw_ha_brow0.8                                            # 1.379677 m3                       


# FILTER AND GROUP FOR THE NEEDED COLUMNS AND GROUP BY YEAR TO CREATE NEW DATAFRAMES FOR THE % ANALSIS ON THE KILLED VOLUME PER YEAR

dfnew1_cc_brow0.8 <- landscape_cc_brow0.8[,c(1,8)]

df_vol_cc_brow0.8 = dfnew1_cc_brow0.8 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')

dfnew1_sw_brow0.8 <- landscape_sw_brow0.8[,c(1,8)]

df_vol_sw_brow0.8 = dfnew1_sw_brow0.8 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year_cc_brow0.8 <- df_vol_cc_brow0.8 %>% mutate(perc.vol=100*killed_volume_per_year_cc_ha_brow0.8/tot_vol)
prop_killed_vol_ha_year_cc_brow0.8
summary(prop_killed_vol_ha_year_cc_brow0.8)

prop_killed_vol_ha_year_sw_brow0.8 <- df_vol_sw_brow0.8 %>% mutate(perc.vol=100*killed_volume_per_year_sw_ha_brow0.8/tot_vol)
prop_killed_vol_ha_year_sw_brow0.8
summary(prop_killed_vol_ha_year_sw_brow0.8)

par(mfrow = c(1,2))

hist(prop_killed_vol_ha_year_cc_brow0.8$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind and bark beetles per year in CC brow 0.8",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD", ylim = c(0,90))

legend("topright", c(" m3 /  %"), cex = 0.55, title = "Average killed volume [m3/ha/year] / avarage % on total volume", text.font = 3, bg='lightpink')

# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(prop_killed_vol_ha_year_sw_brow0.8$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind and bark beetles per year in SW brow 0.8",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD", ylim = c(0,90))

legend("topright", c(" m3 /  %"), cex = 0.55, title = "Average killed volume [m3/ha/year] / avarage % on total volume", text.font = 3, bg='lightpink')


### year by year relative proportion ##

# FILTER AND GROUP FOR THE NEEDED COLUMNS AND GROUP BY YEAR TO CREATE NEW DATAFRAMES FOR THE % ANALSIS ON THE KILLED VOLUME PER YEAR

bb_killvol_ha_cc_brow0.8 <- barkbeetle_cc_brow0.8$killedVolume/abeUnit_cc_brow0.8$area
bb_killvol_ha_sw_brow0.8 <- barkbeetle_sw_brow0.8$killedVolume/abeUnit_sw_brow0.8$area

# Add a column of variables in this case volume killed in % of the total ha avg
dist_per_cc_brow0.8 <- abeUnit_cc_brow0.8 %>% mutate(perc.vol=100*bb_killvol_ha_cc_brow0.8/abeUnit_cc_brow0.8$volume)
summary(dist_per_cc_brow0.8)

dist_per_sw_brow0.8 <- abeUnit_sw_brow0.8 %>% mutate(perc.vol=100*bb_killvol_ha_sw_brow0.8/abeUnit_sw_brow0.8$volume)
summary(dist_per_sw_brow0.8)

par(mfrow = c(1,2))  # 763 m3 of difference in CC than in SW

# natural logarithm is based on the "Euler's number" = e ??? 2,71828183

hist(log(dist_per_cc_brow0.8$perc.vol), main = "Landscape proportion of killed volume [m3/ha] by bark beetles per year in CC bro 0.8",cex.main = 1, xlab = " [Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD",xlim = c(-15,3), ylim = c(0,90))

legend("topright", c(" m3 /  %"), cex = 0.55, title = "Average percentage of killed volume [m3/ha/year] by bark beetle", text.font = 3, bg='lightpink')
# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(log(dist_per_sw_brow0.8$perc.vol), main = "Landscape proportion of killed volume [m3/ha] by bark beetles per year in SW brow 0.8",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD",xlim = c(-15,3), ylim = c(0,90))

legend("topright", c(" m3 /  %"), cex = 0.55, title = "Average percentage of killed volume [m3/ha/year] by bark beetle", text.font = 3, bg='lightpink')


#_________________________________________________________________________________________________
#_________________________________________________________________________________________________
# Wind disturbance impact in the landscape volume in percentages
# BROWSING PRESSURE 1.2

killed_volume_cc_brow1.2 <- sum(wind_cc_brow1.2$killedVolume)                # 1601620 m3
killed_volume_cc_brow1.2
killed_volume_per_year_cc_brow1.2 <- killed_volume_cc_brow1.2/400            # 4014.085
killed_volume_per_year_cc_brow1.2
killed_volume_per_year_cc_ha_brow1.2 <- killed_volume_per_year_cc_brow1.2/17749.26
killed_volume_per_year_cc_ha_brow1.2                                 # 0.226155 m3

#_____________________________________________

killed_volume_sw_brow1.2 <- sum(wind_sw_brow1.2$killedVolume)                # 1362593 m3
killed_volume_sw_brow1.2
killed_volume_per_year_sw_brow1.2 <- killed_volume_sw_brow1.2/400            # 3415.021
killed_volume_per_year_sw_brow1.2
killed_volume_per_year_sw_ha_brow1.2 <- killed_volume_per_year_sw_brow1.2/17749.26
killed_volume_per_year_sw_ha_brow1.2                                 # 0.1924036 m3                        


dfnew1_cc_brow1.2 <- landscape_cc_brow1.2[,c(1,8)]

df_vol_cc_brow1.2 = dfnew1_cc_brow1.2 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')

dfnew1_sw_brow1.2 <- landscape_sw_brow1.2[,c(1,8)]

df_vol_sw_brow1.2 = dfnew1_sw_brow1.2 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year_cc_brow1.2 <- df_vol_cc_brow1.2 %>% mutate(perc.vol=100*killed_volume_per_year_cc_ha_brow1.2/tot_vol)

prop_killed_vol_ha_year_sw_brow1.2 <- df_vol_sw_brow1.2 %>% mutate(perc.vol=100*killed_volume_per_year_sw_ha_brow1.2/tot_vol)

par(mfrow = c(1,2))

hist(prop_killed_vol_ha_year_cc_brow1.2$perc.vol, main = "Landscape proportion of killed volume (m3/ha) by wind per year in CC brow 1.2",cex.main = 1.5, xlab = "Killed volume / Total volume (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,140))

legend("topright", c(" m3"), cex = 0.9, title = "Average killed volume (m3/ha) per year", text.font = 3, bg='lightpink')

# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(prop_killed_vol_ha_year_sw_brow1.2$perc.vol, main = "Landscape proportion of killed volume (m3/ha) by wind per year in SW brow 1.2",cex.main = 1.5, xlab = "Killed volume / Total volume (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,140))

legend("topright", c(" m3"), cex = 0.9, title = "Average killed volume (m3/ha) per year", text.font = 3, bg='lightpink')

#____________________________________________________________________________________________________________________________________
#_________________________________________________________________________________________________________________
#   NEW KILLED VOLUME CALCULATION INCLUDING BARK BEETLE


# Wind AND bark beetle disturbance impact in the landscape volume in percentages
# wind and bark beetle regime

killed_volume_cc_brow1.2 <- sum(wind_cc_brow1.2$killedVolume)                   # 5929296 m3
killed_volume_cc_brow1.2
killed_volume_cc_bb_brow1.2 <- sum(barkbeetle_cc_brow1.2$killedVolume)            # 4706904
killed_volume_cc_bb_brow1.2
killed_volume_cc_dist_brow1.2 <- killed_volume_cc_brow1.2 + killed_volume_cc_bb_brow1.2   # 10636200
killed_volume_cc_dist_brow1.2
killed_volume_per_year_cc_brow1.2 <- killed_volume_cc_dist_brow1.2/400            # 26590.5 
killed_volume_per_year_cc_brow1.2
killed_volume_per_year_cc_ha_brow1.2 <- killed_volume_per_year_cc_brow1.2/17749.26
killed_volume_per_year_cc_ha_brow1.2                                         # 1.498119 m3   # 1.747298

#_____________________________________________

killed_volume_sw_brow1.2 <- sum(wind_sw_brow1.2$killedVolume)                   # 5407252 m3
killed_volume_sw_brow1.2
killed_volume_sw_bb_brow1.2 <- sum(barkbeetle_sw_brow1.2$killedVolume)            # 4388046
killed_volume_sw_bb_brow1.2
killed_volume_sw_dist_brow1.2 <- killed_volume_sw_brow1.2 + killed_volume_sw_bb_brow1.2  # 9795297
killed_volume_sw_dist_brow1.2
killed_volume_per_year_sw_brow1.2 <- killed_volume_sw_dist_brow1.2/400            # 24488.24
killed_volume_per_year_sw_brow1.2
killed_volume_per_year_sw_ha_brow1.2 <- killed_volume_per_year_sw_brow1.2/17749.26
killed_volume_per_year_sw_ha_brow1.2                                         # 1.379677 m3                       


# FILTER AND GROUP FOR THE NEEDED COLUMNS AND GROUP BY YEAR TO CREATE NEW DATAFRAMES FOR THE % ANALSIS ON THE KILLED VOLUME PER YEAR

dfnew1_cc_brow1.2 <- landscape_cc_brow1.2[,c(1,8)]

df_vol_cc_brow1.2 = dfnew1_cc_brow1.2 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')

dfnew1_sw_brow1.2 <- landscape_sw_brow1.2[,c(1,8)]

df_vol_sw_brow1.2 = dfnew1_sw_brow1.2 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year_cc_brow1.2 <- df_vol_cc_brow1.2 %>% mutate(perc.vol=100*killed_volume_per_year_cc_ha_brow1.2/tot_vol)
prop_killed_vol_ha_year_cc_brow1.2
summary(prop_killed_vol_ha_year_cc_brow1.2)

prop_killed_vol_ha_year_sw_brow1.2 <- df_vol_sw_brow1.2 %>% mutate(perc.vol=100*killed_volume_per_year_sw_ha_brow1.2/tot_vol)
prop_killed_vol_ha_year_sw_brow1.2
summary(prop_killed_vol_ha_year_sw_brow1.2)

par(mfrow = c(1,2))

hist(prop_killed_vol_ha_year_cc_brow1.2$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind and bark beetles per year in CC brow 1.2",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD", ylim = c(0,90))

legend("topright", c(" m3 /  %"), cex = 0.55, title = "Average killed volume [m3/ha/year] / avarage % on total volume", text.font = 3, bg='lightpink')

# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(prop_killed_vol_ha_year_sw_brow1.2$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind and bark beetles per year in SW brow 1.2",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD", ylim = c(0,90))

legend("topright", c(" m3 /  %"), cex = 0.55, title = "Average killed volume [m3/ha/year] / avarage % on total volume", text.font = 3, bg='lightpink')


### year by year relative proportion ##

# FILTER AND GROUP FOR THE NEEDED COLUMNS AND GROUP BY YEAR TO CREATE NEW DATAFRAMES FOR THE % ANALSIS ON THE KILLED VOLUME PER YEAR

bb_killvol_ha_cc_brow1.2 <- barkbeetle_cc_brow1.2$killedVolume/abeUnit_cc_brow1.2$area
bb_killvol_ha_sw_brow1.2 <- barkbeetle_sw_brow1.2$killedVolume/abeUnit_sw_brow1.2$area

# Add a column of variables in this case volume killed in % of the total ha avg
dist_per_cc_brow1.2 <- abeUnit_cc_brow1.2 %>% mutate(perc.vol=100*bb_killvol_ha_cc_brow1.2/abeUnit_cc_brow1.2$volume)
summary(dist_per_cc_brow1.2)

dist_per_sw_brow1.2 <- abeUnit_sw_brow1.2 %>% mutate(perc.vol=100*bb_killvol_ha_sw_brow1.2/abeUnit_sw_brow1.2$volume)
summary(dist_per_sw_brow1.2)

par(mfrow = c(1,2))  # 763 m3 of difference in CC than in SW

# natural logarithm is based on the "Euler's number" = e ??? 2,71828183

hist(dist_per_cc_brow1.2$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by bark beetles per year in CC brow 1.2",cex.main = 1, xlab = " [Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD",xlim = c(-15,3), ylim = c(0,90))

legend("topright", c(" m3 /  %"), cex = 0.55, title = "Average percentage of killed volume [m3/ha/year] by bark beetle", text.font = 3, bg='lightpink')
# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(dist_per_sw_brow1.2$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by bark beetles per year in SW brow 1.2",cex.main = 1, xlab = "[Killed volume / Total volume] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD",xlim = c(-15,3), ylim = c(0,90))

legend("topright", c(" m3 /  %"), cex = 0.55, title = "Average percentage of killed volume [m3/ha/year] by bark beetle", text.font = 3, bg='lightpink')





# Time series

#dfnew2  <- barkbeetle[,c(1,8)]

df_2 = dfnew1 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year <- df_vol %>% mutate(perc.vol=100*killed_volume_per_year_dist_ha/tot_vol)
prop_killed_vol_ha_year
summary(prop_killed_vol_ha_year)

ggplot(data=lnd2, aes(x=year, y=basal_area_m2, colour=species)) + 
  geom_line(size=1.2)+
  scale_colour_manual(values = c("#76BA1B","#006600", "#A4DE02", "orange"))+
  ggtitle("Clearcut management in brow pressure 0") +
  theme(plot.title = element_text(hjust = 0.5))+
  ylab("Basal area [m2/ha]")+
  theme_bw()



#________________________________________________________________________________________________________________________________________


# Install.packages("RSQLite")

library(RSQLite)
library(dplyr)
library(fields)

#______________________________________________
# Path to search the data
# 1 database with wind disturbances
dataroot <- ("C:/iLand/2022/20220425_browsing_climatechange_test/all_sw/")

# 1 Name of the database C:\iLand\2022\20220425_browsing_climatechange_test\all_sw
file <-paste0(dataroot,"brow1_+4_sw.sqlite")   # file to read

#______________________________________________
# connect to the database of clearcut (cc) model with WIND abd BB
sqlite.driver <- dbDriver("SQLite")
db1 <- dbConnect(sqlite.driver, dbname = file)  # connect to the file
tables.in.the.file<-dbListTables(db1)           # explore the tables in the file
print(tables.in.the.file)


#______________________________________________
# READ IN different tables (present outputs):    (here can read in by table names.... depending on what you have in your outputfile)

bb <- dbReadTable(db1,"barkbeetle")
land <- dbReadTable(db1,"landscape")
w <- dbReadTable(db1,"wind")

dbDisconnect(db1)


#_______________________________________________________________________________

######################### FOR THE LOOP #################################

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

dfnew1  <- land[,c(1,8)]

df_vol = dfnew1 %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year <- df_vol %>% mutate(perc.vol=100*killed_volume_per_year_dist_ha/tot_vol)
prop_killed_vol_ha_year
summary(prop_killed_vol_ha_year)


hist(prop_killed_vol_ha_year$perc.vol, main = "Landscape proportion of killed volume [m3/ha] by wind and bark beetles per year in CC",cex.main = 1, xlab = "[Killed volume / Total volume * 100] = [%]", ylab = "Frequency [years]",cex.lab = 1, col="lightblue", breaks = "FD")

