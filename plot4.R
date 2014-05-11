
setwd("C:\\Users\\iNejc\\Desktop\\predavanja_ostala\\coursera\\Data_science_specialization_John_Hopkins_University\\4Exploratory_data_analysis\\project_1")

################################## READING DATA ###########################################
start_day <- strptime("1/2/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S")# day when we start analysis
finish_day <- strptime("3/2/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S")# day when we start analysis

first_row <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 1)#readin just first row
beg <- strptime(paste(first_row$Date, first_row$Time), format = "%d/%m/%Y %H:%M:%S")#beginning in dataset
start <- as.numeric(difftime(start_day, beg, units = "mins"))
finish <- as.numeric(difftime(finish_day, start_day, units = "mins"))

data <- read.table("household_power_consumption.txt", header = T, sep = ";", 
                   skip = start, nrows = finish)

col_names <- read.table("household_power_consumption.txt", header = F, sep = ";", nrows = 1)
names <- c()

for(i in 1:ncol(col_names)){
    names <- append(names, as.character(col_names[,i]))
}

colnames(data) <- names

#################################### SUBSETING AND ARRANGING DATA ####################

for(i in 3:ncol(data)){
    #because all variables are type factor we have to convert them into numeric
    #we convert from third variable till end in data set. First two variables
    #are type date
    data[,names(data)[i]] <- as.numeric(as.character(data[,names(data)[i]]))
}

data$date <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

Sys.setlocale("LC_ALL", "C")#internationalization of script

###############################  GRAPH 4  ################################################

png("plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2, 2))

plot(data$date, data$Global_active_power, type = "l", xlab = "", 
     ylab = "Global active power", bg = "white")

plot(data$date, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", bg = "white")


plot(data$date, data$Sub_metering_1, type = "l", col = "black", xlab = "", 
     ylab = "Energy sub metering", bg = "white")
lines(data$date, data$Sub_metering_2, type = "l", col = "red")
lines(data$date, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")

plot(data$date, data$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global reactive power", bg = "white")

dev.off()


par(mfrow = c(1, 1))#setting number of rows an columns at ploting back to default


