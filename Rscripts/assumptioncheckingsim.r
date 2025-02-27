
# This script was created by Res Altwegg, Birgit Erni and Greg Distiller 

# The pieces of code below generate data with particular problems. 
# Each piece consists of two parts: first we generate the data and then we explore them (see how the problems look like in the plots)

# --------------------------------------------------------------------------------------------------
# to start with: all assumptions are met (the ideal world...)
# --------------------------------------------------------------------------------------------------
samples <- 10  # number of replicates per treatment
treat <- rep(c("A","B","C","D","E"), each=samples)  # vector with treatment labels
population.means <- c(11,18,13,17,15)  # population means
population.sds <-c(4,4,4,4,4)  # population standard deviations
resp <- rnorm(samples*5, rep(population.means, each=samples), rep(population.sds, each=samples)) # simulate response

dat <- data.frame(treat, resp) # put treatment labels and simulated response into a data frame

# --- data exploration ---

boxplot( resp ~ treat, data=dat, range=0,las=1,
         notch=F, # helps to compare pop means
         xlab='Potion', ylab='Performance')

stripchart(resp ~ treat, data=dat, add=TRUE, 
           vertical=TRUE, method="jitter", jitter=.1)

m1 <- aov(resp~treat, data=dat)  # fit ANOVA
op<-par(mfrow=c(2,2))  # set up graph to plot 4 panels
plot(m1)  # diagnostic plots
par(op)  # reset graphical parameters to what they were before
# --------------------------------------------------------------------------------------------------


# --------------------------------------------------------------------------------------------------
# unequal population variances
# --------------------------------------------------------------------------------------------------
samples <- 10  # number of replicates per treatment
treat <- rep(c("A","B","C","D","E"), each=samples)  # vector with treatment labels
population.means <- c(11,18,13,17,15)  # population means
population.sds <-c(1,10,5,7,2)  # population standard deviations
resp <- rnorm(samples*5, rep(population.means, each=samples), rep(population.sds, each=samples)) # simulate response

dat <- data.frame(treat, resp) # put treatment labels and simulated response into a data frame

# --- data exploration ---

boxplot( resp ~ treat, data=dat, range=0,las=1,
         notch=F, # helps to compare pop means
         xlab='Potion', ylab='Performance')

stripchart(resp ~ treat, data=dat, add=TRUE, 
           vertical=TRUE, method="jitter", jitter=.1)

m1 <- aov(resp~treat, data=dat)  # fit ANOVA
op<-par(mfrow=c(2,2))  # set up graph to plot 4 panels
plot(m1)  # diagnostic plots
par(op)  # reset graphical parameters to what they were before
# --------------------------------------------------------------------------------------------------


# --------------------------------------------------------------------------------------------------

# outliers
# --------------------------------------------------------------------------------------------------
samples <- 10  # number of replicates per treatment
treat <- rep(c("A","B","C","D","E"), each=samples)  # vector with treatment labels
population.means <- c(11,18,13,17,15)  # population means
population.sds <-c(4,4,4,4,4)  # population standard deviations
resp <- rnorm(samples*5, rep(population.means, each=samples), rep(population.sds, each=samples)) # simulate response

dat <- data.frame(treat, resp) # put treatment labels and simulated response into a data frame
dat$resp[c(5,16,17)] <- dat$resp[c(5,16,17)] * 3  # change some data points so they become outliers

# --- data exploration ---

boxplot( resp ~ treat, data=dat, range=0,las=1,
         notch=F, # helps to compare pop means
         xlab='Potion', ylab='Performance')

stripchart(resp ~ treat, data=dat, add=TRUE, 
           vertical=TRUE, method="jitter", jitter=.1)

m1 <- aov(resp~treat, data=dat)  # fit ANOVA
op<-par(mfrow=c(2,2))  # set up graph to plot 4 panels
plot(m1)  # diagnostic plots
par(op)  # reset graphical parameters to what they were before
# --------------------------------------------------------------------------------------------------


# skew distributions (normality assumption violated)
# --------------------------------------------------------------------------------------------------
samples <- 20  # number of replicates per treatment
treat <- rep(c("A","B","C","D","E"), each=samples)  # vector with treatment labels
population.means <- log(c(11,18,13,17,15))  # population means
population.sds <-c(1,1,1,1,1)  # population standard deviations
resp <- exp(rnorm(samples*5, rep(population.means, each=samples), rep(population.sds, each=samples))) # simulate response

dat <- data.frame(treat, resp) # put treatment labels and simulated response into a data frame

# --- data exploration ---

boxplot( resp ~ treat, data=dat, range=0,las=1,
         notch=F, # helps to compare pop means
         xlab='Potion', ylab='Performance')

stripchart(resp ~ treat, data=dat, add=TRUE, 
           vertical=TRUE, method="jitter", jitter=.1)

m1 <- aov(resp~treat, data=dat)  # fit ANOVA
op<-par(mfrow=c(2,2))  # set up graph to plot 4 panels
plot(m1)  # diagnostic plots
par(op)  # reset graphical parameters to what they were before
# --------------------------------------------------------------------------------------------------


# errors not independent (in this example: drift in the measurements over time)
# --------------------------------------------------------------------------------------------------
samples <- 20  # number of replicates per treatment
treat <- rep(c("A","B","C","D","E"), each=samples)  # vector with treatment labels
population.means <- c(11,18,13,17,15)  # population means
population.sds <-c(1,1,1,1,1)  # population standard deviations
resp <- rnorm(samples*5, rep(population.means, each=samples), rep(population.sds, each=samples)) # simulate response

dat <- data.frame(treat, resp) # put treatment labels and simulated response into a data frame
time <- sample(1:length(treat))  # a vector giving the order in which the data were collected (we assume that order was randomised in this experiment)
dat$resp <- dat$resp * (1+time/100)  # add temporal drift effect to observations

# --- data exploration ---

# hard to see that anything is wrong in the boxplots:
boxplot( resp ~ treat, data=dat, range=0,las=1,
         notch=F, # helps to compare pop means
         xlab='Potion', ylab='Performance')

stripchart(resp ~ treat, data=dat, add=TRUE, 
           vertical=TRUE, method="jitter", jitter=.1)

# dotplot (we plot the data in sequence of observation, i.e. time):
od<-order(time)  # this gives us the order of the observations in time, which we'll use to sort the observations for the plot
dotchart(dat$resp[od],ylab="Order of observation", xlab="Performance")

m1 <- aov(resp~treat, data=dat)  # fit ANOVA
op<-par(mfrow=c(2,2))  # set up graph to plot 4 panels
plot(m1) # regular diagnostic plots also don't show that there is a problem
par(op)  # reset graphical parameters to what they were before

plot(time, resid(m1))  # plotting residuals against temporal sequence shows the problem: a clear trend over time
# --------------------------------------------------------------------------------------------------

