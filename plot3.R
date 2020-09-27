# Plot3 script

# Downloading libraries
library(zip)
library(ggplot2)
library(tidyr)

# Downloading data and unpacking it
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "./archive.zip")
unzip("./archive.zip")

# Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Processing data and plotting it using ggplot2 + saving to a file
grouped <- as.data.frame(with(NEI[NEI$fips == "24510", ], tapply(Emissions, list(year, type), sum)))
grouped$Year = rownames(grouped)
tidy <- gather(grouped, Type, Emissions, -Year)
ggplot(data = tidy, aes(x = Year, y = Emissions)) +
  facet_grid(.~Type) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Total emissions by type in the Baltimore City, 1999 - 2008")
dev.copy(png, "./plot3.png")
dev.off()