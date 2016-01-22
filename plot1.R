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

png("plot1.png", bg="transparent")
par(mar=c(5,4,4,2))
hist(dat$Global_active_power, col="red", ylim=c(0,1200), main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
