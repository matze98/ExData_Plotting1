
# read data
electricity <- tbl_df(read.table("household_power_consumption.txt", header = TRUE, sep = ";", numerals = "allow.loss", na.strings = "?", stringsAsFactors = FALSE))

# reformat dates 
electricity$Date <- as.Date(electricity$Date, "%d/%m/%Y")

# filter for relevant dates
eld <- filter(electricity, Date == "2007-02-01" | Date == "2007-02-02")
# add column with POSIX date
eld <- mutate(eld, posix_date=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

# subset canvas
par(mfrow = c(1, 1)) 

# plot figure 3
png("plot3.png", width=480, height=480)
with(eld, plot(posix_date, Global_active_power, type="n", ylim=c(0, 38), xlab ="", ylab = "Energy sub metering"))
with(eld, lines(posix_date, Sub_metering_1))
with(eld, lines(posix_date, Sub_metering_2, col="red"))
with(eld, lines(posix_date, Sub_metering_3, col="blue"))
legend("topright", lwd="1", col=c("black", "red", "blue"), legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"))
dev.off()
