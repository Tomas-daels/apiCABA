library(tidyverse)
library(jsonlite)
library(sf)
library(lubridate)
library(tictoc)
library(purrr)

ruta_archivos<-"/Documentos/api_transporte/datos/2021-06-27/"
lista_archivos<-dir(path = ruta_archivos, pattern=c("*.rds"))
setwd(ruta_archivos)

data <-lista_archivos %>% 
  map(read_rds) %>% 
  reduce(rbind)


tic()
data<-read_rds("/Documentos/api_transporte/datos/2021-06-27/bondi2021-06-27_036.rds")
toc()