
# Method 1 -------------------------------------
# Simulating dataset for the experimental design
set.seed(2) # For reproducibility

# Sample sizes
n_per_group <- 40

Group <- rep(c("Control","Exp1","Exp2"), each=40)
Posttest <- c(rnorm(n_per_group, 75, 10),
              rnorm(n_per_group, 65, 10),
              rnorm(n_per_group, 55, 10))


sim_df1<-data.frame(Groups,Posttest)

# Checking assumptions

boxplot(Posttest~Group, data=sim_df1)
stripchart(Posttest~Group,data=sim_df1,vertical=TRUE, add=TRUE, method = "jitter")

sort(tapply(sim_df1$Posttest,sim_df1$Group,sd))

sim_df1 <- sim_df1[sample(nrow(sim_df1)), ]
dotchart(sim_df1$Posttest)

summary(sim_df1)
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
