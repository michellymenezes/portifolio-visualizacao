library(dplyr)
dados = read.csv("fluxo-campina.csv") %>%
  select(horario_inicial, carros, motos, onibus, caminhoes, total_ciclistas, total_pedestres) %>%
  mutate(horario_inicial = substr(horario_inicial, 1, 2))

dados2 = read.csv("fluxo-campina.csv") %>%
  select(horario_inicial, carros, motos, onibus, caminhoes, total_ciclistas, total_pedestres, local) 


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

n_dados = melt(dados2 %>% 
                 select(horario_inicial, total_ciclistas, total_pedestres, local),
               id=c("horario_inicial", "local"))
n_dados_motor = melt(dados2 %>% 
                       select(-total_ciclistas, -total_pedestres), 
                     id=c("horario_inicial", "local"))

n_dados = n_dados %>% 
  select(-variable) %>% 
  group_by(horario_inicial, local) %>% 
  summarise(value = sum(value)) %>% 
  select(-local) %>% 
  group_by(horario_inicial) %>% 
  summarise(value = median(value))

n_dados_motor = n_dados_motor %>% 
  select(-variable) %>% 
  group_by(horario_inicial, local) %>% 
  summarise(value = sum(value)) %>% 
  select(-local) %>% 
  group_by(horario_inicial) %>% 
  summarise(value = median(value))

n_dados_motor$tipo = "Motorizado"
n_dados$tipo = "Não motorizado"

n_dados = n_dados %>% rbind(n_dados_motor)

names(n_dados) = c("hora", "n", "tipo")
write_csv(n_dados, "tipos-motor-fluxo-campina-median.csv")
