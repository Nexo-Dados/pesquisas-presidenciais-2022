# download
library(googlesheets4)
library(tidyverse)

# url (LINK NAO É PUBLICO)
url = "https://docs.google.com/spreadsheets/d/1VBOhutLq4geLNQ7UzK5wUfx2TKaFVstsvr0rJEuGtik/edit#gid=0"

# download
pesq <- read_sheet(url, sheet="2-turno") %>% 
  mutate(Data = as.Date(Data))

write_csv(pesq, file="pesquisas_2t.csv")