library(dplyr)

hpc_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";") 
# dim(hpc_data); names(hpc_data); head(hpc_data); str(hpc_data)
# length(grep("^(1/2/2007|2/2/2007)$", hpc_data$Date))
hpc <- hpc_data[grepl("^(1/2/2007|2/2/2007)$", hpc_data$Date), ]

hpc$DateTime <- paste(hpc$Date, hpc$Time)
hpc$DateTime <- strptime(hpc$DateTime, "%d/%m/%Y %H:%M:%S")

# Plot 4
hpc4 <- hpc
hpc4$Global_active_power <- as.numeric(hpc4$Global_active_power)
hpc4$Sub_metering_1 <- as.numeric(hpc4$Sub_metering_1)
hpc4$Sub_metering_2 <- as.numeric(hpc4$Sub_metering_2)
hpc4$Sub_metering_3 <- as.numeric(hpc4$Sub_metering_3)
hpc4$Voltage  <- as.numeric(hpc4$Voltage)
hpc4$Global_reactive_power  <- as.numeric(hpc4$Global_reactive_power)
My_LC_Time <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English") 

png(filename = "plot4.png",width = 480, height = 480)
par(mfcol = c(2,2))
plot(hpc2$DateTime, hpc2$Global_active_power, type = "l", xlab ="", 
     ylab = "Global Active Power")
plot(hpc3$DateTime, hpc3$Sub_metering_1, type = "l", xlab ="", 
     ylab = "Energy sub metering", col = "black")
lines(hpc3$DateTime, hpc3$Sub_metering_2, col = "red")
lines(hpc3$DateTime, hpc3$Sub_metering_3, col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(hpc4$DateTime, hpc4$Voltage, type = "l", xlab ="datetime", 
     ylab = "Voltage")
plot(hpc4$DateTime, hpc4$Global_reactive_power, type = "l", xlab ="datetime", 
     ylab = "Global_reactive_power")
dev.off()
dev.cur()
Sys.setlocale("LC_TIME", My_LC_Time ) 