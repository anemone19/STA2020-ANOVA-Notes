# The three R's of experimental design {.unnumbered}

**Experimental Design** is a detailed procedure for grouping, if blocking is necessary, experimental units and for how treatments are assigned to the experimental units. There are three fundamental principles, known as the 'three R's of experimental design' which are at the core of a good experiment. The following section might feel a bit repetitive, but these concepts cannot be emphasised enough.

## Replication

Let's define it again: replication is when each treatment is applied to several experimental units. This ensures that the variation between two or more units receiving the same treatment can be estimated and valid comparisons can be made between treatments. In other words, replication allows us to separate variation due to differences between treatments from variation within treatments. For true replication, each treatment should be **independently** applied to several experimental units. If this is not the case, treatment effects become confounded with other factors.

Confounding means that is not possible to separate the effects of two (or more) factors on the response, i.e. it is not possible to say which of the two factors is responsible for any changes in the response. This is what happened in the Example 1 when groups are the experimental units. With only one replicate per treatment, the effect of therapy is confounded with the experimental unit or the effect of group on test anxiety. The reason why this is a problem is that any difference between the treatments could be due to any differences between the groups and not just the number of therapy hours. The same would be true if we only had one student per group. Why? Take a moment to think about this.

Consider the first row of the data from Example 1. It looks like the student in group 2 scored the highest, followed by group 3 and then group 1. So does longer therapy sessions lead to higher test anxiety? Likely not! With only one student per treatment, we are not able to say that any differences in the response are due to the treatments. It could be due to any differences between the individuals. Maybe the student in group 3 tends to score higher on anxiety tests regardless of the treatment, or perhaps the student in group 1 was unusually calm that day. Without replication, these individual differences could mask (or mimic) the true effects of the treatments.

By replicating the treatments across multiple students, we can average out these individual differences and gain a clearer picture of whether therapy duration truly impacts test anxiety. With five students per group, we might observe that group 1 consistently scores lower than group 3. This consistency would provide stronger evidence that the treatments, and not just individual variation, are responsible for the observed differences. So by replication, we can compare within treatment variation to variation between treatments.

| Treatment 1 | Treatment 2 | Treatment 3 |
|:-----------:|:-----------:|:-----------:|
|     48      |     55      |     51      |
|     50      |     52      |     52      |
|     53      |     53      |     50      |
|     52      |     55      |     53      |
|     50      |     53      |     50      |

<!-- ::: {.callout-tip icon="false"} -->
<!-- ## Example 3.1 -->

<!-- Maybe the co2 uptake data? -->
<!-- ::: -->

## Randomisation

Randomisation refers to the process of randomly assigning treatments to experimental units such that each experimental unit has equal chance of receiving a specific treatment. Randomisation ensures that:

1.  There is no bias on the part of the experimenter, either conscious or unconscious, when assigning treatments to experimental units.

2.  No experimental unit is favored to receive a particular treatment.

3.  Possible differences between units are equally distributed among treatments. If there are clear differences between units, then blocking should be performed and randomisation occurs within blocks. We'll talk more about this when we encounter Randomised Block Designs. 

4.  We can assume independence between observations.

Randomisation is not haphazard. In statistics (and here in the context of experimental design), randomisation has a specific meaning: namely that each experimental unit has the same chance of being allocated any of the treatments. This can be done using random number generators such as with software packages, dice or drawing number from a hat (provided the number have been shuffled adequately and have equal chance to be picked).

Let's have a look at randomisation in R. Suppose we have 4 treatments (`A`, `B`, `C`, and `D`) and 32 experimental units. There are no differences between the units, so we don't have to block, and we can equally split the units across the treatments, which means we have 8 units per treatment, i.e., 8 replicates. In R, we first create a long vector of 8 `A`s, 8 `B`s, 8 `C`s, and 8 `D`s called `all.treat`. Then shuffle the vector to obtain a randomisation using the function `sample`.






::: {.cell}

```{.r .cell-code}
# repeat the vector A, B, C, D 8 times 
all.treats <- rep(c("A","B","C","D"), times = 8)

# permutation of all.treats (sample withut replacement)
rand1 <- sample(all.treats)

# example output
rand1
```

::: {.cell-output .cell-output-stdout}

```
 [1] "C" "D" "A" "B" "B" "C" "A" "B" "A" "D" "C" "C" "A" "D" "D" "C" "C" "B" "D"
[20] "C" "C" "B" "B" "A" "B" "D" "D" "B" "A" "A" "A" "D"
```


:::
:::






Experimental unit 1 recipes the first treatment that appears as the first element in the shuffled vector, experimental unit 2 receives the second and so on.

## Reduction of Unexplained Variation (Blocking)

Unexplained variation (or experimental error variance or within treatment variance) is largely due to inherent differences between experimental units. The larger this unexplained variation, the more difficult it becomes to detect treatment differences (a treatment signal). To minimise experimental error variance we can control extraneous factors (i.e. keeping all else constant) and by choosing homogeneous experimental units. Otherwise, we can block experimental units to reduce the variation.

Blocking variables are nuisance factors that might affect your response or introduce systematic variation in the response and we are typically, not interested in these. Often, they are factors that cannot be randomised, e.g. biological sex of a person, time of day, location of a warehouse etc. We control the effect of such variables on the response by blocking for them so that we can investigate the possible effect of a variable that we are interested in. Usually, in a complete block experiment, there are as many experimental units per block as there are treatments, so that each treatment is applied once in every block. Treatments are randomized to the experimental units in the blocks. We can then compare the effects of treatments on similar experimental units, and we can estimate the variation induced in the response due to the differences between blocks. This variation due to blocks can then be removed from the unexplained variation.

Blocking also offers the opportunity to test treatments over a wider range of conditions, e.g. if I only use people of one age in my experiment (say students) I cannot generalize my results to older people. However, if i use different age blocks I will be able to tell whether the treatments have similar effects in all age groups or not.

Lastly, if blocking is not feasible, randomization will ensure that at least treatments and nuisance factors are not confounded.

> "Block what you can, randomize what you cannot."
>
> — Box, Hunter & Hunter (1978)
