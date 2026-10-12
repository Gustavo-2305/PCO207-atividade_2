# prepara um dataframe a partir dos dados brutos do OULAD
library(tidyverse)

# le e armazena os arquivos .csv como tabelas
df_info <- read_csv("dados/studentInfo.csv") # demografia do aluno
df_registration <- read_csv("dados/studentRegistration.csv") # dias de matrícula e evasão
df_assessment <- read_csv("dados/studentAssessment.csv") # resultados nas provas
df_vle <- read_csv("dados/studentVle.csv") # log de cliques no ambiente virtual

# agrupa os cliques do ambiente virtual (total de cliques do aluno por disciplina)
df_vle_grouped <- df_vle %>%
  group_by(id_student, code_module, code_presentation) %>%
  summarise(total_clicks = sum(sum_click, na.rm = TRUE), .groups = 'drop')
# %>%: passa o resultado à sua esquerda e como o primeiro argumento para a função que está à direita
# sum_click: coluna em df_vle, número de cliques em um dia, por estudante e modulo
# na.rm = TRUE: ignora células vazias
# .groups = 'drop': destrói agrupamentos internos

# agrupa as notas (média do aluno por disciplina)
df_assessment_grouped <- df_assessment %>%
  group_by(id_student) %>%
  summarize(avg_grade = mean(as.numeric(score), na.rm = TRUE), .groups = 'drop')
# %>%: passa o resultado à sua esquerda e como o primeiro argumento para a função que está à direita
# na.rm = TRUE: ignora células vazias
# .groups = 'drop': destrói agrupamentos internos

# une todas as tabelas em df_oulad
df_oulad <- df_info %>%
  left_join(df_registration, by = c("id_student", "code_module", "code_presentation")) %>%
  left_join(df_vle_grouped, by = c("id_student", "code_module", "code_presentation")) %>%
  left_join(df_assessment_grouped, by = "id_student") %>%

# %>%: passa o resultado à sua esquerda e como o primeiro argumento para a função que está à direita
# left_join: "cola" novas colunas à tabela que est'a esquerda, com base nas chaves em comum (by = ...).

# limpa e categoriza algumas colunas
  mutate(
    total_clicks = replace_na(total_clicks, 0),
    gender = as.factor(gender),
    region = as.factor(region),
    highest_education = factor(highest_education, levels = c(
      "No Formal quals", "Lower Than A Level", "A Level or Equivalent", 
      "HE Qualification", "Post Graduate Qualification"
    )),
    final_result = factor(final_result, levels = c("Withdrawn", "Fail", "Pass", "Distinction"))
  )
# mutate(...): Modifica colunas existentes ou cria novas.

# inspeciona e exporta o df_oulad
glimpse(df_oulad)
write_csv(df_oulad, "dados/df_oulad.csv")