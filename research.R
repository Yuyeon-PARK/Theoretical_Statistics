gdp<-read.csv("gdp.csv")
suicide<-read.csv("suicide.csv")
happiness<-read.csv("happiness.csv")
life_expectancy<-read.csv("life expectancy.csv")
code<-read.csv("code.csv")
names(gdp)<-c("region","GDP")
names(suicide)<-c("region","Suicide")
names(happiness)<-c("region","Happiness")
names(life_expectancy)<-c("region","Life_expectancy")
code<-code[1:3]
names(code)<-c("Continent","Code","region")

dat<-merge(gdp,suicide,key="region")
dat<-merge(dat,happiness,key="region")
dat<-merge(dat,life_expectancy,key="region")
dat<-merge(dat,code,key="region")
dat$GDP<-as.numeric(dat$GDP)
dat
dat$ln.GDP<-log(dat$GDP)
dat$Life_expectancy<-as.numeric(dat$Life_expectancy)
dat$Suicide<-as.numeric(dat$Suicide)
dat[1:5,]
 ggplot(dat, aes(x=ln.GDP, y=Life_expectancy)) + 
   geom_point(aes(color=Code, size=Suicide))+
   geom_text(aes(label=region), vjust=1, colour="grey40", size=3) + 
   scale_size_area(max_size = 15)+
   ggtitle("Bubble chart") 


dat.df<-as.data.frame(dat)
colnames(dat)[1]<-"region"
str(dat.df)
world_map <- map_data("world")
suicide.map <- full_join(dat.df, world_map, by = "region")
str(suicide.map)

ggplot(suicide.map, aes(long, lat, group = group))+
  geom_polygon(aes(fill = Suicide), color = "white")+
  scale_fill_viridis_c(option = "C")



