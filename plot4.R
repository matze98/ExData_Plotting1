
# read data
electricity <- tbl_df(read.table("household_power_consumption.txt", header = TRUE, sep = ";", numerals = "allow.loss", na.strings = "?", stringsAsFactors = FALSE))

# reformat dates 
electricity$Date <- as.Date(electricity$Date, "%d/%m/%Y")

# filter for relevant dates
eld <- filter(electricity, Date == "2007-02-01" | Date == "2007-02-02")
# add column with POSIX date
eld <- mutate(eld, posix_date=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

# plot figure 4
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2), mar=c(4, 4, 1, 2))  
with(eld, plot(posix_date, Global_active_power, type="l", xlab ="", ylab = "Global Active Power", cex.axis=0.8, cex.lab=0.8))
with(eld, plot(posix_date, Voltage, type="l", xlab="datetime", cex.axis=0.8, cex.lab=0.8))
with(eld, plot(posix_date, Global_active_power, type="n", ylim=c(0, 38), xlab ="", ylab = "Energy sub metering", cex.axis=0.8, cex.lab=0.8))
with(eld, lines(posix_date, Sub_metering_1))
with(eld, lines(posix_date, Sub_metering_2, col="red"))
with(eld, lines(posix_date, Sub_metering_3, col="blue"))
with(eld, legend("topright", cex=0.8, bty="n", lwd="1", col=c("black", "red", "blue"), legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3")))
with(eld, plot(posix_date, Global_reactive_power, type="l", xlab="datetime", cex.axis=0.8, cex.lab=0.8))
dev.off()







