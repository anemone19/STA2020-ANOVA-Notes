::: {.cell}

:::






# Contrasts

The aim in many experiments is to compare treatments. To do this we contrast one group of means with another, i.e. we compare means, or groups of means, to see if treatments differ, and by how much they differ. A comparison of treatments (or groups of treatments) is called a contrast. If the experiment has been conducted as a result of specific research hypotheses, these will already define the contrasts we should construct first.

For a single-factor CRD with only two treatments, we could conduct a t-test to compare the two means or construct a confidence interval to estimate the difference. But we know that with more than two treatments, we encounter problems of multiple testing. How do we contrast treatments when we have a factor with more than two levels?

## Contrasting pairs of treatment means {.unnumbered}

We wrote the ANOVA model as:

$$Y_{ij} = \mu + A_i + e_{ij}$$

<!-- :::{.column-margin} -->

<!-- Remember: $A_i = \mu_i - \mu$ -->

<!-- ::: -->

with overall mean and the treatment effects as the parameters (as well as the error variance). Because the effects are constrained to sum to zero, i.e. $\sum_i^a A_i = 0$ we call this ANOVA model the *sum-to-zero* parameterisation.

The above parameterisation is useful for constructing ANOVA tables. For estimating differences between treatments, however, a different parameterisation is more useful:

$$Y_{ij} = A_i + e_{ij}$$ In this version, we no longer have the overall mean as a parameter but use only the treatment effects $A_i$. Remember that any model ultimately needs to describe the treatment means. There are a number of different ways in which to do this. One is the so-called *treatment contrast* parameterisation, which R uses as default for regression models. In this parameterisation, $A_1$ estimates the mean of the baseline treatment (by default, R orders the treatments alphabetically and takes the first one as baseline). The other parameters then estimate the difference between each treatment and the baseline treatment: $A_2$ estimates the difference between the second and the first treatment, $A_3$ estimates the difference between the third and the first, etc.

::: column-margin
Construction of treatmenat means under the *treatment contrast* parameterisation:

$$
\begin{aligned}
\mu_1 &= A_1 \\ 
\mu_2 &= A_1 + A_2 \\
\vdots& \\
\mu_a &= A_1 + A_a
\end{aligned}
$$

and under the *sum-to-zero* parameterisation:

$$
\begin{aligned}
\mu_1 &= \mu + A_1 \\ 
\mu_2 &= \mu + A_2 \\
\vdots& \\
\mu_a &= \mu + A_a
\end{aligned}
$$
:::

To get a better understanding of this, let's fit the model to the social media data with this parameterisation. In R, this is done by using the `lm` function.






::: {.cell}

```{.r .cell-code}
m1.tc <- lm(Posttest ~ Group, data = multitask)
summary(m1.tc)
```

::: {.cell-output .cell-output-stdout}

```

Call:
lm(formula = Posttest ~ Group, data = multitask)

Residuals:
    Min      1Q  Median      3Q     Max 
-32.964 -10.175   0.583   8.550  37.408 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   75.634      2.237  33.812  < 2e-16 ***
GroupExp1    -12.752      3.163  -4.031 9.92e-05 ***
GroupExp2    -23.394      3.163  -7.395 2.32e-11 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 14.15 on 117 degrees of freedom
Multiple R-squared:  0.3191,	Adjusted R-squared:  0.3075 
F-statistic: 27.42 on 2 and 117 DF,  p-value: 1.717e-10
```


:::
:::






This is exactly the same output as you have seen before in the regression section! The intercept measures the mean of the baseline treatment (here it is the Control group). The next estimate `GroupExp1` is the difference between the mean of Experiment 1 and the mean of the Control group. Similarly, the last one is the difference between the mean of the Control Group and that of Experiment 2. You can verify this by using the mean estimates we obtain when we fit the model previously:






::: {.cell}

```{.r .cell-code}
model.tables(m1, type = "means")
```

::: {.cell-output .cell-output-stdout}

```
Tables of means
Grand mean
         
63.58527 

 Group 
Group
Control    Exp1    Exp2 
  75.63   62.88   52.24 
```


:::

```{.r .cell-code}
62.88 - 75.63 #GroupExp1
```

::: {.cell-output .cell-output-stdout}

```
[1] -12.75
```


:::

```{.r .cell-code}
52.24 - 75.63 #GroupExp2 
```

::: {.cell-output .cell-output-stdout}

```
[1] -23.39
```


:::
:::






Why is this useful? Now, we can formally test whether these differences are statistically significant using a hypothesis test!

Think back to regression—what was the null hypothesis for the coefficients in the output?

It was:

$$\beta_i = 0$$.

The same principle applies here. We test whether the treatment effects ($A_i$) are equal to zero:

$$H_0: A_i = 0$$

Since we are interested in testing differences between groups, and the control group serves as the baseline, we are specifically testing:

$$
\begin{aligned}
H_0: A_2 &= 0 \\ 
H_0: A_3 &= 0
\end{aligned}
$$

This is the test that R conducts in the output above. It tests, for the last two parameters, the hypothesis that the difference between Experiment 1 and the Control is zero an that the difference between Experiment 2 and the Control is zero. In both cases, the p-values are extremely small which suggest that there are differences (the effects are not equal to zero).

What about the intercept? This is testing that the mean of the Control group is zero. So, it tests whether the students in the control group scored zero on average. This doesn't really make sense and it is not a useful test. So not all tests that R carries out are necessarily useful or informative! Very often testing whether the intercept is different from zero is not interesting.

What if we aren't interested in the contrast R perform by default? We wanted to know whether there is a difference between the other two groups? We simply need to change the baseline treatment that R uses and we can do this easily using the `relevel` command:






::: {.cell}

```{.r .cell-code}
m1.tc <- lm(Posttest ~ relevel(Group, ref ="Exp1"), data = multitask)
summary(m1.tc)
```

::: {.cell-output .cell-output-stdout}

```

Call:
lm(formula = Posttest ~ relevel(Group, ref = "Exp1"), data = multitask)

Residuals:
    Min      1Q  Median      3Q     Max 
-32.964 -10.175   0.583   8.550  37.408 

Coefficients:
                                    Estimate Std. Error t value Pr(>|t|)    
(Intercept)                           62.882      2.237  28.111  < 2e-16 ***
relevel(Group, ref = "Exp1")Control   12.752      3.163   4.031 9.92e-05 ***
relevel(Group, ref = "Exp1")Exp2     -10.642      3.163  -3.364  0.00104 ** 
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 14.15 on 117 degrees of freedom
Multiple R-squared:  0.3191,	Adjusted R-squared:  0.3075 
F-statistic: 27.42 on 2 and 117 DF,  p-value: 1.717e-10
```


:::
:::






Notice that the residual standard error, F-value and other statistics at the end of the output are exactly the same as for Model m1.tc above. The two models are equivalent and provide the same fit to the data. The only difference is that the parameters have different interpretations.

To conclude this section, we present the final results of the social media multitasking experiment. The ANOVA revealed a significant treatment effect on academic performance ($F = 27.42$, $p = 1.72\times e^{-10}$). Specifically, students in both experimental conditions performed worse than those in the control group. On average, students in Experiment 1 scored 12% lower ($t = -4.031$, $p = 9.92 \times 10^{-5}$), while those in Experiment 2 scored 24% lower ($t = -7.395$, $p = 2.32 \times 10^{-11}$), with a standard error of 3.163. Students in Experiment 2 scored on average 10% less than those in Experiment 1 ($t=-3.364$, $p = 0.001$). This confirms that multitasking with social media during lectures negatively impacted academic performance in this experiment.

I think the message is clear, going on social media during lectures is probably not going to help you learn. In general reducing the time you spend on social media will probably help you. You certainly don't have to delete all social media apps, but taking intentional breaks and trying to give your full attention when it is required, will certainly make a difference. Here are some videos that have motivated me to improve my focu and decrease my time spent on social media!

-   Why we can't focus <https://www.youtube.com/watch?v=6QltxZ-vPMc>

-   Quit social media <https://www.youtube.com/watch?v=3E7hkPZ-HTk>
