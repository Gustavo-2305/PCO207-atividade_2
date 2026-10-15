library(ggplot2)
library(dplyr)

font_add_google("Roboto", "roboto")
showtext_auto()

plot_attempts <- function(df_oulad) {
  #prepara o df_auxiliary
  df_auxiliary <- df_oulad %>%
    group_by(num_of_prev_attempts) %>%
    summarise(
      total_students = n(),
      approved_students = sum(tolower(final_result) %in% c("pass", "distinction"), na.rm = TRUE),
      approval_percentage = (approved_students / total_students) * 100,
      .groups = "drop"
    )
  
  #gera o gráfico
  my_plot = ggplot(df_auxiliary, aes(x = factor(num_of_prev_attempts), y = approval_percentage)) +
    geom_col(fill = "lightgray", color = "black") +
    scale_y_continuous(
      breaks = seq(0, 100, by = 10),
      expand = expansion(mult = c(0, 0.05)),
      limits = c(0, 100)
    ) +
    labs(
      title = "Tentativas Anteriores x Taxa de Aprovação",
      x = "Tentativas Anteriores",
      y = "Taxa de Aprovação"
    ) +
    theme_minimal(base_family = "roboto") +
    theme(
      panel.grid = element_blank(),
      plot.title = element_text(color = "#1a505c"),
      axis.text = element_text(color = "black"),
      axis.title = element_text(color = "black"),
      axis.ticks = element_line(color = "black"),
      axis.line = element_line(color = "black", arrow = arrow(length = unit(0.2, "cm"), type = "closed"))
    )
  
  return(my_plot)
}