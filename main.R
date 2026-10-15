library(tidyverse)
source("grade.R")
source("final_vs_clicks.R")
source("clicks_vs_grade.R")
source("attempts_vs_approval.R")

par(ask = TRUE)

# importa e inspeciona o df_oulad 
df_oulad <- read_csv("dados/df_oulad.csv")
glimpse(df_oulad)

# gera e imprime o gráfico grade
print(plot_grade(df_oulad))

# gera e imprime o gráfico final_vs_clicks
print(plot_final(df_oulad))

# gera e imprime o gráfico registration_vs_final
print(plot_clicks(df_oulad))

# gera e imprime o gráfico attempts_vs_approval
print(plot_attempts(df_oulad))

