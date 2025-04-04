# A Simple Model for a CRD

To analyse data collected from a Completely Randomised Design we could use $t$-tests and compare the samples two at a time. This approach is problematic for two reasons. Firstly, the test statistic of a $t$-test is calculated with a standard deviation based only on the two samples it considers. We want our test statistic to consider the variability in all samples collected. Second, when we conduct multiple tests the overall Type 1 Error rate increases. That is, when doing many tests, the chance of making *at least one wrong conclusion* increases with the number of tests (if you want to know more see the box below). To avoid this, we will use the ANOVA method which was specifically developed for comparing multiple means.

::: {.callout-caution icon="false" collapse="false"}
## Multiple Testing / Comparisons

When we conduct a test, there is always a possibility that a significant result is due to chance and not actually a real difference. In first year, you were taught the Neyman-Pearson approach to hypothesis testing, which entails setting a significance level ($\alpha$) for the test you will conduct. This significance level is the Type 1 error rate (probability of falsely rejecting $H_0$). A common $\alpha$ is 0.05, meaning that 5% of the time we will reject the null hypothesis even if it is true. That means when we find a significant result, one of two things have happened:

1.  Either we genuinely found a significant result or,
2.  We were that unlucky, that our result is one of those 5% cases.

We will never know, this is the basis of statistical testing. We accept that we cannot tell which of our conclusions are Type 1 Errors. When we conduct many tests, the overall Type 1 Error rate increases. That is the overall chance of *at least one wrong conclusion* increases with the number of tests conducted. This is not good! We already might be wrong 5% and we don't want to increase that risk even further when conducting multiple tests.
:::

## The model

When we collect samples, we usually want to learn something about the populations from which they were drawn. To do this, we can develop a model for the observations that reflects the different sources of variation believed to be at play.

For Completely Randomised Designs, we have $a$ treatments which implies $a$ population means $\mu_1, \mu_2, \mu_3, \ldots, \mu_a$. We are interested in modelling the means of the treatments and the differences between them. Ultimately we want to test whether they are equal which we'll get to in the next section. First, we construct a simple model for each observation $Y_{ij}$:

$$
Y_{ij} = \mu_{i} + e_{ij},
$$

where

$$
\begin{aligned}
i & = 1, \dots, a \quad (a = \text{number of treatments}) \\
j & = 1, \dots, r \quad (r = \text{number of replicates}) \\
Y_{ij} & = \text{observation of the } j^{th} \text{ unit receiving treatment } i \\
\mu_i & = \text{mean of treatment } i \\
e_{ij} & = \text{random error with } e_{ij} \sim N(0, \sigma^2)
\end{aligned}
$$

That is, each observation is modeled as the sum of its population mean and some random variation, $e_{ij}$. This random variation represents unexplained differences between individual observations within the same group and we assume that these differences follow a normal distribution with mean 0 and constant variance across all treatment groups. [^06_crd_model-1]

[^06_crd_model-1]: As opposed to non-constant variance across all treatment groups: $e_{ij} \sim N(0, \sigma^2_{i})$ where the $\sigma_i^2$'s are different.

We can change the notation slightly by arbitrarily dividing each mean into a sum of two components: the overall mean $\mu$ (the mean of the entire data set, which is the same as the mean of the $a$ means[^06_crd_model-2]) and the difference between the population mean and the overall mean. In symbols, this translates to:

[^06_crd_model-2]: $\mu = \frac{\sum\mu_i}{a}$

$$
\begin{aligned}
\mu_1 &= \mu + (\mu_1 - \mu) \\
\mu_2 &= \mu + (\mu_2 - \mu) \\
&\;\;\vdots \notag \\
\mu_a &= \mu + (\mu_a - \mu)
\end{aligned}
$$

The difference $(\mu_i - \mu)$ is the **effect of treatment** $i$, denoted by $A_i$. So each population mean is the sum of the overall mean and the part that we attribute to the particular treatment ($A_i$):

$$
\mu_i = \mu + A_i, \quad i = 1, 2, \dots, a,
$$

where $\sum A_i = 0$.

::: {.callout-caution collapse="false" icon="false"}
## Why the $\sum A_i = 0$ constraint?

This constraint ensures that the treatment effects are expressed as deviations from the overall mean. To see why this holds, take the sum of both sides of the equation:

$$
\sum_{i=1}^{a} \mu_i = \sum_{i=1}^{a} (\mu + A_i).
$$

Expanding the right-hand side:

$$
\sum_{i=1}^{a} \mu_i = a\mu + \sum_{i=1}^{a} A_i.
$$

By definition, the overall mean $\mu$ is the mean of the treatment means:

$$
\mu = \frac{1}{a} \sum_{i=1}^{a} \mu_i.
$$

Multiplying both sides by $a$ gives:

$$
\sum_{i=1}^{a} \mu_i = a\mu.
$$

Comparing this with our earlier equation:

$$
a\mu = a\mu + \sum_{i=1}^{a} A_i.
$$

Subtracting $a\mu$ from both sides, we get:

$$
\sum_{i=1}^{a} A_i = 0.
$$

This constraint is standard in ANOVA models to ensure that the treatment effects are relative to the overall mean rather than being arbitrarily defined. It is not an additional assumption; any $a$ means can be written in this way.
:::

Replacing $\mu_i$ in the model above leads to the common parameterisation of a single-factor ANOVA model[^06_crd_model-3]:

[^06_crd_model-3]: Often called **Model I**.

$$
Y_{ij} = \mu + A_{i} + e_{ij}
$$

where

$$
\begin{aligned}
i & = 1, \dots, a \quad (a = \text{number of treatments}) \\
j & = 1, \dots, r \quad (r = \text{number of replicates}) \\
Y_{ij} & = \text{observation of the } j^{th} \text{ unit receiving treatment } i \\
\mu & = \text{overall or general mean} \\
A_i & = \text{effect of the } i^{th} \text{ level of treatment factor A} \\
e_{ij} & = \text{random error with } e_{ij} \sim N(0, \sigma^2)
\end{aligned}
$$

::: {.callout-caution icon="false" collapse="false"}
## Comparison to regression

If you wanted to, you could rewrite this with the regression notation you've encountered before as a regression model with a single categorical explanatory variable:

$$ Y_i = \beta_0 + \beta_1 T2_i + \beta_2 T3_i + e_i $$

where $T2$ and $T3$ are indicator variables (i.e. $T2 = 1$ if observation $i$ is from treatment 2 and 0 otherwise). The intercept estimates the mean of the baseline category, here it is $T1$.

These two models are equivalent. The data are exactly the same: in both situations we have $a$ groups and we are interested in the mean response of these groups and the difference between them. The model notation is just slightly different. In the ANOVA model we use $\mu$ and $A_i$ instead of $\beta_0$ and $\beta_i$ which have different meanings.

| Regression | ANOVA |
|:----------------------------------:|:----------------------------------:|
| $\beta_0$ is the mean of the baseline category | $\mu$ is the overall mean |
| $\beta_1$ is the difference between the means of category 2 and the baseline category. | $A_i$ is the effect of treatment $i$, i.e. change in mean response relative to the overall mean. |

When all the explanatory variables are categorical, which is mostly the case in comparative experimental data, it is more convenient to write the model in the ANOVA form, for two reasons:

1.  The $A_i$ notation is more concise, because we don't have to add all the dummy variables. This makes it easier to read and understand because there is only one term per factor.

2.  Mathematically it is more convenient. In this format all terms are deviations from a mean. This leads directly to sums of squares[^06_crd_model-4] (squared deviations from a mean) and analysis of variance. We will see later that we can partition the total sum of squares into one part for every factor in the model. This allows us to investigate the variability in the response contributed by every model term (or factor).
:::

[^06_crd_model-4]: In statistics, sums of squares is a measure of variability and refers to squared deviations from a mean or expected value. For example, the residual sums of squares (sum of squared deviations of the observations from the fitted values).

The model can be interpreted as follows:

Each observation, $Y_{ij}$, is the sum of the overall mean ($\mu$), plus the effect of the treatment it belongs to ($A_i$), and some random error ($e_{ij}$). We use two subscripts on the $Y$. One to identify the group (treatment) and the other to identify the subject (experimental unit) within the group:


$$
\begin{aligned}
Y_{1j} &= \mu + A_1 + e_{1j} \\ 
Y_{2j} &= \mu + A_2 + e_{2j} \\ 
Y_{3j} &= \mu + A_3 + e_{3j} \\
&\;\;\vdots \notag \\
Y_{aj} &= \mu + A_a + e_{aj} \\
\end{aligned}
$$

## Estimation

Okay, so we have a model which we now need to **fit to our data**. When we do this, we estimate the model parameters using our data. The parameters we want to estimate are $\mu$ (the overall mean), the treatment effects ($A_i$) and $\sigma^2$ (the error variance). As for regression, we find **least squares estimates** for the parameters which minimise the residual or error sum of squares[^06_crd_model-5]:

[^06_crd_model-5]: error = observed - fitted.

$$ \text{SSE} = \sum_i\sum_j e_{ij}^2 = \sum_i\sum_j (Y_{ij} - \hat{Y}_{ij})^2 = \sum_i\sum_j (Y_{ij} - \mu - A_i)^2$$

It turns out when we solve for the estimates that minimise the SSE[^06_crd_model-6], we obtain the following estimators:

[^06_crd_model-6]: Another name for this is the residual sums of squares (RSS).

$$
\begin{aligned}
\hat{\mu} = \bar{Y}_{..} \\
\hat{\mu}_i = \bar{Y}_{i.}
\end{aligned}
$$

and

$$\hat{A}_i =  \bar{Y}_{i.} - \bar{Y}_{..}$$

From linear model theory we know that the above are unbiased estimates[^06_crd_model-7] of $\mu$ and the $A_i$'s. What does this tell you? It tells you that we can use the sample means as estimates for the true means. The estimated mean response for treatment $i$ is the observed sample mean of treatment $i$ and the observed overall mean is the estimated grand mean.

[^06_crd_model-7]: Unbiased means that the expected value of these statistics equals the parameter being estimated. In other words, the statistic equals the true parameter on average.

For the last parameter, the error variance, an unbiased estimator is found by dividing the minimised SSE (i.e. calculated with the least squares estimates) by its degrees of freedom:

$$ s^2 = \frac{1}{N-a}\sum_{ij}(Y_{ij} - \bar{Y}_{i.})^2 $$

This quantity is called the Mean Squares for Error (MSE) or residual mean square. It has $(N-a)$ degrees of freedom since we have $N$ observations and have estimated $a$ means. If you look at the formula you'll notice that it is an average of the observed variability from the different treatment groups.

::: {.callout-caution collapse="false" icon="false"}
## Compare this with regression

Compare this with the equations you saw in the regression section. Barring the extra subscript, the only difference is the equation for calculating the fitted/predicted value.

In regression, the fitted value is:

$$ \hat{Y}_i = \hat{\beta}_0 + \hat{\beta}_1X_i $$

and here it is:

$$ \hat{Y}_{ij} = \bar{Y}_{i.} = \hat{\mu} + \hat{A}_i $$
:::

## In context of the social media multitasking example

Let's take what we've learned so far and apply it to our example. We had $a = 3$ treatments each with $r=40$ replicates. The model equation is:

$$ Y_{ij} = \mu + A_{i} + e_{ij}  $$

where

$$
\begin{aligned}
i & = 1, \dots, 3  \\
j & = 1, \dots, 40 \\
\end{aligned}
$$

If we write the model out for each treatment, we get:

$$
\begin{aligned}
Y_{Cj} &= \mu + A_C + e_{Cj} \\ 
Y_{E1j} &= \mu + A_{E1} + e_{E1j} \\ 
Y_{E2j} &= \mu + A_{E2} + e_{E2j} \\
\end{aligned}
$$

and when we fit the model to the data, the predicted means for the treatments are:

$$
\begin{aligned}
\hat{Y}_{C} &= \hat{\mu} + \hat{A}_C = \bar{Y}_{C.}\\ 
\hat{Y}_{E1} &= \hat{\mu} + \hat{A}_{E1} = \bar{Y}_{E1.}\\ 
\hat{Y}_{E2} &= \hat{\mu} + \hat{A}_{E2} = \bar{Y}_{E2.}
\end{aligned}
$$

To fit this model in R, we use the `aov` function and then use another function to extract the estimated parameters. By specifying type = "effects", the function returns the $\hat{A_i}$'s






::: {.cell}

:::

::: {.cell}

:::






This tells us that the average score for students in the control group is roughly 12% higher than the overall average[^06_crd_model-8]. Both experimental groups performed worse, with students in the second group scoring, on average, about 11% less than the mean across all groups. We can also extract the overall mean and the treatment means by specifying type = "means":

[^06_crd_model-8]: Remember: $\mu_i = \mu + A_i$






::: {.cell}

:::






The grand mean (i.e. average of all test scores) was 64% in this experiment. The control group scored on average 76% which is 12% higher than the overall mean and so on. So we have the estimates for the effects, grand mean and treatment means.

The last parameter we need to estimate is the error variance $\sigma^2$. Have a look at the formula again:

$$ s^2 = \frac{1}{N-a}\sum_{ij}(Y_{ij} - \bar{Y}_{i.})^2 $$

If we focus on the sum and break into sums of squares for each treatment $i$, we get for the first treatment (let's say that is the control group):

$$ \sum_{j}(Y_{1j} - \bar{Y}_{1.})^2 $$ Which is the sum of the squared differences between the observations in the control group and the mean score of the control group. We can easily calculated that in R:






::: {.cell}

:::






First, we subset the data set for the scores in the control group. Then we find the mean and calculate the squared differences, which is all summed together to give the sums of squares for treatment group 1. We can repeat this for the remaining treatments and sum the three sum of squares together and divide by $N-a$ to get the MSE.






::: {.cell}

:::






Later we will see that we can extract this quantity easily from the ANOVA table. But for now, this is a useful exercise to make sure you understand the formula. So, $\hat{\sigma^2} = s^2 = 200$ (rounded off to the nearest integer) and $\hat{\sigma} = s = 14$. This is the estimate of variance we will use to conduct an hypothesis to determine if there are any difference in the treatment means. Now you can see that it takes into account the variability of all our samples.

## Standard errors and confidence intervals

In the previous section we saw how the parameters of the ANOVA model are estimated. We also need a measure of uncertainty for each of these estimates (in the form of a standard error, variance, or confidence interval). Let’s start with the variance of a treatment mean estimate:

::: column-margin
**Variance, Standard Deviation and Standard Error: what’s all this again?** The variance (Var) is a good way of measuring variability. The Standard Deviation (SD) is the square root of the variance of a sample or population. The Standard Error (SE) is the SD of an estimate (read that again).
:::

$$Var(\mu_i) = \frac{\sigma^2}{n_i} $$

Remember that the sampling distribution of the mean is $N(\mu,\frac{\sigma^2}{n})$ and here we assumed that the groups have equal population variances.

If we assume that two treatment means are independent, the variance of the difference between two means is:

$$
Var(\hat{\mu}_i - \hat{\mu}_j) = Var(\hat{\mu}_i) + Var(\hat{\mu}_j) = \frac{\sigma^2}{n_i} + \frac{\sigma^2}{n_j}
$$

To estimate these variances we substitute the MSE for $\sigma^2$ as it is an unbiased estimate of the error variance (the variability within each group). The standard errors of the estimates are found by taking the square root of the variances. The standard error is the standard deviation of an estimated quantity, and is a measure of its precision (uncertainty); how much it would vary in repeated sampling.

We can assume normal distributions for our estimates because we have assumed a normal linear model and because they are means (or differences between means). This means that confidence intervals for the population treatment means are of the form:

$$ \text{estimate} \pm t^{\alpha/2}_v \times \text{SE}(\text{estimate})$$

where $t^{\alpha/2}_v$ is the ${\alpha/2}^{th}$ percentile of the Student's $t$ distribution with $v$ degrees of freedom. The degrees of freedom are the error degrees of freedom, $N-a$ for CRD.

What are the standard errors associated with the parameter estimates in the social media example? We can easily extract this by specifying an extra argument to the `model.tables` function.

Standard error of the effects:






::: {.cell}

:::






and for the treatment means:






::: {.cell}

:::






So, now we have parameter estimates and their standard errors. Equipped with these, we are closer to answering the original question: Does social media multitasking impact academic performance of students? Based on the model we fitted and the parameters we estimated, how do we test this? The answer is with an ANOVA table.

## Summary

This chapter introduces the Completely Randomized Design (CRD) model and explains why ANOVA is preferred over multiple t-tests, which inflate the Type 1 Error rate.

In ANOVA, each observation is modeled as:

$$
Y_{ij} = \mu + A_{i} + e_{ij}
$$

where $\mu$ is the overall mean, $A_{i}$ is the treatment effect (difference between treatment mean $\mu_i$ and the overall mean), and $e_{ij}$ is random error which normally distributed with mean 0 and variance ($\sigma^2$).

Parameters are estimated using least squares, with the mean squares error (MSE) providing an estimate of variance ($\sigma^2$).

Applying ANOVA to the social media multitasking study, we estimated treatment means and effects together with their standard errors, setting the stage for hypothesis testing using an ANOVA table.
