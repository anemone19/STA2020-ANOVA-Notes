# Load necessary library
library(dplyr)

# Set parameters
set.seed(123)
pop.mean <- 95
treatment.effects <- c(6, 2, 6)  # Effects for 3 treatments
block.effects <- c(3, 2, 1, 2,1,3)  # Effects for 3 blocks

# Generate full factorial design
treatments <- rep(1:3, each = 6)  # 3 treatments
blocks <- rep(1:6, times = 3)  # 3 blocks

# ---- Additive Model ----
interaction.effects_additive <- matrix(c(
  0, 0.5, 0,  
  0.4, 0, 1.25,  
  0.1, 1, 0,  
  0, 0, 0.25,
  1, 0, 0.8,
  0, 0.6, 0
), nrow = 6, byrow = TRUE)

# Generate observed scores (Additive)
score_additive <- pop.mean + 
  treatment.effects[treatments] + 
  block.effects[blocks] + 
  interaction.effects_additive[cbind(blocks, treatments)]

add_data <- data.frame(Treat = treatments, Blocks = blocks, Response = score_additive)
interaction.plot(add_data$Treat, add_data$Blocks, add_data$Response, lty = 1,  # Use solid lines for better visibility
                 col = rainbow(length(unique(add_data$Blocks))),  # Use colours 
                 lwd = 2,  # Increase line width
                 pch = 19, # Use filled circle points
                 cex = 1.2,  # Increase point size
                 xlab = "Treatment", 
                 ylab = "Mean Response", 
                 main = "Interaction Plot: Response by Treatment and Block",
                 legend = TRUE,  # Ensure the legend is displayed
                 trace.label = "Block")

color_data <- add_data %>% rename(Color = Treat, Area = Blocks, Texture = Response)
color_data$Color <- factor(color_data$Color, labels = c("Red", "Black", "Blue"))
color_data$Area <- factor(color_data$Area, labels = c("A", "B", "C", "D", "E", "F"))
write.csv(color_data, "color_data.csv", row.names = F)

# ---- Non-Additive Model ----
interaction.effects_nonadditive <- matrix(c(
  0, 0, 0,  
  -3, 0, -3,  
  0, 0, 0   
), nrow = 3, byrow = TRUE)

# Generate observed scores (Non-Additive)
score_nonadditive <- pop.mean + 
  treatment.effects[treatments] + 
  block.effects[blocks] + 
  interaction.effects_nonadditive[cbind(blocks, treatments)]

# Combine both datasets into a single data frame
rcbd_data <- data.frame(
  Treatment = factor(rep(treatments, 2)), 
  Block = factor(rep(blocks, 2)), 
  Score = c(score_additive, score_nonadditive),
  Model = rep(c("Additive Model", "Non-Additive Model"), each = length(score_additive))
)

ggplot(rcbd_data, aes(x = Treatment, y = Score, color = Block, group = Block)) +
  geom_point(size = 3) +
  geom_line(size = 1) +
  facet_wrap(~Model) +  # Facet the two models
  labs(title = "",
       x = "Treatment", y = "Response") +
  theme_bw()
