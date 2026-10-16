library(tidyverse)
source("grade.R")
source("final_vs_clicks.R")
source("clicks_vs_grade.R")
source("attempts_vs_approval.R")

par(ask = FALSE)

# importa e trata o df_oulad 
df_oulad <- read_csv("dados/df_oulad.csv") %>%
  mutate(
    gender = as.factor(gender),
    region = as.factor(region),
    highest_education = as.factor(highest_education),
    imd_band = as.factor(imd_band),
    age_band = as.factor(age_band),
    disability = as.factor(disability),
    final_result = as.factor(final_result)
  )
glimpse(df_oulad)

# define a resolução para o gráficos
resolucao_dpi <- 100
showtext_opts(dpi = resolucao_dpi)

# gera o gráfico grade
ggsave(
  filename = "plot/grade.png",
  plot = plot_grade(df_oulad),
  width = 6,
  height = 4.5,
  units = "in",
  dpi = resolucao_dpi,
  bg = "white"
)
print(".")

# gera e imprime o gráfico final_vs_clicks
ggsave(
  filename = "plot/final_vs_clicks.png",
  plot = plot_final(df_oulad),
  width = 6,
  height = 4.5,
  units = "in",
  dpi = resolucao_dpi,
  bg = "white"
)
print(".")

# gera e imprime o gráfico clicks_vs_grade
ggsave(
  filename = "plot/clicks_vs_grade.png",
  plot = plot_clicks(df_oulad),
  width = 6,
  height = 4.5,
  units = "in",
  dpi = resolucao_dpi,
  bg = "white"
)
print(".")

# gera e imprime o gráfico attempts_vs_approval
ggsave(
  filename = "plot/attempts_vs_approval.png",
  plot = plot_attempts(df_oulad),
  width = 6,
  height = 4.5,
  units = "in",
  dpi = resolucao_dpi,
  bg = "white"
)
print(".")
print("done")
