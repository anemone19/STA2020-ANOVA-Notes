---
title: "Contrasts"
---


::: {.cell}

:::






After finding that there is evidence to suggest that at least two of the treatments differed from each other (another way to say there is a treatment effect!), we want to find out which ones differed and estimate these differences. In the Pygmalion experiment, there were only two treatments so we know the difference is between them. In fact, we could have used a paired t-test to analyse the data and we would get the same results. Generally though, there will be more than two treatments and then after concluding that there are differences, we want to know where the differences lie.

::: column-margin
When we have blocks in RCBD, the observations are paired and data from two treatments can be analysed using a paired t-test. When we do not have blocks, the observations are not and data from two treatments can be analysed using a standard t-test.
:::

To do that, we use the coefficients from fitting a linear regression model to estimate the difference between the two treatments (as we did for CRD experiments as well). The null hypothesis is again:

$$H_0: \mu_C - \mu_P = 0 $$

where C stands for Control and P for Pygmalion. We use the `lm` function as in regression.

::: column-margin
We use the `lm` function when we are primarily interested in the coefficient estimates and difference. We use `aov()` when we want a breakdown of how much each factor can explain of the overall variation in the response, and when we want a general test for 'are there *any* difference between the treatments'.
:::






::: {.cell}

```{.r .cell-code}
pyg_model_reg <- lm(Score ~ Treat + Company, data = pyg_data)
summary(pyg_model_reg)
```

::: {.cell-output .cell-output-stdout}

```

Call:
lm(formula = Score ~ Treat + Company, data = pyg_data)

Residuals:
   Min     1Q Median     3Q    Max 
-9.390 -3.217  0.000  3.217  9.390 

Coefficients:
               Estimate Std. Error t value Pr(>|t|)    
(Intercept)      66.210      5.184  12.771 4.52e-07 ***
TreatPygmalion   10.780      3.126   3.448  0.00729 ** 
CompanyC10        2.100      6.990   0.300  0.77069    
CompanyC2         1.900      6.990   0.272  0.79191    
CompanyC3         0.600      6.990   0.086  0.93348    
CompanyC4        -3.600      6.990  -0.515  0.61897    
CompanyC5         9.250      6.990   1.323  0.21839    
CompanyC6        12.750      6.990   1.824  0.10147    
CompanyC7        -3.250      6.990  -0.465  0.65303    
CompanyC8        -1.950      6.990  -0.279  0.78659    
CompanyC9        -0.700      6.990  -0.100  0.92243    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 6.99 on 9 degrees of freedom
Multiple R-squared:  0.7127,	Adjusted R-squared:  0.3936 
F-statistic: 2.233 on 10 and 9 DF,  p-value: 0.1211
```


:::
:::






A few things to note here.

1.  We are only interested in the second line starting with `TreatPygmalion`. R pasted the name of the factor and the name of the treatment level together.

2.  The Control treatment was taken as the baseline (it comes first in the alphabet).

3.  The remaining lines are not of interest to us. It estimates the differences between each block and the first and tests whether these effects are different from zero. R doesn't know we aren't interested in these, so it computes the effects and hypothesis test as if we are. We ignore this part.

4.  If we didn't know that this code was for analysing a RCBD we would probably think that it is linear regression with two categorical variables. Think back to the regression module, what does this intercept represent? It represents the mean score for some treatment level and company. Since 'C' comes before 'P' in the alphabet and C1 is before everything else, the intercept is the average score for the control group in the first block. This is because R uses the *treatment contrast* parameterisation by default for all the factors. We can change this by letting R know that the block effects sum to zero.






::: {.cell}

```{.r .cell-code}
pyg_model_reg2 <- lm(Score ~ Treat + C(as.factor(Company), contr.sum), data = pyg_data)
summary(pyg_model_reg2)
```

::: {.cell-output .cell-output-stdout}

```

Call:
lm(formula = Score ~ Treat + C(as.factor(Company), contr.sum), 
    data = pyg_data)

Residuals:
   Min     1Q Median     3Q    Max 
-9.390 -3.217  0.000  3.217  9.390 

Coefficients:
                                  Estimate Std. Error t value Pr(>|t|)    
(Intercept)                         67.920      2.211  30.725 2.01e-10 ***
TreatPygmalion                      10.780      3.126   3.448  0.00729 ** 
C(as.factor(Company), contr.sum)1   -1.710      4.689  -0.365  0.72379    
C(as.factor(Company), contr.sum)2    0.390      4.689   0.083  0.93554    
C(as.factor(Company), contr.sum)3    0.190      4.689   0.041  0.96857    
C(as.factor(Company), contr.sum)4   -1.110      4.689  -0.237  0.81818    
C(as.factor(Company), contr.sum)5   -5.310      4.689  -1.132  0.28675    
C(as.factor(Company), contr.sum)6    7.540      4.689   1.608  0.14232    
C(as.factor(Company), contr.sum)7   11.040      4.689   2.354  0.04300 *  
C(as.factor(Company), contr.sum)8   -4.960      4.689  -1.058  0.31775    
C(as.factor(Company), contr.sum)9   -3.660      4.689  -0.780  0.45514    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 6.99 on 9 degrees of freedom
Multiple R-squared:  0.7127,	Adjusted R-squared:  0.3936 
F-statistic: 2.233 on 10 and 9 DF,  p-value: 0.1211
```


:::
:::






Now, the intercept is what we expect, the mean score for the control treatment across all blocks.






::: {.cell}

```{.r .cell-code}
mean(pyg_data$Score[pyg_data$Treat == "Control"])
```

::: {.cell-output .cell-output-stdout}

```
[1] 67.92
```


:::
:::






Let's interpret the hypothesis test for the difference between the treatment means. The estimated difference is 10.78 with a standard error of 3.126. The test statistic is 3.448 which has a p-value of 0.00729. Look familiar? It's the exact same p-value we found in the ANOVA table! That is because the ANOVA is an extension of the t-test to more than two groups and when we only have two treatments, they are equivalent. In fact, the test statistics have the following relationship:

$$ t^2 = F$$

Test the result to confirm that it holds. Now, let's return to the interpretation. The test shows that the difference between the control and Pygmalion treatment is statistically significant, as indicated by the extremely small p-value. This provides strong evidence against the null hypothesis of equal means.

To recall the experiment's design: The researchers aimed to test the Pygmalion effect while eliminating interpersonal contrasts by assigning treatments to entire groups. Specifically, platoons within companies were used as treatment units, and since there were 10 companies, each with 2 platoons, companies served as blocks. The response variable, theoretical specialty knowledge, was measured through test scores.

The results of a two-way ANOVA provide evidence of a treatment effect ($F = 11.89$, $p = 0.0073$). More precisely, the estimated difference between the control and Pygmalion treatment was 10.78 (s.e. = $3.13$, $t = 3.45$, $p = 0.0073$). This suggests that the Pygmalion effect was successful, as soldiers in the Pygmalion group scored higher on average than those in the control group.

::: column-margin
In an actual analysis, we would not report both the ANOVA and t-test since they are equivalent when we have two treatments.
:::

Nice! We're done. Before we move on, I'll summarise the results of the actual study. The researcher had four different responses:

-   Theoretical specialty knowledge (taught by platoon leaders)
-   Practical specialty skills (taught by platoon leaders)
-   Physical fitness (assessed independently)
-   Target shooting (assessed independently)

Significant treatment effects were found for theoretical and practical specialty scores ($F = 13.74$, $p < 0.01$ and $F = 6.37$, $p < 0.05$, respectively). No significant difference was found for physical fitness or target shooting, confirming that the Pygmalion effect was specific to areas influenced by leader expectations! This suggests that high expectations from others can enhance performance, particularly in areas where they have direct influence. With this in mind, I want you to know that **I believe in your potential to excel in this course and expect nothing less. ;)** On to the next section!
