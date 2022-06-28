





#.....

annual.data<-landscape %>% group_by(year) %>% summarize(VOL.tot=sum(volume_m3), BA.tot=sum(basal_area_m2), count.tot=sum(count_ha))
annual.spec.data<-landscape %>% group_by(year, species) %>%  summarize(VOL=(volume_m3), BA=(basal_area_m2), count=sum(count_ha))

print(head(annual.data))
print(head(annual.spec.data))

S<-landscape %>% group_by(year) %>% filter(volume_m3>0) %>% summarise(n=n())   # number of species in each year  (added the filter to count non-zero volumes, now it is okay)
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
