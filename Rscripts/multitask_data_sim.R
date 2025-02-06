


library(broom)


# Method 1 -------------------------------------
# Simulating dataset for the experimental design

set.seed(123) # For reproducibility

# Number of simulations
nsims <- 100 # Adjust the number of simulations as needed

# Initialize an empty vector to store p-values
pvals <- c()

# Sample sizes
n_per_group <- 40

# Group labels
Group <- rep(c("Control", "Exp1", "Exp2"), each = n_per_group)

# Loop over the number of simulations
for (i in 1:nsims) {
  
  # Simulate Posttest scores for each group
  Posttest <- c(
    rnorm(n_per_group, 74.82, 11.60), # Control group
    rnorm(n_per_group, 63.90, 15.03), # Experiment 1
    rnorm(n_per_group, 54.90, 16.75)  # Experiment 2
  )
  
  # Create a data frame
  sim_df1 <- data.frame(Group, Posttest)
  
  # Perform ANOVA
  mod1 <- aov(Posttest ~ Group, data = sim_df1)
  anova_summary <- summary(mod1)
  
  # Extract p-value and append to pvals vector
  p_value <- tidy(mod1)$p.value[1]
  pvals <- c(pvals, p_value)
}

# Inspect the first few p-values
head(pvals)

# Optional: summary of the p-values
summary(pvals)

hist(pvals)


Posttest <- c(
  rnorm(n_per_group, 74.82, 11.60), # Control group
  rnorm(n_per_group, 63.90, 15.03), # Experiment 1
  rnorm(n_per_group, 54.90, 16.75)  # Experiment 2
)

# Create a data frame
sim_df1 <- data.frame(Group, Posttest)

# Perform ANOVA
mod1 <- aov(Posttest ~ Group, data = sim_df1)
summary(mod1)

plot(m1)

# Checking assumptions

boxplot(Posttest~Group, data=sim_df1)
stripchart(Posttest~Group,data=sim_df1,vertical=TRUE, add=TRUE, method = "jitter")

sort(tapply(sim_df1$Posttest,sim_df1$Group,sd))

sim_df1 <- sim_df1[sample(nrow(sim_df1)), ]
dotchart(sim_df1$Posttest)


summary(sim_df1)
sim_df1
write.csv(sim_df1,file="multitask_performance.csv", row.names = F)

# Method 2 -------------------------------------

N <- 10
groups <- rep(c("A","B","C"), each=10)
DV <- c(rnorm(100,5,15),   # means for group A
        rnorm(100,10,15),   # means for group B
        rnorm(100,20,15)    # means for group C
)
sim_df<-data.frame(groups,DV)

aov_results <- summary(aov(DV~groups, sim_df))

library(xtable)
knitr::kable(xtable(aov_results))


# Checking assumptions

boxplot(DV~groups, data = sim_df)
stripchart(DV~groups, data = sim_df,vertical=TRUE, add=TRUE, method = "jitter")

sort(tapply(sim_df$DV,sim_df$groups,sd))

dotchart(sim_df$DV)


WPM<-rnorm(60,c(20,30,40),5)
WPM[WPM<0]<-0
Subjects<-factor(rep(seq(1,20),each=3))
Practice<-rep(c("day1","day2","day3"),20)
AllData<-data.frame(Subjects,Practice,WPM)
ANOVAresults<-aov(WPM~Practice + Error(Subjects/Practice), AllData)
summary(ANOVAresults)
model.tables(ANOVAresults,"means")

dotchart(AllData$WPM)
