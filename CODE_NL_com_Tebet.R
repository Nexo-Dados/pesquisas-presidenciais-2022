
# Configurar --------------------------------------------------------------

#-- bibliotecas
library(readxl)
library(tidyverse)
library(lubridate)

#-- lista de pesquisas
pesq <- read_csv("pesquisas_1t.csv") %>% 
  select(-`Data divulgação`)
exp = T

# Grafico -----------------------------------------------------------------

#-- argumento que controla o quão suave é a linah
span=.50

#-- gerar estimativas
results <- pesq %>%
  drop_na() %>% 
  mutate(Data = as.Date(Data)) %>% 
  pivot_longer(cols=c(Lula:BNI)) %>% 
  mutate(value = value/100) %>% 
  # retirar institutos de pesquisa
  filter(!(Instituto%in%c("Sigma", "Brasmarket"))) %>% 
  mutate(Data=as.numeric(Data)) %>% 
  nest(-name) %>%
  mutate(
    # loess calculation 
    m = purrr::map(data, loess,
                   formula = value ~ Data, span = span),
    # valores previstos
    fitted = purrr::map(m, `[[`, "fitted")) %>% 
  select(-m) %>%
  unnest()



# Cores dos candidatos
col=c( "#fd6166", "#6973ad",
       "#8E8E8E","#000000","#FECE43", "#c05b5e")

results %>% 
  mutate(Data = as.Date(Data, origin="1970/1/1"),
         name = fct_relevel(name, "Lula", "Bolsonaro",
               "BNI")) %>% 
  ggplot(aes(x = Data, y = value, group = name, color = name)) +
  geom_point(alpha=.66, size=.85) +
  geom_smooth(se=T, alpha=.33, span=span, aes(fill=name)) +
  scale_fill_manual(
    values=col) +
  scale_color_manual(values=col) +
  scale_y_continuous(limits=c(0,.5), labels=scales::percent) +
  scale_x_date(date_breaks = "1 month", date_labels = "%m/%y") +
  theme_minimal()

if(exp) {
ggsave(paste0("./img/", 
              str_replace_all(Sys.time(), ":", "_"), "_NL.svg"), 
       width=400*10, height=167*10, unit="px")
}

#-- resultados gerais
results %>% 
  filter(Data==max(Data)) %>% 
  mutate(Data = as.Date(Data, origin="1970/1/1"))  %>% 
  mutate(name = fct_relevel(name, "Lula", "Bolsonaro",
         "Ciro", "BNI", "Outros")) %>%
  group_by(name) %>% 
  summarise(mean=mean(fitted)) %>% 
  filter(name!="BNI") %>% 
  mutate(mean = mean/sum(mean)) %>% 
  mutate(mean=paste0(round(mean*100,1), "%")) 

span=.60
results %>% 
  mutate(Data = as.Date(Data, origin="1970/1/1"),
         name = fct_relevel(name, "Lula", "Bolsonaro",
                            "Outros", "BNI", "Tebet", "Ciro")) %>% 
  filter(name%in%c("Ciro", "Tebet")) %>% 
  ggplot(aes(x = Data, y = value, group = name, color = name)) +
  geom_point(alpha=.66, size=.85) +
  geom_smooth(se=T, alpha=.33, span=span, aes(fill=name)) +
  scale_fill_manual(
    values=c("#f15a24", "#662d91")) +
  scale_color_manual(values=c("#f15a24", "#662d91")) +
  scale_y_continuous(limits=c(0,.12), labels=scales::percent) +
  scale_x_date(date_breaks = "1 month", date_labels = "%m/%y") +
  theme_minimal()

pesq %>% 
  mutate(week = week(Data)) %>% 
  filter(Data>=dmy("15-08-2022")) %>% 
  group_by(week, Ciro) %>% 
  #summarise(Ciro = mean(Ciro, na.rm=T)) %>% 
  summarise(Cirop = n()) %>% 
  ggplot(aes(x=week, y=Ciro, fill=Cirop)) +
  geom_tile() +
  scale_fill_distiller(palette="Purples", direction=1)


pesq %>% 
  mutate(week = week(Data)) %>% 
  filter(Data>=dmy("15-08-2022")) %>% 
  group_by(week, Tebet) %>% 
  #summarise(Ciro = mean(Ciro, na.rm=T)) %>% 
  summarise(Cirop = n()) %>% 
  ggplot(aes(x=week, y=Tebet, fill=Cirop)) +
  geom_tile() +
  scale_fill_distiller(palette="Purples", direction=1)






