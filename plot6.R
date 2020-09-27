# Plot6 script

# Downloading libraries
library(zip)

# Downloading data and unpacking it
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "./archive.zip")
unzip("./archive.zip")

# Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Making panel plot and subsetting the data sets
par(mfrow = c(1,2))
motor <- SCC[grep("[Vv]ehicle|[Vv]ehicles", SCC$SCC.Level.Two), ]

NEI_sub_balt <- NEI[NEI$SCC %in% motor$SCC & NEI$fips == "24510", ]
sum_year_balt <- with(NEI_sub_balt, tapply(Emissions, year, sum))

NEI_sub_los <- NEI[NEI$SCC %in% motor$SCC & NEI$fips == "06037", ]
sum_year_los <- with(NEI_sub_los, tapply(Emissions, year, sum))

# Creating y-axis limits
rng <- range(sum_year_balt, sum_year_los)

# Plotting + saving to a file
barplot(sum_year_balt,
        col = "darkblue",
        xlab = "Years",
        ylab = "Emissions",
        main = "Baltimore",
        ylim = rng)

barplot(sum_year_los,
        col = "darkred",
        xlab = "Years",
        ylab = "Emissions",
        main = "Los Angeles",
        ylim = rng)
dev.copy(png, "./plot6.png")
dev.off()