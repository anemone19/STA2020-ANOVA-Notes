library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("ANOVA Simulation: Within & Between Group Variability"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("within_var", "Within-group variability:", min = 1, max = 20, value = 5),
      sliderInput("between_var", "Between-group variability:", min = 0, max = 20, value = 5),
      numericInput("n", "Sample size per group:", 30, min = 5, max = 100, step = 1),
      actionButton("simulate", "Resimulate Data")
    ),
    mainPanel(
      fluidRow(
        column(6, tableOutput("desc_stats")),
        column(6, verbatimTextOutput("anova_table"))
      ),
      plotOutput("boxplot"),
      plotOutput("f_dist")
    )
  )
)

server <- function(input, output) {
  generate_data <- reactive({
    input$simulate  # Re-run on button press
    isolate({
      set.seed(123)
      
      group_means <- c(50, 50 + input$between_var, 50 - input$between_var)
      
      data <- data.frame(
        group = rep(c("A", "B", "C"), each = input$n),
        value = c(
          rnorm(input$n, mean = group_means[1], sd = input$within_var),
          rnorm(input$n, mean = group_means[2], sd = input$within_var),
          rnorm(input$n, mean = group_means[3], sd = input$within_var)
        )
      )
      return(data)
    })
  })
  
  output$desc_stats <- renderTable({
    data <- generate_data()
    summary_stats <- aggregate(value ~ group, data, function(x) c(mean = mean(x), sd = sd(x)))
    do.call(data.frame, summary_stats)
  })
  
  output$boxplot <- renderPlot({
    data <- generate_data()
    boxplot(value ~ group, data = data, main = "Boxplot of Simulated Groups", col = c("skyblue", "lightgreen", "salmon"))
  })
  
  output$anova_table <- renderPrint({
    data <- generate_data()
    anova_result <- aov(value ~ group, data = data)
    print(summary(anova_result))
  })
  
  output$f_dist <- renderPlot({
    data <- generate_data()
    anova_result <- aov(value ~ group, data = data)
    anova_summary <- summary(anova_result)
    f_value <- anova_summary[[1]]$`F value`[1]
    p_value <- anova_summary[[1]]$`Pr(>F)`[1]
    df1 <- anova_summary[[1]]$Df[1]
    df2 <- anova_summary[[1]]$Df[2]
    
    x_vals <- seq(0, 100, length.out = 100)
    y_vals <- df(x_vals, df1, df2)
    
    ggplot(data.frame(x = x_vals, y = y_vals), aes(x, y)) +
      geom_line() +
      geom_vline(xintercept = f_value, color = "red", linetype = "dashed") +
      geom_area(data = subset(data.frame(x = x_vals, y = y_vals), x >= f_value), aes(x, y), fill = "red", alpha = 0.5) +
      labs(title = "F Distribution with P-Value Highlighted", x = "F Value", y = "Density")
  })
}

shinyApp(ui = ui, server = server)
