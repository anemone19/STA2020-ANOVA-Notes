---
title: "Introduction"
---









So far, we have examined completely randomised designs where randomisation of experimental units to treatments was completely unrestricted. With complete randomisation, all other variables (the environment that we can never control completely) that might affect the response are, on average, equal in all treatment groups. This allows us to be confident that differences in group means are due to the treatments.

However, there is often important variation in additional variables that we are not directly interested in. If we can group our experimental units with respect to these variables to make them more similar, we achieve a more powerful design. This is the idea of blocking.

If blocks are used effectively, we can separate variability due to treatments, blocks, and errors, reducing unexplained variability. That is, variability between blocks can be estimated and removed from the residual error. Essentially, we compare treatments over more similar experimental units than in a completely randomised design. With reduced error variance, our test becomes more powerful.

Blocking is also useful when we want to demonstrate that treatment differences hold over a wider range of conditions. For example, in the social media multitasking example, the experiment was conducted on first year students. Strictly speaking, the results then only apply to first year students and extrapolation to students in different years of their degree is limited. Alternatively, we could choose students from first, second and third year (for example) and apply one replicate of each treatment within year. In this case, year of study would be the blocking factor.

More generally, we often want to show that our results hold for different species, age groups, or biological sexes. In such cases, we could use species, age, or sex as blocks. While blocks are typically used to control for variation in variables we are not directly interested in, sometimes these factors may also be of interest in their own right.

## Treatments vs. Blocks

When is a factor a treatment, and when is it a block?

A good way to distinguish between them is by asking whether we can manipulate the factor and randomly assign experimental units to its levels.

-   We generally cannot manipulate the age or sex of an individual, but we can manipulate, for example, the food they receive. So, age and sex are blocking factors, whereas food type is a treatment.

-   We can manipulate the level of social media multitasking, but we cannot manipulate the year of study of students. So, level of social media multitasking is a treatment, while year of study is a block.

Although we can always estimate differences between blocks, we need to be much more cautious when inferring causality from block-level differences or from any factor that we cannot randomise (as is the case in observational studies).

:::{.callout-warning collapse = true icon = false}

## Example of observational study

Suppose we are studying whether different music streaming platforms (e.g., Spotify, Apple Music, YouTube Music) influence a song's popularity. We cannot randomly assign a song to a particular streaming platform because artists typically release their music on multiple platforms simultaneously. However, platform choice is still the main factor of interest.

We would analyze differences in song popularity (e.g., number of streams, chart position) across platforms as we would for any treatment factor. However, we must be cautious when attributing differences solely to the platform itself because other factors could also play a role. For instance:

-   Artist popularity: A well-known artist might naturally attract more streams, regardless of the platform.
-   Marketing strategies: Some platforms might promote certain songs more aggressively.
-   Release timing: Songs released during peak listening hours or days may perform better.
-   Platform demographics: Different platforms cater to different audiences, which might influence engagement.

Since we cannot randomly assign songs to platforms, we cannot be certain that observed differences in popularity are only due to the platform. Instead, they may be influenced by a combination of these external factors. This is an observational study.

::::

Suppose we study whether different teaching methods (interactive vs. traditional) affect student performance, conducted in public and private schools.

-   Teaching method is the treatment (assigned to students).\
-   School type is a blocking factor (cannot be randomly assigned).

If private school students perform better, we cannot conclude school type caused the difference due to potential confounders such as socioeconomic background or teacher quality.

Even though we control for school type, observed differences may be due to these external factors, not just the school itself. We cannot be sure that the observed differences are really only due to school type.

Sometimes, however, blocking variables can also be randomised. Suppose a study is testing two medications (A vs. B) for blood pressure, experiments are conducted in two labs (Lab 1 & Lab 2).

-   Medication is the treatment (randomly assigned).\
-   Lab is a blocking factor (controls lab-related variability).

Patients could have been randomly assigned to labs, but if logistical constraints prevent this, lab is used as a block. Since we only care about medication effects, lab differences are treated as a nuisance variable. The real difference is interest. We are not interested block effects on the response, only treatment effects. Blocking factors are used to control for known sources of variation that might obscure the treatment effect.

## Choosing Blocking Factors

Any variable that might affect the response besides treatment factor should be considered for blocking. Common blocking factors include:

-   Geographic location: field, site, regions or cities that share similar economic conditions.
-   Time: experimental replication over different days or weeks. Blocking for economic cycles or seasonal effects.
-   Subject: person, plant, businesses, phenotype.
-   Demographic groups: age, gender, income or education level, consumer behavior segments.\
-   Equipment: container types, growth chambers.

For example, if we are testing the effectiveness of a new advertising campaign, it would be useful to block by city or region to control for differences in local economies, purchasing behavior, or media consumption. Similarly, if an experiment measures the impact of dynamic pricing on sales, it is a good practice to replicate the price changes across multiple days, blocking for daily or weekly variations in consumer spending habits. This way time accounts for these differences rather inflating the error variance.

Likewise, if we are studying the effect of sports training programs on player performance, and athletes train in different facilities with varying equipment, we could assign a block to each training center to ensure that facility-related differences are accounted for. This prevents training location from being mistaken as a treatment effect, allowing a clearer evaluation of the actual program’s impact.

The key takeaway is that reducing error variance increases the power of the experiment. Thoughtful blocking design helps achieve this by accounting for known sources of variation.

## Randomised Complete Block Design

There are a few different types of randomised block designs depending on the availability of experimental units and size of the blocks. Here we will consider the best case scenario, where blocks are big enough to contain an equal amount of experimental units such that *each treatment occcurs exactly once within a block*. If we have a single treatment factor with $a$ levels, then we have $a$ experimental units per block. This design is said to be *balanced*, each block is the same with respect to treatments. In balanced block designs, the treatment and block effects can be completely separated (are independent) . This greatly simplifies the interpretation of results.

As in CRD, randomisation is still a crucial component of the design. The difference is that now $a$ treatments are assigned randomly to the $a$ experimental units within a block, i.e. randomisation is not complete over ALL experimental units but restricted within each block. Within each block, the experimental units are equally likely to receive any of the $a$ treatments. You can see this as CRD within each block!

Let's see how we could randomise treatment within blocks using R. Imagine we had four treatments (A,B,C and D). We randomise the treatments to the units within one block like this:






::: {.cell}

```{.r .cell-code}
units <- 1:4
rbind(sample(units,4), rep(c("A","B","C","D")))
```

::: {.cell-output .cell-output-stdout}

```
     [,1] [,2] [,3] [,4]
[1,] "2"  "1"  "3"  "4" 
[2,] "A"  "B"  "C"  "D" 
```


:::
:::






The third unit receive treatment A, the second receives B and so on. We then repeat this for every block.

## The Pygmalion Effect

The **Pygmalion effect** is a psychological phenomenon that suggests when people are held to high expectations, they tend to perform better. This applies to, for example, teachers and students, managers and employees or coaches and athletes. It is named after a mythological king of Cyprus, Pygmalion, who fell in love with a sculpture he created of his ideal woman.

::: column-margin
This article explains the concept nicely and also briefly discusses the study we will use later. https://thedecisionlab.com/biases/the-pygmalion-effect
:::

Many experiments have found results to support this type of self-fulfilling prophecy. Typically, they involve putting someone in charge of a group of people, then privately telling the leader that say a few of these people are exceptional (these people were randomly selected though). Then, later the performance of the group is measured and if the Pygmalion effect is present, the individuals who were marked as exceptional should have performed better.

Back in 1990, one researcher in this field, noticed that experiments like these might involve something that is called interpersonal contrasts. When some individuals are singled out for high expectations, others might feel neglected. This could potentially skew the results by making the others look good even though it was just the rest that performed poorly. The researcher wanted to conduct an experiment to test the Pygmalion effect without interpersonal contrasts.

They achieved this by applying the high expectation to an entire group and not selected individuals within a group. Let's have a look the exact experiment!

::: {#warning-example1 .callout-warning icon="false"}
## Example: The Pygmalion Effect in Military Training

A study conducted by Eden (1990) examined whether raising leaders' expectations of their trainees would enhance performance, without creating interpersonal contrast effects.

A total of 10 army companies consisting of 2 platoons each were used in the study. Within each company, one randomly assigned platoon received the Pygmalion treatment, while the other two served as controls. The idea is that the assignment of the Pygmalion treatment to an entire platoon prevents interpersonal contrasts.

1.  **Pygmalion Group:** Platoon leaders were informed that their trainees had exceptionally high command potential based on pre-existing evaluations.\
2.  **Control Group:** Platoon leaders received no expectation-enhancing information.

Over the training period, leaders in both conditions met biweekly with a psychologist to reinforce expectations. At the end of the program, soldiers took multiple tests which measured their performance in four areas:

-   Theoretical specialty knowledge (taught by platoon leaders)\
-   Practical specialty skills (taught by platoon leaders)\
-   Physical fitness (assessed independently)\
-   Target shooting (assessed independently)
:::

::: column-margin
A platoon is a military unit typically consisting of 30 to 50 soldiers, led by a platoon leader (usually a lieutenant). Several platoons form a company, which is a larger military unit consisting of three to five platoons, commanded by a company leader (usually a captain).
:::

First things first! We need to determine the design so we can use the appropriate analysis. The researcher was interested in determining the effect of the Pygmalion effect on performance. This indicates to use that there is a single treatment factor and that it is whether or not the Pygmalion effect was applied (we'll call this the Pygmalion Treatment) and the response is some measure of performance. The text gives four possible responses! The four areas in which the performance was tested. We'll start with the first one as our response. So far we know:

::: column-margin
The name of the treatment factor is not always obvious. It is usually something that describes the collection of similar treatments created in response to some research hypothesis or what has been manipulated. In biological or ecological studies, it can be quite clear. For example, if we had treatments high, medium and low rainfall, "Rainfall" is the variable we manipulated.

Also, as before, I've modified the example slightly. In the original study, there three platoons per company with two serving as control and one company only had two. So we have simplified the design so that it is balanced.
:::

-   **Response Variable:** Theoretical specialty knowledge.
-   **Treatment Factor:** Pygmalion Treatment.
-   **Treatment Levels (Groups):** Control, Pygmalion
-   **Treatments:** Control, Pygmalion

Now, the treatments were randomly assigned to platoons within a company. This gives away two things, (1) the experimental unit is an entire platoon and (2) treatments were assigned randomly within a company, i.e. a block! They were not interested in the effect of company on performance but merely wanted to account for possible differences between platoons in companies. So here Company is a blocking variable and the 10 companies are the blocks. Finally, on what was the response measured? The soldiers! They are then the observational units. The paper doesn't state how many soldiers were in each platoon and it doesn't really matter since the scores have to be combine to have one measurement per experimental unit.

Here is the final summary of the design:

-   **Response Variable:** Theoretical specialty knowledge.
-   **Treatment Factor:** Pygmalion Treatment.
-   **Treatment Levels (Groups):** Control, Pygmalion
-   **Treatments:** Control, Experiment 1, Experiment 2\
-   **Experimental Unit:** Platoon (20)\
-   **Observational Unit:** Soldier\
-   **Replicates:** 10 platoons received each treatment\
-   **Randomisation:** To platoons within companies, i.e. restricted to within blocks.
-   **Design Type:** Randomised Complete Block Design (CRD)

You will typically have access to the data as well to help you identify some aspects of the design. There are two ways the data might be represented, in long format:






::: {.cell}
::: {.cell-output-display}

\begin{longtable}[t]{llr}
\toprule
Company & Treat & Score\\
\midrule
C1 & Pygmalion & 80.0\\
C1 & Control & 63.2\\
C2 & Pygmalion & 83.9\\
C2 & Control & 63.1\\
C3 & Pygmalion & 68.2\\
\addlinespace
C3 & Control & 76.2\\
C4 & Pygmalion & 76.5\\
C4 & Control & 59.5\\
C5 & Pygmalion & 87.8\\
C5 & Control & 73.9\\
\addlinespace
C6 & Pygmalion & 89.8\\
C6 & Control & 78.9\\
C7 & Pygmalion & 76.1\\
C7 & Control & 60.6\\
C8 & Pygmalion & 71.5\\
\addlinespace
C8 & Control & 67.8\\
C9 & Pygmalion & 69.5\\
C9 & Control & 72.3\\
C10 & Pygmalion & 83.7\\
C10 & Control & 63.7\\
\bottomrule
\end{longtable}


:::
:::






\vspace{5em}

or in wide format:






::: {.cell}
::: {.cell-output-display}

\begin{longtable}[t]{lrr}
\toprule
Company & Pygmalion & Control\\
\midrule
C1 & 80.0 & 63.2\\
C2 & 83.9 & 63.1\\
C3 & 68.2 & 76.2\\
C4 & 76.5 & 59.5\\
C5 & 87.8 & 73.9\\
\addlinespace
C6 & 89.8 & 78.9\\
C7 & 76.1 & 60.6\\
C8 & 71.5 & 67.8\\
C9 & 69.5 & 72.3\\
C10 & 83.7 & 63.7\\
\bottomrule
\end{longtable}


:::
:::






The **long format** represents each observation as a separate row, with treatments recorded in a single column. This format is useful for statistical modeling and visualization since it keeps data structured for comparisons across treatments. You might have noticed that so far all the data sets we have used when fitting models using `aov` have been in long format. You will struggle to fit the model with a data set in wide format!

The **wide format** organizes data so that each unit (e.g., a company) appears in a single row, with treatments as separate columns. This format is often preferred for paired comparisons and summary tables.

Both formats contain the same information but serve different purposes depending on the type of analysis being performed.
