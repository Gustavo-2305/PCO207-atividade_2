library(ggplot2)

font_add_google("Roboto", "roboto")
showtext_auto()

plot_final <- function(df_oulad) {
  # define a ordem lógica das categorias em final_result
    # df_oulad$final_result: acessa a coluna desejada
    # factor: avisa ao R que final_result é uma categoria com uma ordem específica
  df_oulad$final_result <- factor(df_oulad$final_result, 
                                  levels = c("Withdrawn", "Fail", "Pass", "Distinction"),
                                  labels = c("Desistente", "Reprovado", "Aprovado", "Distinção"))
  
  # gera o gráfico
  my_plot = ggplot(data = df_oulad, aes(x = final_result, y = total_clicks)) +
    geom_boxplot(fill = "lightgray", color = "black", outlier.shape = NA) +
    stat_summary(fun = median, geom = "crossbar", color = "steelblue", width = 0.75) + # linha mediana vermalha
    scale_y_continuous(
      breaks = seq(0, 10000, by = 2000),
      expand = expansion(mult = c(0, 0.05)),
      limits = c(0, 10000)
    ) +
    labs(
      # title = "Resultado Final x Engajamento",
      x = "Resultado Final",
      y = "Total de Cliques"
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