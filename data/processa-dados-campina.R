library(dplyr)
dados = read.csv("fluxo-campina.csv") %>%
  select(horario_inicial, carros, motos, onibus, caminhoes, total_ciclistas, total_pedestres) %>%
  mutate(horario_inicial = substr(horario_inicial, 1, 2))

dados1 = read.csv("fluxo-campina.csv") %>%
  select(horario_inicial, carros, motos, onibus, caminhoes, total_ciclistas, total_pedestres, local) %>%
  mutate(horario_inicial = substr(horario_inicial, 1, 2))


dados2 = read.csv("fluxo-campina.csv") %>%
  select(horario_inicial, carros, motos, onibus, caminhoes, total_ciclistas, total_pedestres, local) 


library(reshape2)
library(readr)
n_dados <- melt(dados1, id=c("horario_inicial", "local")) %>%
  group_by(horario_inicial, variable, local) %>%
  summarise(value = sum(value)) 
n_dados = n_dados %>% rbind(n_dados %>%
  mutate(local = "todos") %>%
  group_by(horario_inicial, variable, local) %>%
  summarise(value = median(value)))


names(n_dados) = c("hora", "tipo", "local", "n")
write_csv(n_dados, "tipos-fluxo-campina-lugares-sum-median.csv")




n_dados <- melt(dados1, id=c("horario_inicial", "local")) %>%
  group_by(horario_inicial, variable, local) %>%
  summarise(value = sum(value)) %>%
  group_by(horario_inicial, variable) %>%
  summarise(value = median(value))
  

names(n_dados) = c("hora", "tipo", "n")
write_csv(n_dados, "tipos-fluxo-campina-sum-median.csv")

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


n_dados = melt(read.csv("fluxo-campina.csv") %>% 
                 select(horario_inicial, mulheres_ciclistas, mulheres_pedestres, homens_pedestres, homens_ciclistas, local),
               id=c("horario_inicial", "local")) %>% 
  mutate(horario_inicial = substr(horario_inicial, 1, 2)) %>%
  group_by(horario_inicial, variable, local) %>% 
  summarise(value = sum(value)) %>%
  group_by(horario_inicial, variable) %>% 
  summarise(value = median(value))
names(n_dados) = c("hora", "tipo", "n")
write_csv(n_dados, "fluxo-homens-mulheres-median.csv")



# dados = read.csv("fluxo-campina.csv") %>%
#   select(horario_inicial, total_pedestres, local) %>%
#   mutate(horario_inicial = substr(horario_inicial, 1, 2)) %>%
#   group_by(horario_inicial, local) %>%
#   summarise(total_pedestres = mean(total_pedestres)) %>%
#   ungroup() %>%
#   mutate(horario_inicial = paste(horario_inicial, ":00", sep = ""))
# write_csv(dados, "media-pessoas-lugares.csv")


