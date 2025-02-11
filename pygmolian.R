library(Sleuth3)
library(tidyverse)

data("case1302")

pygmalion_data <- case1302 %>%
  group_by(Company) %>%
  mutate(Control_Index = row_number()) %>%
  filter(!(Treat == "Control" & Control_Index == 3)) %>%
  select(-Control_Index)  

write.csv(pygmalion_data, file = "pygmalion_data.csv", row.names = F)


pygmalion_data_wide <- reshape(case1302, 
                     idvar = "Company", 
                     timevar = "Treat", 
                     direction = "wide")

pyg_model <- aov(Score ~ Treat + Company, data = pyg_data)
summary(pyg_model)

model.tables(pyg_model, type = "effects", se = TRUE)
model.tables(pyg_model, type = "means", se = TRUE)


block   <- factor(rep(1:6, times = 3))
variety <- rep(c("Golden.rain", "Marvellous", "Victory"), each = 6)
yield   <- c(133.25, 113.25, 86.75, 108, 95.5, 90.25, 
             129.75, 121.25, 118.5, 95, 85.25, 109, 
             143, 87.25,  82.5, 91.5, 92, 89.5)
oat.variety <- data.frame(block, variety, yield)
xtabs(~ block + variety, data = oat.variety)
fit.oat.variety <- aov(yield ~ block + variety, data = oat.variety)
summary(fit.oat.variety)
model.tables(fit.oat.variety, type ="effects")

