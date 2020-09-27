# Plot1 script

# Downloading libraries
library(zip)

# Downloading data and unpacking it
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "./archive.zip")
unzip("./archive.zip")

# Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Processing data and plotting it + saving to a file
sum_year <- with(NEI, tapply(Emissions, year, sum))
barplot(sum_year,
        col = "red",
        xlab = "Years",
        ylab = "Emissions",
        main = "Total emissions from PM2.5 in the United States")
dev.copy(png, "./plot1.png")
dev.off()