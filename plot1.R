
library(dplyr)

# read data
electricity <- tbl_df(read.table("household_power_consumption.txt", header = TRUE, sep = ";", numerals = "allow.loss", na.strings = "?", stringsAsFactors = FALSE))

# reformat dates 
electricity$Date <- as.Date(electricity$Date, "%d/%m/%Y")

# filter for relevant dates
eld <- filter(electricity, Date == "2007-02-01" | Date == "2007-02-02")

# plot figure 1
png(filename="plot1.png", width=480, height=480)
with(eld, hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab="Frequency", col="red"))
dev.off()
