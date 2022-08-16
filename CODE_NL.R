
# Configurar --------------------------------------------------------------

#-- bibliotecas
library(readxl)
library(tidyverse)
library(lubridate)

#-- lista de pesquisas
pesq <- read_csv("pesquisas_1t.csv")

# Grafico -----------------------------------------------------------------

#-- argumento que controla o quão suave é a linah
span=.90

#-- gerar estimativas
results <- pesq %>%
  mutate(Tebet = replace_na(Tebet, 0)) %>% 
  mutate(Data = as.Date(Data),
         Outros = Tebet+Outros) %>% 
  pivot_longer(cols=c(Lula:Ciro, Outros:BNI)) %>% 
  mutate(value = value/100) %>% 
  # retirar institutos de pesquisa
  filter(!(Instituto%in%c("Sigma"))) %>% 
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
       "#8E8E8E","#000000","#c05b5e")

results %>% 
  mutate(Data = as.Date(Data, origin="1970/1/1"),
         name = fct_relevel(name, "Lula", "Bolsonaro",
                "Outros", "BNI", "Ciro")) %>% 
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

ggsave(paste0("./pdf/", 
              str_replace_all(Sys.time(), ":", "_"), "_NL.pdf"), width=8, height=8)


#-- resultados gerais
results %>% 
  filter(Data==max(Data)) %>% 
  mutate(Data = as.Date(Data, origin="1970/1/1"))  %>% 
  mutate(name = fct_relevel(name, "Lula", "Bolsonaro",
         "Ciro", "BNI", "Outros")) %>%
  group_by(name) %>% 
  summarise(mean=mean(fitted)) %>% 
  mutate(mean=paste0(round(mean*100,1), "%")) 




