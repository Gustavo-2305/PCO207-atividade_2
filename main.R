library(tidyverse)
source("clicks_vs_final.R")
source("grade.R")

par(ask = TRUE)

# importa e inspeciona o df_oulad 
df_oulad <- read_csv("dados/df_oulad.csv")
glimpse(df_oulad)

# gera e imprime o gráfico grade
print(plot_grade(df_oulad))

# gera e imprime o gráfico clicks_vs_final
print(plot_clicks(df_oulad))