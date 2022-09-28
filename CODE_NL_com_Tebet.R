
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
  filter(!(Instituto%in%c("Sigma", "Brasmarket",
                          "Futura", "Verita"))) %>% 
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
                "Outros", "BNI", "Tebet", "Ciro")) %>% 
  ggplot(aes(x = Data, y = value, group = name, color = name)) +
  geom_point(alpha=.66, size=.85) +
  #-- line e smooth geram a mesma linha aqui
  #-- smooth até gerar o s.e. automaticamente
  #geom_line(aes(y = fitted), size=1) +
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
  mutate(mean=paste0(round(mean*100,1), "%")) 

