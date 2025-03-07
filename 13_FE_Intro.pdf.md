## Introduction

So far, we have explored experiments with a **single treatment factor**. However, in many cases, analyzing factors one at a time does not fully explain the behavior of the response variable. This is particularly true when factors interact, meaning that the effect of one factor depends on the level or setting of another factor.

A factorial experiment involves more than one treatment factor, allowing us to study how factors interact. In a complete factorial experiment, every possible combination of factor levels is tested. The total number of treatments is the product of the number of levels for each factor. In other words, each treatment is a combination of one level from each factor.

## Factorial Structure vs. Experimental Design

It is important to note that a **factorial experiment is not a design by itself**—it is a treatment structure. The underlying design can be:

-   A Completely Randomized Design (CRD)
-   A Randomized Complete Block Design (RCBD)

In the social media multitasking example, suppose the researchers wanted to know whether the effect of social media multitasking on academic performance is mitigated by lecture format? We would ask:

> *Does the effect of social media multitasking on academic performance depend on lecture format?*

The experiment would still follow a Completely Randomized Design (CRD) but now with two treatment factors instead of one.

Similarly, if we extended the Pygmalion experiment to include an additional factor, we would have an RCBD with two treatment factors.

## Notation and Structure of Factorial Experiments

In general, if an experiment has two treatment factors with $a$ and $c$ levels, then there are $a \times c$ treatments. This is called an $a \times c$ factorial treatment structure.

To clarify the terminology:

-   A **treatment factor** has **different levels** (e.g., social media multitasking: *none, texting, Facebook*).
-   **Treatments** are the **combinations** of factor levels (e.g., *no multitasking + lecture format A*, *texting + lecture format B*).

In factorial experiments, the treatment factors are said to be *crossed*, meaning that all levels of one factor appear at all levels of the other factor.

## Randomisation in Factorial Experiments

Randomization in factorial experiments depends on the chosen design and is carried out similarly to single-factor experiments. In R, it is helpful to number or name the treatments systematically.

Suppose we have two factors:

-   Marketing Strategy (2 levels: $m_0, m_1$)
-   Product Promotion (2 levels: $p_0, p_1$)

This creates **four treatments**:

$m_0p_0$, $m_0p_1$, $m_1p_0$, $m_1p_1$

If we have 12 experimental units and no need for blocking, we conduct a Completely Randomized Design (CRD) as follows:






::: {.cell}

```{.r .cell-code}
treats <- c("m0p0", "m0p1", "m1p0", "m1p1")
treats <- rep(treats, each = 3)  # Repeat each treatment 3 times
treats 
```

::: {.cell-output .cell-output-stdout}

```
 [1] "m0p0" "m0p0" "m0p0" "m0p1" "m0p1" "m0p1" "m1p0" "m1p0" "m1p0" "m1p1"
[11] "m1p1" "m1p1"
```


:::

```{.r .cell-code}
r1 <- sample(treats)  # Randomly assign treatments

cbind(1:12, r1)  # Display the assignments
```

::: {.cell-output .cell-output-stdout}

```
           r1    
 [1,] "1"  "m0p1"
 [2,] "2"  "m1p0"
 [3,] "3"  "m0p0"
 [4,] "4"  "m0p0"
 [5,] "5"  "m0p0"
 [6,] "6"  "m1p1"
 [7,] "7"  "m0p1"
 [8,] "8"  "m1p1"
 [9,] "9"  "m1p1"
[10,] "10" "m1p0"
[11,] "11" "m1p0"
[12,] "12" "m0p1"
```


:::
:::






This code assigns treatments randomly and prints the experimental unit number alongside its assigned treatment. If we had blocking, we would repeat the randomization separately for each block.

## Is comprehension affect by playback speed and lecture modality?

In keeping with the theme of students, learning and teaching. Have you ever wondered whether playback speed affects your comprehension of a lecture? Or whether your comprehension is better with audio-only lectures such as podcast versus recorded lectures with visuals? What about if you listen to a podcast at double speed versus a recorded lecture at double speed, is there difference in comprehension? to answer this question, researchers from the University of California conducted a $2\times2$ factorial experiment.

::: {#warning-example1 .callout-warning icon="false"}
## Lecture modality and playback speed

@chen2024effect conducted an experiment to find out whether visual information improves comprehension when lectures are played at faster speeds. Specifically, they wanted to investigate the effect of *lecture modality* (audio-only or audio-visual) and *playback speed* (1x or 2x) on comprehension of students and whether these factors interact. We can summarise the research questions as follows:

1.  Does lecture modality have an effect on comprehension?
2.  Does playback speed have an effect on comprehension?
3.  Is there an interaction effect of modality and playback speed on comprehension?

A total of 200 undergraduate students were randomly assigned to one of four groups:

1.  Audio-only at normal speed (1x)
2.  Audio-visual (with slides) at normal speed (1x)
3.  Audio-only at double speed (2x)
4.  Audio-visual (with slides) at double speed (2x)

The researchers chose two lectures: one about about real estate appraisals and another bout the history of the Roman Empire. The lectures were either presented as audio-visual clips which consisted of presentation slides and instructor images, and no subtitles or captions were provided. All the graphics (maps, figures) in the slides were static. For lectures presented as audio-only clips, only the instructor’s audio was made available.

Each student was presented both lectures in the modality and speed they were assigned. Afterwards, they completed a comprehension test consisting of 25 multiple choice questions on each topic. The average of the scores was taken as the final measure of comprehension.
:::

::: column-margin
We will be using the actual data collected but we will only be using a subset of the information they recorded. The authors conducted a different analysis which incorporates this extra information. We will not be doing this as the method they used is outside th scope of this course.
:::

Right! Let's begin with identifying the design. It should be clear that we have two treatment factors: *lecture modality* and *playback speed* each with the treatment levels. this means that we have a total of $2 \times 2 = 4$ treatments which are the combinations of the treatment levels. They investigated the effect of these factors on the comprehension of students - that means, comprehension is the response.

-   **Response Variable:** Comprehension\
-   **Treatment Factors:** Lecture modality and playback speed\
-   **Treatment Levels:** Lecture modality: Audio-only or Audio-visual; Playback speed: 1x or 2x\
-   **Treatments:** Audio-only at normal speed (1x); Audio-visual at normal speed (1x); Audio-only at double speed (2x); Audio-visual at double speed (2x)

Each student was assigned to one the treatments indicating that students were the experimental units. The response was also measured on each student, they are the observational units as well. Therefore, since we had 200 students and 4 treatment groups, there was 50 students per group, the experiment had 50 replicates.

-   **Experimental Unit:** Student (200)\
-   **Observational Unit:** Student (200)\
-   **Replicates:** 50 students per group\

Lastly, we need to determine how randomisation was conducted. There is no indication of any blocking and treatments were randomised to the whole group of experimental units. So this is a Completely Randomised Design, specifically it is a $2\times2$ factorial CRD.

-   **Design Type:** $2\times2$ factorial Completely Randomized Design (CRD)

Before we do any further analysis, we need to talk a bit about effects!
