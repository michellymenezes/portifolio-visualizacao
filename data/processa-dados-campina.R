library(dplyr)
dados = read.csv("fluxo-campina.csv") %>%
  select(horario_inicial, carros, motos, onibus, caminhoes, total_ciclistas, total_pedestres) %>%
  mutate(horario_inicial = substr(horario_inicial, 1, 2))


library(reshape2)
n_dados <- melt(dados, id=c("horario_inicial")) %>%
  group_by(horario_inicial, variable) %>%
  summarise(value = mean(value))

names(n_dados) = c("hora", "tipo", "n")
write_csv(n_dados, "tipos-fluxo-campina-mean.csv")

n_dados <- melt(dados, id=c("horario_inicial")) %>%
  group_by(horario_inicial, variable) %>%
  summarise(value = median(value))

names(n_dados) = c("hora", "tipo", "n")
write_csv(n_dados, "tipos-fluxo-campina-median.csv")
