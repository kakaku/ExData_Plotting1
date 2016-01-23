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
  write.csv(dat, file="household.csv", row.names=FALSE)
}

png("plot2.png", bg="transparent")
par(mar=c(5,4,4,2))
plot(
  strptime(paste(dat$Date, dat$Time), format="%d/%m/%Y %H:%M:%S"),
  dat$Global_active_power,
  type="l",
  xlab="",
  ylab="Global Active Power (kilowatts)")
dev.off()
