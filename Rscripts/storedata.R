

store1 <- rpois(20, 50)
store2 <- rpois(20, 15)
storedata <- data.frame(numcust = c(store1, store2),
                        store = factor(rep(c("Store 1", "Store 2"), each = 20)))


png("storedata.png", width = 2000, height = 1500, res = 300) # High resolution
stripchart(numcust ~ store, data = storedata,
           method = "jitter", pch = 16, col = c("lightblue", "orange"),
           vertical = TRUE, main = "Customer Counts per Store",
           xlab = "Store", ylab = "Number of Customers")
means <- tapply(storedata$numcust, storedata$store, mean)
segments(x0 = 1:2- 0.1, x1 = 1:2 + 0.1, y0 = means, y1 = means, lwd = 3, col = "black") 
dev.off() # Close the graphics



png("storedata2.png", width = 2000, height = 1500, res = 300) # High resolution
stripchart(numcust ~ store, data = storedata,
           method = "jitter", pch = 16, col = c("deepskyblue", "orange"),
           vertical = TRUE, main = "Customer Counts per Store",
           xlab = "Store", ylab = "Number of Customers")
means <- tapply(storedata$numcust, storedata$store, mean)
segments(x0 = 1:2- 0.1, x1 = 1:2 + 0.1, y0 = means, y1 = means, lwd = 3, col = "black") 
min_count <- min(storedata$numcust[storedata$store == "Store 1"])
min_x <- jitter(rep(1, sum(storedata$numcust == min_count))) 
points(min_x, min_count, col = "red", pch = 16, cex = 1.2) 
segments(x0 = min_x, x1 = min_x, y0 = min_count, y1 = means["Store 1"], col = "red", lwd = 2, lty = 2)
dev.off() # Close the graphics




# Regression 


x <- rnorm(35,mean = 35, sd = 5)
error <- rnorm(35,0,5)
plot(x)

beta0 <- 2
beta1 <- 1.5


y <- beta0 + beta1 * x + error


obs_index <- 20  
x_obs <- x[obs_index]
y_obs <- y[obs_index]
y_pred <- predict(model, newdata = data.frame(x = x_obs))  


png("storedata3.png", width = 2000, height = 1500, res = 300)

plot(x, y, pch = 16, col = "darkseagreen",
     xlab = "X", ylab = "Y",
     main = "Scatter Plot with Regression Line",
     cex.lab = 1.5, cex.axis = 1.2, cex.main = 1.5)
abline(model, col = "black", lwd = 2)
points(x_obs, y_obs, col = "red", pch = 16, cex = 1.2)  # Observed point in red
segments(x0 = x_obs, x1 = x_obs, y0 = y_pred, y1 = y_obs, col = "red", lwd = 2, lty = 2)

dev.off()


