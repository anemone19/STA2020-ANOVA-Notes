# Load necessary library
library(dplyr)

# Set parameters
set.seed(123)
pop.mean <- 10
treatment.effects <- c(2, 4, 6)  # Effects for 3 treatments
block.effects <- c(3, 2, 1)  # Effects for 3 blocks

# Generate full factorial design
treatments <- rep(1:3, each = 3)  # 3 treatments
blocks <- rep(1:3, times = 3)  # 3 blocks

# ---- Additive Model ----
interaction.effects_additive <- matrix(c(
  0, 0, 0,  
  0, 0, 0,  
  0, 0, 0   
), nrow = 3, byrow = TRUE)

# Generate observed scores (Additive)
score_additive <- pop.mean + 
  treatment.effects[treatments] + 
  block.effects[blocks] + 
  interaction.effects_additive[cbind(blocks, treatments)]

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
