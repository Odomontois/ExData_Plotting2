library(dplyr)
library(ggplot2)

#' You could assign something to skip.RDS.reading
#' if there are already suitable NEI and SCC in your workspace
if(is.null(.GlobalEnv$skip.RDS.reading)){
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  skip.RDS.reading <- TRUE
}

NEI.by.year <- NEI %>% 
  filter( fips == 24510 ) %>% 
  mutate(year = as.factor(year)) %>%
  group_by(year, type) %>% 
  summarise(Emissions = sum(Emissions))


png("plot3.png", width = 960 )

the.plot <- qplot( year, Emissions, data = NEI.by.year, facets = . ~ type, geom = "bar", stat = "identity") + 
  ylab("Emissions (tons)") + 
  ggtitle("Baltimore City PM2.5 Emissions by type")

print(the.plot)

dev.off()