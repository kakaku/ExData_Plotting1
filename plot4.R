args = commandArgs(trailingOnly=TRUE)
if(length(args)>0 & args[1] == "debug"){
  dat <- read.csv("household.csv")
} else {
  filename <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  temp <- tempfile()
  download.file(filename, temp)
  header <- read.table(unz(temp, "household_power_consumption.txt"), nrows=1, sep=";")
  dat <- read.table(unz(temp, "household_power_consumption.txt"), nrows=2880, skip=66637, sep=";")
  colnames(dat) <- unlist(header)
  unlink(temp)
}

png("plot4.png", bg="transparent")
par(mfrow=c(2,2))
plot(
  strptime(paste(dat$Date, dat$Time), format="%d/%m/%Y %H:%M:%S"),
  dat$Global_active_power,
  type="l",
  xlab="",
  ylab="Global Active Power")
plot(
  strptime(paste(dat$Date, dat$Time), format="%d/%m/%Y %H:%M:%S"),
  dat$Voltage,
  type="l",
  xlab="datetime",
  ylab="Voltage")
plot(
  strptime(paste(dat$Date, dat$Time), format="%d/%m/%Y %H:%M:%S"),
  dat$Sub_metering_1,
  type="l",
  xlab="",
  ylab="Energy sub metering")
lines(
  strptime(paste(dat$Date, dat$Time), format="%d/%m/%Y %H:%M:%S"),
  dat$Sub_metering_2,
  col="red")
lines(
  strptime(paste(dat$Date, dat$Time), format="%d/%m/%Y %H:%M:%S"),
  dat$Sub_metering_3,
  col="blue")
legend(
  "topright",
  lty=1,
  col=c("black", "red", "blue"),
  legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
plot(
  strptime(paste(dat$Date, dat$Time), format="%d/%m/%Y %H:%M:%S"),
  dat$Global_reactive_power,
  type="l",
  xlab="datetime",
  ylab="Global_reactive_power")
dev.off()
