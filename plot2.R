library(dplyr)

#' You could assign something to skip.RDS.reading
#' if there are already suitable NEI and SCC in your workspace
if(is.null(.GlobalEnv$skip.RDS.reading)){
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  skip.RDS.reading <- TRUE
}

NEI.by.year <- NEI %>% filter( fips == 24510 ) %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

png("plot2.png")

with(NEI.by.year, {
  names(Emissions) <- year
  barplot(Emissions / 1e3, col = "red", xlab = "Year", ylab = "Emissions (thousands of tons)", main = "Baltimore City PM2.5 Emissions")
  })

dev.off()