
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

# plot figure 2
png("plot2.png", width=480, height=480)
with(eld, plot(posix_date, Global_active_power, type="l", xlab ="", ylab = "Global Active Power (kilowatts)"))
dev.off()
