library(ggplot2)

font_add_google("Roboto", "roboto")
showtext_auto()

plot_clicks <- function(df_oulad) {
  # gera o gráfico
  my_plot = ggplot(data = df_oulad, aes(x = total_clicks, y = avg_grade)) +
    geom_point(color = "steelblue", alpha = 0.02) +
    scale_x_continuous(
      breaks = seq(0, 10000, by = 2000),
      expand = expansion(mult = c(0, 0.05)),
      limits = c(0, 10000)
    ) +
    scale_y_continuous(
      breaks = seq(0, 100, by = 10),
      expand = expansion(mult = c(0, 0.05)),
      limits = c(0, 100)
    ) +
    labs(
      # title = "Engajamento x Notas",
      x = "Total de Cliques",
      y = "Nota Média"
    ) +
    theme_minimal(base_family = "roboto") +
    theme(
      panel.grid = element_blank(),
      # plot.title = element_text(color = "#1a505c"),
      axis.text = element_text(color = "black"),
      axis.title = element_text(color = "black"),
      axis.ticks = element_line(color = "black"),
      axis.line = element_line(color = "black", arrow = arrow(length = unit(0.2, "cm"), type = "closed"))
    )
  
  return(my_plot)
}