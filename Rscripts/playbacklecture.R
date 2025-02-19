

library(tidyverse)

data <- read.csv("Ex2 Data.csv")

mod_data <- data %>% 
  select(Participant.ID, Condition, Speed, 
         Content.Type, Appraisals.Accuracy, 
         Roman.Empire.Accuracy, Avg.Accuracy) %>%
  mutate(Avg.Accuracy = Avg.Accuracy*100,
         Appraisals.Accuracy = Appraisals.Accuracy*100,
         Roman.Empire.Accuracy = Roman.Empire.Accuracy*100)

output_data <- read.csv("Ex2 Output.csv")

mod_output_data <- output_data %>% 
  group_by(Participant.ID) %>% 
  mutate(Accuracy = mean(Accuracy)*100) %>%  
  distinct(Participant.ID, .keep_all = TRUE) %>%  
  ungroup()

mod_output_data$Speed <- factor(mod_output_data$Speed)
mod_output_data$Content.Type <- factor(mod_output_data$Content.Type)
mod_output_data$Condition <- factor(mod_output_data$Condition,
                             labels = c("1x Audio", "2x Audio-Visual", "2x Audio", "1x Audio-Visual"))

par(mar = c(8, 4, 4, 2))  # Increase bottom margin
boxplot(Accuracy ~ Content.Type * Speed, data = mod_output_data, 
        ylab = "", main = "", las = 1)

stripchart(Accuracy ~ Content.Type * Speed, data = mod_output_data, vertical = TRUE, add = TRUE, method = "jitter")
sort(tapply(mod_output_data$Accuracy, mod_output_data$Condition, sd))
qqnorm(mod_output_data$Accuracy, pty = 4, col ="blue")
qqline(mod_output_data$Accuracy, col = "red")
dotchart(output_data$Accuracy, ylab = "Order of observation", xlab ="Post treatment test score")

mod1 <- aov(Accuracy ~ Speed + Content.Type + Content.Type:Speed, data = mod_output_data)
mod3 <- aov(Accuracy ~ Content.Type * Speed, data = mod_output_data)

model.tables(mod1, type = "effects")
model.tables(mod2, type = "effects")
model.tables(mod3, type = "effects")

summary(mod1)

library(emmeans)
reg.mod <- lm(Accuracy ~ Content.Type * Speed, data = mod_output_data)
summary(reg.mod)


mod1 <- aov(Accuracy ~ Content.Type * Speed, data = mod_output_data)
summary(mod1)


emmeans(reg.mod,~Content.Type * Speed)
emmeans(reg.mod,~Content.Type | Speed)

# Compute estimated marginal means
emm <- emmeans(reg.mod, ~ Content.Type * Speed)

# Contrast: Comparing Speed 1 vs Speed 2 across both Content Types
contrast(emm, list(Speed_Effect = c(-1, -1, 1, 1)))

contrast(emm, "pairwise", by = "Content.Type")
emm <- emmeans(model_reg, ~ Speed * Content.Type)

contrast(emm, interaction = "pairwise")



t <-contrast(emm, list(ContentType_Effect = c(1, -1, 1, -1)/2), by = NULL, side ="<")



mod_output_data <- mod_output_data %>% select(Participant.ID, Condition, Speed, Content.Type, Accuracy)
write.csv(mod_output_data, file ="Exp2DataPlayback.csv", row.names = F)


## Interaction plot 


AV1_response <- mod_output_data$Accuracy[mod_output_data$Speed =="1" & mod_output_data$Content.Type == "Audio-Visual"]
AV1_mean <- mean(AV1_response)

AV2_response <- mod_output_data$Accuracy[mod_output_data$Speed =="2" & mod_output_data$Content.Type == "Audio-Visual"]
AV2_mean <- mean(AV2_response)


AO1_response <- mod_output_data$Accuracy[mod_output_data$Speed =="1" & mod_output_data$Content.Type == "Audio-Only"]
AO1_mean <- mean(AO1_response)

AO2_response <- mod_output_data$Accuracy[mod_output_data$Speed =="2" & mod_output_data$Content.Type == "Audio-Only"]
AO2_mean <- mean(AO2_response)



int_data <- data.frame(ContentType = rep(c("Audio-Visual","Audio-Only"), each = 2),
                       Speed = rep(c("1","2"), times = 2),
                       MeanResponse = c(AV1_mean, AV2_mean,AO1_mean,AO2_mean))


# Compute the main effect of Speed (average across Content Types)
speed_means <- data.frame(
  Speed = c("1", "2"),
  MeanResponse = c(mean(c(AV1_mean, AO1_mean)), mean(c(AV2_mean, AO2_mean)))
)


ggplot(int_data, aes(x = Speed, y = MeanResponse, group = ContentType, colour = ContentType)) +
  geom_point(size = 3)+
  geom_line(size = 1) + 
  labs(title = "Interaction Plot: Speed vs Content Type",
     x = "Speed",
     y = "Mean Response") +
  theme_minimal()

# Create the ggplot with interaction lines
ggplot(int_data, aes(x = Speed, y = MeanResponse, colour = ContentType, group = ContentType)) +
  geom_point(size = 3) +     # Add points for each Content Type
  geom_line(size = 1) +      # Connect points with lines
  labs(title = "Interaction Plot: Speed vs Content Type",
       x = "Speed",
       y = "Mean Response") +
  theme_minimal()


interaction.plot(x.factor = int_data$Speed, #x-axis variable
                 trace.factor = int_data$ContentType, #variable for lines
                 response = int_data$MeanResponse, #y-axis variable
                 fun = mean, #metric to plot
                 ylab = "Counts",
                 xlab = "Seasons",
                 col = c("red", "blue"),
                 lty = 1, #line type
                 lwd = 2, #line width
                 trace.label = "Species")






```{r}


AV1 <- data$Accuracy[data$Condition == "1x Audio-Visual"] 

# if we didn't have a column with the combined levels we could use:  
# mod_output_data$Accuracy[mod_output_data$Speed =="1" & mod_output_data$Content.Type == "Audio-Visual"]

AV1 

length(AV1)

```

We have 50 reponse values for each treatment - remember we need replication per treatment to be able to estimate the error variance and interaction term. Now, in the interaction plots you've seen before there was only one value per treatment. This is because it was showing the mean response for each treatment. Let's subset and take the mean for the remaining treatments. 

```{r}

AV1_mean <- mean(AV1)

AV2 <- data$Accuracy[data$Condition == "2x Audio-Visual"] 
AV2_mean <- mean(AV2)

AO1 <- data$Accuracy[data$Condition == "1x Audio"] 
AO1_mean <- mean(AO1)

AO2 <- data$Accuracy[data$Condition == "2x Audio"] 
AO2_mean <- mean(AO2)

c(AV1_mean,AV2_mean,AO1_mean,AO2_mean) # output together

```

Great! Now we want to plot them these means. First, we put them together into a dataframe. 

```{r}

int_data <- data.frame(ContentType = rep(c("Audio-Visual","Audio-Only"), each = 2),
                       Speed = rep(c("1","2"), times = 2),
                       MeanResponse = c(AV1_mean, AV2_mean,AO1_mean,AO2_mean))

```


Second, we need to decide which factor will be on the x-axis, let's do Speed. Below, I use a new package called `ggplot2` to visualise the data. It creates nicer looking plots and is more intutiive in my opinion. If you want to see how to use base R to plot this, see the code at the end of this section. 



