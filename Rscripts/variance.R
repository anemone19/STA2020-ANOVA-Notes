
data.val = c(1.5377, 0.6923, 1.6501, 3.7950, 5.6715, 
             2.8339, 1.5664, 6.0349, 3.8759, 3.7925,
             -1.2588, 2.3426, 3.7254, 5.4897, 5.7172,
             1.8622, 5.5784, 2.9369, 5.4090, 6.6302,
             1.3188, 4.7694, 3.7147, 5.4172, 5.4889)
data.grp = c(rep(1:5, 5))

df = data.frame(val = data.val,
                grp = factor(data.grp) )

library(ggplot2)
gg = ggplot(df, aes(x = grp, y = val, fill=grp)) + 
  geom_boxplot(alpha=0.5) +
  xlab("Columns") +
  ylab("Values")
print(gg)

aov.out   = aov(val ~ grp, df)
anova.out = anova(aov.out)
print(anova.out)


## 
# Calc variance within group
nGrp        = length(unique(data.grp)) # different groups
var.within  = vector(mode = "numeric", length = nGrp)
mean.within = vector(mode = "numeric", length = nGrp)




for ( i in 1:nGrp ){
  idx              = data.grp == i
  var.within[[i]]  = var(data.val[idx])
  mean.within[[i]] = mean(data.val[idx])
}


# The average within group variance is equal to the "Residuals" Mean Sq in the anova table:
# This is Var_within = E[ Var[grp1], Var[grp2], ..., Var[grp5] ]
var.withinAverage = mean(var.within)
print(paste0("var.within = ", var.withinAverage))

# The variance between groups is given by
# Var_between = Var[ E[grp1],  E[grp2], ... E[grp5] ]
var.between = var(mean.within)

print(paste0("var.between = ", var.between))

##
# To obtain the MS_between term, we have to multiply by the sample size per group:
kSample    = sum(data.grp == 1) # number of elements within each group
MS.between = kSample * var.between
print(paste0("MS.between = kSample * var.between = ", MS.between))

##
# Thus, if we invert the last expression we get:
# var.between = MS.between / kSample

means <- tapply(multitask$Posttest,multitask$Group,mean)
gmean <- mean(multitask$Posttest)
