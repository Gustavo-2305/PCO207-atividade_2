library(tidyverse)

#ler e armazenar os arquivos .csv como tabelas
df_info <- read_csv("dados/studentInfo.csv") #demografia do aluno
df_registration <- read_csv("dados/studentRegistration.csv") #dias de matrícula e evasão
df_assessment <- read_csv("dados/studentAssessment.csv") #resultados nas provas
df_vle <- read_csv("dados/studentVle.csv") #log de cliques no Ambiente Virtual

#agrupando os cliques do vle, para o total de cliques do aluno por disciplina
#vle: virtual learning envirooment
df_vle_grouped <- df_vle %>%
  group_by(id_student, code_module, code_presentation) %>%
  summarise(total_clicks = sum(sum_click, na.rm = TRUE), .groups = 'drop')
#%>%: passa o resultado à sua esquerda e como o primeiro argumento para a função que está à direita
#sum_click: coluna em df_vle, número de cliques em um dia, por estudante e modulo
#na.rm = TRUE: ignora células vazias
#.groups = 'drop': destrói agrupamentos internos

#agrupando as notas, para cada aluno, uma nota média por curso
df_assessment_grouped <- df_assessment %>%
  group_by(id_student) %>%
  summarize(avg_grade = mean(as.numeric(score), na.rm = TRUE), .groups = 'drop')
#%>%: passa o resultado à sua esquerda e como o primeiro argumento para a função que está à direita
#na.rm = TRUE: ignora células vazias
#.groups = 'drop': destrói agrupamentos internos

#cruzamento de tabelas
df_oulad <- df_info %>%
  left_join(df_registration, by = c("id_student", "code_module", "code_presentation")) %>%
  left_join(df_vle_grouped, by = c("id_student", "code_module", "code_presentation")) %>%
  left_join(df_assessment_grouped, by = "id_student") %>%

#%>%: passa o resultado à sua esquerda e como o primeiro argumento para a função que está à direita
#Iniciamos com a tabela principal df_info (que tem 1 linha por aluno em cada módulo).
#left_join: "cola" novas colunas à tabela principal, buscando as informações nas tabelas secundárias com base nas chaves em comum (by = ...).

#limpeza e categorização
  mutate(
    total_clicks = replace_na(total_clicks, 0),
    late_registration = ifelse(as.numeric(date_registration) > 0, "Y", "N"),
    gender = as.factor(gender),
    region = as.factor(region),
    highest_education = factor(highest_education, levels = c(
      "No Formal quals", "Lower Than A Level", "A Level or Equivalent", 
      "HE Qualification", "Post Graduate Qualification"
    )),
    final_result = factor(final_result, levels = c("Withdrawn", "Fail", "Pass", "Distinction"))
  )
#mutate(...): Modifica colunas existentes ou cria novas.

#inspeção e exportação
glimpse(df_oulad)
write_csv(df_oulad, "dados/df_oulad.csv")

#GRAFICO APENAS PARA TESTE - PODE APAGAR TUDO A PARTIR DAQUI
df_plot <- df_oulad %>% filter(!is.na(final_result))

my_plot <- ggplot(df_plot, aes(x = final_result, y = total_clicks, fill = final_result)) +
  geom_boxplot(alpha = 0.7, outlier.alpha = 0.2, outlier.size = 1) +
  # Usamos a escala logarítmica porque a diferença de cliques é colossal
  scale_y_log10() + 
  # Paleta de cores amigável
  scale_fill_brewer(palette = "Set1") +
  labs(
    title = "O esforço compensa? Engajamento no VLE vs. Resultado Final",
    subtitle = "Distribuição do total de cliques por status do aluno",
    x = "Status Final do Aluno",
    y = "Total de Cliques (escala logarítmica)"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 14)
  )

print(my_plot)