library(tidyverse)
library(googlesheets4)
        
pesq <- read_sheet(
  "https://docs.google.com/spreadsheets/d/1VBOhutLq4geLNQ7UzK5wUfx2TKaFVstsvr0rJEuGtik/edit#gid=627641507",
  sheet="1-turno") 

write.csv(pesq, "pesquisas_1t.csv", row.names=F)


