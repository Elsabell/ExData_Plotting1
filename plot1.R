library(dplyr)

hpc_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";") 
# dim(hpc_data); names(hpc_data); head(hpc_data); str(hpc_data)
# length(grep("^(1/2/2007|2/2/2007)$", hpc_data$Date))
hpc <- hpc_data[grepl("^(1/2/2007|2/2/2007)$", hpc_data$Date), ]

hpc$DateTime <- paste(hpc$Date, hpc$Time)
hpc$DateTime <- strptime(hpc$DateTime, "%d/%m/%Y %H:%M:%S")

# Plot 1
hpc1 <- hpc
hpc1$Global_active_power <- as.numeric(hpc1$Global_active_power)
hpc1 <- hpc1[!is.na(hpc1$Global_active_power),]

png(filename = "plot1.png",width = 480, height = 480)
hist(hpc1$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", col = "red")
dev.off()
dev.cur()

    
     
    
