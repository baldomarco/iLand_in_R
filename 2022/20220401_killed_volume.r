#___________________________________________________________________________________________________________________________________
# Wind disturbances impact in the landscape volume in percentages 20220323 (13 events in different direction and based on statistics)
# wind + barkbeetle

killed_volume_cc <- sum(wind_cc$killedVolume)                # 10484586 m3
killed_volume_cc
killed_volume_per_year_cc <- killed_volume_cc/400            # 26211.46 m3
killed_volume_per_year_cc
killed_volume_per_year_cc_ha <- killed_volume_per_year_cc/17749.26
killed_volume_per_year_cc_ha                                 # 1.476764 m3

_____________________________________________

killed_volume_sw <- sum(wind_sw$killedVolume)                # 10398225 m3
killed_volume_sw
killed_volume_per_year_sw <- killed_volume_sw/400            # 25995.56 m3
killed_volume_per_year_sw
killed_volume_per_year_sw_ha <- killed_volume_per_year_sw/17749.26
killed_volume_per_year_sw_ha                                 # 1.4646 m3                        


dfnew1_cc <- landscape_cc[,c(1,8)]

df_vol_cc = dfnew1_cc %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')

dfnew1_sw <- landscape_sw[,c(1,8)]

df_vol_sw = dfnew1_sw %>% group_by(year)  %>%
  summarise(tot_vol = sum(volume_m3),
            .groups = 'drop')


prop_killed_vol_ha_year_cc <- df_vol_cc %>% mutate(perc.vol=100*1.476764/tot_vol)
prop_killed_vol_ha_year_cc

mean(prop_killed_vol_ha_year_cc$perc.vol)    # 0.427708

prop_killed_vol_ha_year_sw <- df_vol_sw %>% mutate(perc.vol=100*1.4646/tot_vol)
prop_killed_vol_ha_year_sw

mean(prop_killed_vol_ha_year_sw$perc.vol)    # 0.4297575

par(mfrow = c(1,2))

hist(prop_killed_vol_ha_year_cc$perc.vol, main = "Landscape proportion of killed volume (m3/ha) by wind per year in CC",cex.main = 1.2, xlab = "Killed volume / Total volume in (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,70))

legend("topright", cex = 0.8, c("1.46 m3 and 0.43 %"), title = "Average killed volume (m3/ha and %) per year", title.adj = 0.35, text.font = 3, bg='lightpink')

# legend("topleft",c("sample1","sample2"),cex=.8,col=c("red","blue"),pch=c(1,2),box.col="green", title="sample types", text.font=4,  bg='lightblue')

hist(prop_killed_vol_ha_year_sw$perc.vol, main = "Landscape proportion of killed volume (m3/ha and %) by wind per year in SW",cex.main = 1.2, xlab = "Killed volume / Total volume in (%)", ylab = "Frequency (years)",cex.lab = 1.4, col="lightblue", breaks = "FD", ylim = c(0,70))

legend("topright",cex = 0.8, c("1.485 m3 and 0.44 %"), title = "Average killed volume (m3/ha) per year", title.adj = 0.3, text.font = 3, bg='lightpink')

______________________________________________________________________
#Hi Victor,
   
#looking at the code for legend, it looks like the same 'cex' value is
#used for the text in the legend as the title.

#Here is a trick though: draw the legend twice, with different cex
#values, and omitting title or text:
  
  
#  plot(1)
#legend("topright",c("a","b"),title=" ")
#legend("topright",c(" "," "),title="Legend",cex=0.6, bty='n', title.adj=0.15)


#A bit of a hack but it works....
#If you want the title larger, it will probably not fit the box, which
#you can omit by setting bty='n' (as in the second line).

#good luck,

#Remko
______________________________________________________________________
