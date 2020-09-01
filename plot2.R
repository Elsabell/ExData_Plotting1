library(dplyr)

hpc_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";") 
# dim(hpc_data); names(hpc_data); head(hpc_data); str(hpc_data)
# length(grep("^(1/2/2007|2/2/2007)$", hpc_data$Date))
hpc <- hpc_data[grepl("^(1/2/2007|2/2/2007)$", hpc_data$Date), ]

hpc$DateTime <- paste(hpc$Date, hpc$Time)
hpc$DateTime <- strptime(hpc$DateTime, "%d/%m/%Y %H:%M:%S")

# Plot 2
hpc2 <- hpc
hpc2$Global_active_power <- as.numeric(hpc2$Global_active_power)
hpc2 <- hpc2[!is.na(hpc2$Global_active_power),]
My_LC_Time <- Sys.getlocale("LC_TIME") 
Sys.setlocale("LC_TIME", "English") 

png(filename = "plot2.png",width = 480, height = 480)
plot(hpc2$DateTime, hpc2$Global_active_power, type = "l", xlab ="", 
     ylab = "Global Active Power (kilowatts)")
dev.off()
dev.cur()
Sys.setlocale("LC_TIME", My_LC_Time ) 