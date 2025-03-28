# Linear model & ANOVA






::: {.cell}

:::






## Linear model {.unnumbered}

We wish to compare $a$ treatments and have $N$ experimental units arranged in $b$ blocks each containing $a$ homogeneous experimental units: $N = ab$. The $a$ treatments are assigned to the units in the $j^{th}$ block at random. The design (blocking and treatment factors and the randomisation) determine the structural part of the model.

A linear model for the RBD is:

$$Y_{ij} = \mu + A_i + B_j  +e_{ij}$$

where,

$$
\begin{aligned}
    Y_{ij} &= \text{observation on treatment } i \text{ in block } j \\
    i &= 1, \dots, a \text{ and } j = 1, \dots, b \\
    \mu &= \text{general/overall mean} \\
    A_i &= \text{effect of the } i^{th} \text{ treatment} \\
    B_j &= \text{effect of the } j^{th} \text{ block} \\
    e_{ij} &= \text{random error with } e_{ij} \sim N(0, \sigma^2) \\
    \sum_{i=1}^{a} A_i &= \sum_{j=1}^{b} B_j = 0
\end{aligned}
$$

This model says that each observation is made up of an overall mean, a treatment effect, a block effect, and an error part. The block effect is interpreted in the same way as the treatment effect, it is the difference between block mean $j$ and the overall mean $\mu$.

It also says that these effects are additive. Additivity means that the effect of the $i^{th}$ treatment on the response ($A_i$) is the same regardless of the block in which the treatment is used. Similarly, the effect of the $j^{th}$ block is the same ($B_j$) regardless of the treatment. The additional constraint of $\sum_{j=1}^{b} \beta_j = 0$ follows the same logic as explained before.

Let's fit this model to the Pygmalion data. For the Pygmalion experiment, the researchers compared control to Pygmalion treatment so we have $a=2$ treatments. The number of blocks, $b$, was 10. In R, on the right-hand-side of the formula, we have the treatment factor + blocking factor. The code looks exactly the same as before, except we **add** the Company (blocking) variable.






::: {.cell}

```{.r .cell-code}
pyg_model <- aov(Score ~ Treat + Company, data = pyg_data)
```
:::






We can again extract the model estimates with `model.table`:






::: {.cell}

```{.r .cell-code}
model.tables(pyg_model, type = "means", se = TRUE)
```

::: {.cell-output .cell-output-stdout}

```
Tables of means
Grand mean
      
73.31 

 Treat 
Treat
  Control Pygmalion 
    67.92     78.70 

 Company 
Company
   C1   C10    C2    C3    C4    C5    C6    C7    C8    C9 
71.60 73.70 73.50 72.20 68.00 80.85 84.35 68.35 69.65 70.90 

Standard errors for differences of means
        Treat Company
        3.126   6.990
replic.    10       2
```


:::
:::






First we see the grand mean of 73.31 followed by the treatment means. Then, we have ten block means, these are the mean scores within each block. Lastly, we see the standard errors for the differences of means.

## Sums of squares and Analysis of variance {.unnumbered}

Now we have three sources of variability: differences between treatments, differences between blocks and experimental error. The total sum of squares can be split into three sums of squares: for treatments, blocks, and error respectively.

$$
SS_{total} = SS_A + SS_B + SSE
$$

with degrees of freedom

$$
(ab - 1) = (a - 1) + (b - 1) + (a - 1)(b - 1)
$$

The advantage of blocking becomes apparent here. If we had not blocked, i.e. used a completely randomised design, for example, the $SS_A$ (sums of squares for treatment) would be the same. However, in the completely randomised design, we would not be able to separate $SS_B$ from $SSE$ and the combined $SSE$ would therefore be larger.

When using a RBD, part of the unexplained variation is now explained and can be captured in the block sum of squares, $SS_B$. A small $SSE$ has the advantage of smaller standard errors, i.e. more precise estimates (for treatment effects and treatment means) and thus it is easier to detect differences between treatments.

::: column-margin
You can think of the SSE as the variability among experimental units that cannot be accounted for by blocks or treatments.
:::

The sums of squares are summarised in an ANOVA table.

| Source | SS | df | MS | F |
|---------------|---------------|---------------|---------------|---------------|
| Treatments A | $SS_A = b \sum_i (\bar{Y}_i - \bar{Y}_{..})^2$ | $(a - 1)$ | $\frac{SS_A}{(a-1)}$ | $\frac{MS_A}{MSE}$ |
| Blocks B | $SS_B = a \sum_j (\bar{Y}_j - \bar{Y}_{..})^2$ | $(b - 1)$ | $\frac{SS_B}{(b-1)}$ |  |
| Error | $SSE = \sum_{ij} (Y_{ij} - \bar{Y}_{i.} - \bar{Y}_{.j} + \bar{Y}_{..})^2$ | $(a - 1)(b - 1)$ | $\frac{SSE}{(a-1)(b-1)}$ |  |
| Total | $SS_{total} = \sum (Y_{ij} - \bar{Y}_{..})^2$ | $ab - 1$ |  |  |

Much of the table remains the same as in a one-way ANOVA, but now it includes an additional row for the blocking variable. The sum of squares for the blocking factor is calculated similarly to that of the treatment factor—by summing the squared deviations of observations within each block from the block's mean response. The residual sum of squares is also slightly different, but you don’t need to worry too much about that[^10_rcbd_model-1]. Since the total SS is simply the sum of the treatment, block, and residual SS, you can always compute SSE by subtraction.

[^10_rcbd_model-1]: You can easily get there by rearranging the model equation so that $e_{ij}$ is on the right-hand-side, replacing the effects with the difference in terms of means and simplifying.

From this ANOVA table, we can test the hypothesis of no differences between the treatment means as before.

$$H_0: \mu_! = \mu_2 = \ldots =\mu_a$$

Which is equivalent to testing:

$$
H_0 : \alpha_1 = \alpha_2 = \dots = \alpha_a = 0
$$

using the F-test which compares the mean square for treatments with the mean square for error:

$$
F = \frac{MS_A}{MSE} \sim F_{a-1, (a-1)(b-1)}
$$

Notice the degrees of freedom!

What does the ANOVA table look like for the Pygmalion data? Again, we use the `summary` function on the model object to obtain the table.






::: {.cell}

```{.r .cell-code}
summary(pyg_model)
```

::: {.cell-output .cell-output-stdout}

```
            Df Sum Sq Mean Sq F value  Pr(>F)   
Treat        1  581.0   581.0   11.89 0.00729 **
Company      9  510.2    56.7    1.16 0.41433   
Residuals    9  439.8    48.9                   
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```


:::
:::






Let's first look at the degrees of freedom:

-   We had $a \times b = 2 \times 10 = 20$ experimental units, so we should have $a \times b - 1$ total degrees of freedom.
-   The treatment degrees of freedom are $a-1 = 2-1 = 1$ and similarity, there are $b-1 = 10 -1=9$ degrees of freedom of the block effect.
-   That leaves $(a-1)(b-1) = 1 \times 9$ degrees of freedom for the error term.

It is always a good idea to check that the df's match with what you expected them to be. One serious error that happens easily is one of the factor is fitted as continuous covariate because the levels were labelled using numbers. Hence why we converted the categorical variables (Treat and Company) to factors.

The next column lists the sums of squares for the three components. The mean squares are calculated as $\frac{SS}{df}$, e.g. $\frac{581}{1} = 581$ for the treatment. The $F$-value for the treatment variable is the ratio of $MS_{treat}$ to the $MSE$. This is the same as in the one-way ANOVA. R then looks up the corresponding p-value, which is $0.00729$.

So we have an very small p-value which means that we have strong evidence against our null hypothesis of equal treatment means. We cannot conclude that the effects are equal to zero. There is evidence to suggest that at least one treatment resulted in a different mean score. Here, because we have two treatments, the results indicate that the data are not compatible with a null hypothesis of equal means. We make the following conclusion:

"There is evidence to suggest that the two treatment means are different ($F = 11.89$, $p = 0.0073$)."

If we had more than two treatment means as is usually the case, we would conclude:

"There is evidence to suggest that at least one treatment resulted in a different mean response, there is evidence for a treatment effect ($F = 11.89$, $p = 0.0073$)."

There are many different ways to say that there is a difference somewhere. For example:

-   One or more treatments had a mean response that differed from the others.
-   Not all treatment means are the same; at least one is significantly different.
-   The results indicate that not all treatment means are equal.

You get the idea! As long as it is clear that a 'significant' result indicates that there is a difference somewhere, we don't know where, but there is evidence for a treatment effect.

## What about the F-test for the blocking variable? {.unnumbered}

We see that the blocks accounted for a similar fraction of the sums of squares as the other two components (just over a third). If we did not block, this variation would be part of the SSE but then the error degrees of freedom would also be larger (the 9 degrees of freedom would be part of the error degrees of freedom). In fact, here, the blocking did not significantly reduce the unexplained variability, since the F-value is close to one. The variability explained by the blocks is close to what would be expected due to random noise.

Remember, we aren't particularity interested in formal inference about block effects (we knew or suspected that they were different) and we should always be careful about interpreting the F-test for the blocking variable (as blocks typically cannot be randomised to experimental units - see the previous chapter). We might, however, be interested in whether blocking increased the efficiency of the design by reducing the unexplained variation (SSE). There exists a more thorough method of assessing the relative efficiency of blocking - that is, relative to if a simpler design (i.e. CRD) was used instead[^10_rcbd_model-2]. Here, however, we focus on a simple and quick check of block efficiency using the F-ratio.

[^10_rcbd_model-2]: @kuehl2000design wrote a great textbook (freely available) that explains the relative efficiency check in detail.

We would like the block factor to explain a lot of variation. If the mean square of the blocking variable is larger than the error mean square we conclude that blocking was effective (compared to a CRD).

-   If $F > 1$ then blocking did reduce unexplained error variance.

-   If $F \approx 1$ then the blocks did not improve the power of the experiment and you would have been equally well off with a CRD.

-   If $F<1$ which happens rarely, it means that blocking did not account for much of the variability because experimental units within blocks are more heterogeneous than between blocks (or there are strong interactions between blocks and treatments). Blocks actually reduced the power of the experiment but this should really not happen if you choose your blocks sensibly.

If blocking was not efficient, we would still leave the block factor in the model (**design dictates analysis**), but we might decide not to use blocking in a similar experiment in the future because it didn't assist in reducing experimental error variance and only cost us degrees of freedom.

## Estimation {.unnumbered}

To obtain estimates for the treatment and block effects, we minimize the error sum of squares (method of least squares).

$$
SSE = \sum_i \sum_j (Y_{ij} - \mu - A_i - B_j)^2
$$

$Y_{ij} - \mu - \alpha_i - \beta_j$ is the observed value minus the expected value (the structural part of the model). This difference is just the error $e_{ij}$. If we minimise the error sum of squares we obtain the following estimates:

$$
\hat{\mu} = \bar{Y}_{..}
$$

$$
\hat{A_i} = \bar{Y}_{i.} - \bar{Y}_{..}, \quad i = 1 \dots a
$$

$$
\hat{B_j} = \bar{Y}_{.j} - \bar{Y}_{..}, \quad j = 1 \dots b
$$

To estimate the $i^{th}$ treatment effect we take the observed treatment mean minus the overall mean, similarly to obtain block effect estimates.
