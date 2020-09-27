pm0 <- read.csv("daily_88101_1999.csv")
x0 <- pm0$Arithmetic.Mean
pm1 <- read.csv("daily_88101_2019.csv")
x1 <- pm1$Arithmetic.Mean

boxplot(log10(x0),log10(x1))

negative <- x1 < 0
sum(negative)
mean(negative)

site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.Num)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.Num)))
site0 <- paste(site0[, 1], site0[, 2], sep = ".")
site1 <- paste(site1[, 1], site1[, 2], sep = ".")

both <- intersect(site0, site1)
pm0$county.site <- with(pm0, paste(County.Code, Site.Num, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.Num, sep = "."))
cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)
sapply(split(cnt0, cnt0$county.site), nrow)
sapply(split(cnt1, cnt1$county.site), nrow)

pm0sub <- subset(cnt0, County.Code == 29 & Site.Num == 5)
pm1sub <- subset(cnt1, County.Code == 29 & Site.Num == 5)

rng <- range(x0sub, x1sub)

dates0 <- as.Date(pm0sub$Date.Local)
x0sub <- pm0sub$Arithmetic.Mean
plot(dates0, x0sub, pch = 20, ylim = rng)
abline(h = median(x0sub))

dates1 <- as.Date(pm1sub$Date.Local)
x1sub <- pm1sub$Arithmetic.Mean
plot(dates1, x1sub, pch = 20, ylim = rng)
abline(h = median(x1sub))

mn0 <- with(pm0, tapply(Arithmetic.Mean, State.Code, mean))
mn1 <- with(pm1, tapply(Arithmetic.Mean, State.Code, mean))

d0 <- data.frame(state = names(mn0), mean = mn0)
d1 <- data.frame(state = names(mn1), mean = mn1)

mrg <- merge(d0, d1, by = "state")

with(mrg, plot(rep(1999, 52), mrg[, 2], xlim = c(1998, 2020)))
with(mrg, points(rep(2019, 52), mrg[, 3]))
segments(rep(1999, 52), mrg[, 2], rep(2019, 52), mrg[, 3])