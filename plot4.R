# Plot4 script

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
coal_comb <- SCC[grep("[Cc]oal", SCC$Short.Name), ]
NEI_sub <- NEI[NEI$SCC %in% coal_comb$SCC, ]

# Processing data and plotting it + saving to a file
sum_year <- with(NEI_sub, tapply(Emissions, year, sum))
barplot(sum_year,
        col = "darkgreen",
        xlab = "Years",
        ylab = "Emissions",
        main = "Total emissions from coal combustion-related sources")
dev.copy(png, "./plot4.png")
dev.off()