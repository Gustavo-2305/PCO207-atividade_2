library(tidyverse)
source("clicks_vs_final.R")

# importa e inspeciona o df_oulad 
df_oulad <- read_csv("dados/df_oulad.csv")
glimpse(df_oulad)

# gera e imprime o gráfico clicks_vs_grade
clicks <- plot_clicks(df_oulad)
print(clicks)

