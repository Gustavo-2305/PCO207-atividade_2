# Gráficos de Rosca
#
# Atividade 1, Tópicos Especiais em Inteligência Artificial
#
# Rafael Renó Corrêa, 18 de out. de 2026

library(showtext)
library(ggplot2)
library(RColorBrewer)

font_add_google(name = "Roboto", family = "Roboto")
showtext_auto()
update_geom_defaults("text", list(family = "Roboto"))
theme_set(theme_void(base_family = "Roboto"))

# Gráfico de rosca é essencialmente um gráfico de barras empilhadas que
# foi curvado em um círculo.
gender_donut <- function(student_info){
  chart <- ggplot(student_info, aes(x=2, fill=gender)) +
    geom_bar(width=1, color="white", linewidth=2) +
    # Adiciona a camada de gráfico de barras.
    
    geom_text(stat="count", aes(label=after_stat(count)),
              position=position_stack(vjust=0.5),
              color="black", size=5) +
    # Contabiliza as linhas para cada gênero e exibe os rótulos.
    
    coord_polar("y", start=0) +
    # Curva o gráfico de barras empilhadas ao longo do eixo Y, unindo as pontas
    # para formar um anel circular completo.
    
    xlim(0.5, 2.5) +
    # Exibe o espaço do eixo X do gráfico que vai de 0.5 até 2.5.
    # Como a barra foi desenhada na posição 2, todo o espaço interno (de 0.5 
    # até 1.5) é renderizado, embora completamente vazio. A curvatura torna 
    # esse espaço vazio no furo do gráfico de rosca.
    
    theme_void() +
    # Remove elementos de fundo, incluindo as linhas de grade.
    
    theme(plot.title=element_text(hjust=0.5)) +
    # Centraliza o título no topo do gráfico.
    
    scale_fill_manual(values=c("M"="steelblue", 
                               "F"="lightgray"
                              ),
                      labels=c("M"="Masculino", 
                               "F"="Feminino"
                              )
                     ) +
    # Define as cores e o texto da legenda.
    
    guides(fill=guide_legend(override.aes=list(linewidth=1))) +
    # Redefine o linewidth para a legenda (2 -> 1).
    
    labs(title="Distribuição de Alunos por Gênero", fill="Gênero")
    
  print(chart)
}

age_donut <- function(student_info){
  chart <- ggplot(student_info, aes(x=2, fill=age_band)) +
    geom_bar(width=1, color="white", linewidth=0.5) + 
    # linewidth 2 -> 0.5 garante visibilidade para a barra de ">=55".
    
    # Camada 1: Rótulos internos (texto branco, centrado em x=2)
    geom_text(stat="count", 
              aes(label=ifelse(after_stat(count)>=1000, after_stat(count), "")),
              position = position_stack(vjust=0.5),
              color="black", size=4) +
    
    # Camada 2: Rótulos externos (texto escuro, deslocado para x=2.7)
    geom_text(stat="count", 
              aes(x=2.75, 
                  label=ifelse(after_stat(count)<1000, after_stat(count), "")
                 ),
              position=position_stack(vjust=0.5),
              color="black", size=4) +
    
    scale_color_identity() +
    coord_polar("y", start=0) +
    xlim(0.5, 3.0) + # 0.5 -> 3.0 garante espaço para a label externa.
    theme_void() +
    theme(plot.title=element_text(hjust=0.5)) +
    scale_fill_manual(values=c("0-35"="steelblue", 
                               "35-55"="lightgray", 
                               "55<="="gray"
                              ),
                      labels=c("0-35"="0–35", 
                               "35-55"="35–55", 
                               "55<="="55+"
                              )
                     ) +
    guides(fill=guide_legend(override.aes=list(linewidth=1))) +
    labs(title="Distribuição de Alunos por Grupo de Idade", fill="Grupo")
  print(chart)
}

region_donut <- function(student_info){
  
  no_regions <- length(unique(student_info$region))
  # Contabiliza a quantidade de regiões para preparar o degradê.
  
  chart <- ggplot(student_info, aes(x=2, fill=region)) +
    geom_bar(width=1, color="white", linewidth=2) +
    
    # geom_text() removido para ocultar os rótulos.
    
    coord_polar("y", start=0) +
    xlim(0.5, 2.5) +
    scale_fill_manual(
      values = colorRampPalette(c("lightgray", "steelblue"))(no_regions),
      # Define a paleta de cores como degradê de azul.
      
      labels = function(x) gsub(" Region", "", x)
      # Omite "Region" das legendas dinamicamente.
    ) +
    theme_void() +
    theme(plot.title=element_text(hjust=0.5)) +
    
    guides(fill=guide_legend(ncol=2, override.aes=list(linewidth=1))) +
    # ncol=2 para exibir a legenda em duas colunas.
    
    labs(title="Distribuição de Alunos por Região", fill="Região")
  print(chart)
}

highest_education_donut <- function(student_info){
  
  no_educations <- length(unique(student_info$highest_education))
  
  chart <- ggplot(student_info, aes(x=2, fill=highest_education)) +
    geom_bar(width=1, color="white", linewidth=0.5) + 
    # Camada 1: Rótulos internos
    geom_text(stat="count", 
              aes(label=ifelse(after_stat(count)>=1000, after_stat(count), "")),
              position = position_stack(vjust=0.5),
              color="black", size=4) +
    
    # Camada 2: Rótulos externos
    geom_text(stat="count", 
              aes(x=2.7, 
                  label=ifelse(after_stat(count)<1000, after_stat(count), "")),
              position=position_stack(vjust=0.5),
              color="black", size=4, check_overlap=TRUE) +
    
    scale_color_identity() +
    coord_polar("y", start=0) +
    xlim(0.5, 3.0) + 
    theme_void() +
    theme(plot.title=element_text(hjust=0.5)) +
    scale_fill_manual(
      values = colorRampPalette(c("lightgray", "steelblue"))(no_educations),
      labels=c("A Level or Equivalent"="Ensino médio completo", 
               "HE Qualification"="Graduação", 
               "Lower Than A Level"="Ensino médio incompleto",
               "No Formal quals"="Sem formação",
               "Post Graduate Qualification"="Pós graduação")
    ) +
    guides(fill=guide_legend(override.aes=list(linewidth=1))) +
    labs(title="Distribuição de Alunos por Nível de Escolaridade", fill="Escolaridade")
  print(chart)
}

final_result_donut <- function(student_info){
  
  no_results <- length(unique(student_info$final_result))
  
  chart <- ggplot(student_info, aes(x=2, fill=final_result)) +
    geom_bar(width=1, color="white", linewidth=2) +
    geom_text(stat="count", aes(label=after_stat(count)),
              position=position_stack(vjust=0.5),
              color="black", size=5) +
    coord_polar("y", start=0) +
    xlim(0.5, 2.5) +
    theme_void() +
    theme(plot.title=element_text(hjust=0.5)) +
    scale_fill_manual(
      values = colorRampPalette(c("lightgray", "steelblue"))(no_results),
      labels=c("Distinction"="Excelência",
               "Fail"="Reprovação",
               "Pass"="Aprovação",
               "Withdrawn"="Desistência")
    ) +
    guides(fill=guide_legend(override.aes=list(linewidth=1))) +
    labs(title="Distribuição de Alunos por Resultado Final", fill="Resultado")
  print(chart)
}