# Load necessary libraries
library(ggplot2)
library(gridExtra)

set.seed(5)
data2 <- data.frame(Treatment = rep("T1B3", 5), Response = rnorm(5,10,2))  
data3 <- data.frame(Treatment = rep("T1B3", 5), Response = rnorm(5,3,2))  

par(mfrow=c(1,3))
## PLOT 1 
plot(1, max(data2$Response), pch = 16, col = "red", xlim = c(0.5, 1.5), ylim = c(0, 15), xaxt = "n",
     yaxt ="n", ylab = "Response", xlab = "", main = "", bty = "l")
text(1.15, max(data2$Response), expression("treatment mean " ~ bar(Y)[13]), col = "red", cex = 0.9)
text(0.95, max(data2$Response), expression(Y[13]), col = "black", cex = 0.9)
segments(x0 = 0.7, x1 = 1.3, y0 = 2, y1 = 2, lwd = 2)
text(1.4, 2, expression(mu + alpha[1] + beta[3]), cex = 1)

## PLOT 2 

plot(rep(1, 5), data2$Response, pch = 16, col = "red", xlim = c(0.5, 1.5), ylim = c(0, 15), xaxt = "n",
     yaxt ="n", ylab = "Response", xlab = "", main = "", bty = "l")
text(1.2, mean(data2$Response), expression("treatment mean " ~ bar(Y)[13]), col = "red", cex = 0.9)
text(1.05, max(data2$Response), expression(Y[131]), col = "black", cex = 0.9)
segments(x0 = 0.95, x1 = 1.05, y0 = mean(data2$Response), y1 = mean(data2$Response), lwd = 2)  
segments(x0 = 0.7, x1 = 1.3, y0 = 2, y1 = 2, lwd = 2)  
text(1.4, 2, expression(mu + alpha[1] + beta[3]), cex = 1)

## PLOT 3

plot(rep(1, 5), data3$Response, pch = 16, col = "red", xlim = c(0.5, 1.5), ylim = c(0, 15), xaxt = "n",
     yaxt ="n", ylab = "Response", xlab = "", main = "", bty = "l")
text(1.05, max(data3$Response), expression(Y[131]), col = "black", cex = 0.9)
text(1.2, mean(data3$Response), expression("treatment mean " ~ Y[13]), col = "red", cex = 0.9)
segments(x0 = 0.95, x1 = 1.05, y0 = mean(data3$Response), y1 = mean(data3$Response), lwd = 2)  
segments(x0 = 0.7, x1 = 1.3, y0 = 2, y1 = 2, lwd = 2)  
text(1.4, 2, expression(mu + alpha[1] + beta[3]), cex = 1)

