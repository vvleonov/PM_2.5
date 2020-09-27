# Plot5 script

# Downloading libraries
library(zip)

# Downloading data and unpacking it
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "./archive.zip")
unzip("./archive.zip")

# Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting the data set 
motor <- SCC[grep("[Vv]ehicle|[Vv]ehicles", SCC$SCC.Level.Two), ]
NEI_sub <- NEI[NEI$SCC %in% motor$SCC & NEI$fips == "24510", ]

# Processing data and plotting it + saving to a file
sum_year <- with(NEI_sub, tapply(Emissions, year, sum))
barplot(sum_year,
        col = "darkblue",
        xlab = "Years",
        ylab = "Emissions",
        main = "Total emissions from motor vehicle sources in Baltimore")
dev.copy(png, "./plot5.png")
dev.off()