library(dplyr)

#' You could assign something to skip.RDS.reading
#' if there are already suitable NEI and SCC in your workspace
if(is.null(.GlobalEnv$skip.RDS.reading)){
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  skip.RDS.reading <- TRUE
}

NEI.by.year <- NEI %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

png("plot1.png")

with(NEI.by.year, {
  names(Emissions) <- year
  barplot(Emissions / 1e6, col = "red", xlab = "Year", ylab = "Emissions (millions of tons)", main = "Total US PM2.5 Emissions")
  })

dev.off()