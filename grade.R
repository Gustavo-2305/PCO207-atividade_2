library(ggplot2)

plot_grade <- function(df_oulad) {
  ggplot(data = df_oulad, aes(x = avg_grade)) +
    geom_histogram(
      binwidth = 5,
      boundary = 0,
      fill = "lightgray",
      color = "black"
    ) +
    scale_x_continuous(
      breaks = seq(0, 100, by = 10),
      expand = expansion(mult = c(0, 0.05)),
      limits = c(0, 100)
    ) +
    scale_y_continuous(
      breaks = seq(0, 5000, by = 1000),
      expand = expansion(mult = c(0, 0.05)),
      limits = c(0, 5000)
    ) +
    labs (
      title = "Nota Média",
      x = "Nota Média",
      y = "Nº de Estudantes"
    ) +
    theme_minimal() +
    theme(
      panel.grid = element_blank(),
      axis.text = element_text(color = "black"),
      axis.title = element_text(color = "black"),
      axis.ticks = element_line(color = "black"),
      axis.line = element_line(color = "black", arrow = arrow(length = unit(0.2, "cm"), type = "closed"))
    )
}