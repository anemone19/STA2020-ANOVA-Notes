

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




mod_output_data <- mod_output_data %>% select(Participant.ID, Condition, Speed, Content.Type, Accuracy)
write.csv(mod_output_data, file ="Exp2DataPlayback.csv", row.names = F)
