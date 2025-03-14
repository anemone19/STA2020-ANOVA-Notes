## A brief guideline to hypothesis testing {.unnumbered}

> These notes have been adapted from the STA1007 notes (authored by Dr Res Altwegg and Dr Greg Distiller and some other textbooks.

Hypothesis testing is a statistical procedure of using sample data to make inferences about populations. Unlike estimation, where the goal is to quantify a parameter, hypothesis testing assesses whether an observed effect is statistically significant. More specifically, a hypothesis test evaluates two mutually exclusive statements about the population and determines which statement the data supports.

### The General Framework

Hypothesis testing follows a structured process:

1.  **State the Hypotheses**: Define the null hypothesis (H₀) and the alternative hypothesis (H₁).

The basic idea of hypothesis testing is that we set up a so-called null hypothesis and then ask how likely our data are if the null hypothesis were true. If they are unlikely, we conclude that we have found evidence against the null hypothesis, i.e. the null hypothesis is probably not true.

The alternative hypothesis covers all the possibilities not covered by the null hypothesis. If we conclude that the null hypothesis is probably not true, that means that the alternative hypothesis is probably true. These two hypotheses are not equal in how we treat them:

-   We start by assuming the null is true and check if the data gives enough evidence to reject it.

-   If the data strongly contradicts the null, we lean toward the alternative hypothesis.

But we never prove the alternative hypothesis outright—we only show that the null is unlikely based on the evidence. You can think of the null hypothesis as representing a baseline against which the data are compared, whereas the alternative hypothesis is what we really care about, worry about or want to demonstrate. This is an important asymmetry and will need some careful reflection.

Below is an example:

Null Hypothesis ($H_0$): "The average weight of chocolate bars is 100g."

Alternative Hypothesis ($H_A$): "The average weight of chocolate bars is less than 100g."

Lack of evidence against $H_0$ is not the same as evidence for $H_0$. We never say that we have evidence for $H_0$ or that we accept $H_0$ as true.

2.  **Choose a Test Statistic**: Select an appropriate statistic to measure the observed effect.

A numerical function of the data that quantifies the strength of the observed effect, whose value determines the result of the test. Examples include the mean difference, proportion difference, or z-score.

3.  **Determine the Null Distribution:** Establish what the test statistic would look like if H₀ were true.

We have a test statistic and to say something about how likely this test statistic (or more extreme is) under the null hypothesis, we need the null distribution of the test statistic (that is the sampling distribution of the test statistic as if the null hypothesis were true). We then compared the observed value of the test statistic to that null distribution and asked ourselves how unusual it is in light of that distribution.

4.  **Compute the P-value:** Calculate the probability of obtaining a test statistic as extreme as the observed one under H₀.

The probability of obtaining a result as extreme as the observed one if H₀ is true. A small P-value (typically \<0.05) suggests strong evidence against ($H_0$).

5.  **Make a Decision:**

In the approach you have been taught, we compare the P-value to a predefined significance level (\alpha) and conclude whether to reject $H_0$. Here we would like to emphasise that the p-value is a measure of evidence against $H_0$ - see below!

## One-Sided vs. Two-Sided Tests

Two-sided test: Tests for deviations in both directions. Example: "The average human body temperature is different from 37°C."

One-sided test: Tests for deviations in a single direction. Example: "Students who study more than an hour score higher."

## Decision Making in Hypothesis Testing

A small P-value constitutes evidence against $H_0$. But how small is small enough? Sometimes, we want to make a firm decision about whether we can believe that the observed pattern is real or not. This requires us to choose a threshold for P. This threshold is called the significance level and denoted by $\alpha$. If we obtain a P-value that is smaller than $\alpha$, we say that we have obtained a “statistically significant result” or that “$H_0$ is rejected”. If our P-value is larger than $\alpha$, we say that our result is “not significant” or that “$H_0$ is not rejected”. In most situations, researchers choose a significance level of $\alpha$ = 0.05, which roughly corresponds to the probability of obtaining five heads in a row when tossing a fair coin, not a very likely event! Different values for $\alpha$ are also sometimes used; the next most common significance level is $\alpha$ = 0.01.

Before we go further, we want to emphasize that there is nothing magic about a specific value of $\alpha$. This threshold is an arbitrary choice and should not be taken too seriously. There is not much difference between a P-value of 0.051 and 0.049. Both constitute about the same strength of evidence against $H_0$. Yet, when we apply $\alpha$ = 0.05, we would reach opposite conclusions in the two cases. It is always better to report the exact P-value rather than just state P $>$ 0.05 or P $<$ 0.05 or state that a result is “not significant” or “significant”. And it is particularly important not to imply that a “non-significant” result means that there is no effect (that would be saying $H_0$ is true when we might in fact have some evidence against it)!

Alas, dividing results into “significant” vs “not significant” is very entrenched in many fields and you will encounter these terms a lot. And used wisely, this distinction can have its merits. So we'll stick with it.
