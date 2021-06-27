library(tidyverse)
library(jsonlite)
library(sf)
library(lubridate)
library(tictoc)
library(data.table)

ruta<-"D:/Documentos/api_transporte/datos/2021-06-24"
lista<-list.files(ruta)
tic("leyendo 1")
DF <-  read_sf(sprintf("%s/%s",ruta,lista[1]))
toc()
tic("leyendo_2")
df<-  read_sf(sprintf("%s/%s",ruta,lista[2]))
toc()
tic("uniendo")
DF <- rbind(DF, df)
toc()
# combine<- function(Base,archivo_nuevo){
#   a<-read_sf(paste0(ruta,"/",archivo_nuevo))
#   DF<- rbind(Base, a)
# return(DF)
# }
# DF_2<-combine(DF, lista[2])



# 
# for (f in lista[-2]){
#   df <- read_sf(sprintf("%s/%s",ruta,f))      # read the file
#   DF <- rbind(DF, df)    # append the current file
# }

tic("escribiendo")
b<-sprintf("%s/%s_2.geojson",ruta,str_sub(ruta,-10,-1))
write_sf(DF,b)
toc()



DF<-as.data.frame(DF)
write_json(DF,"/Documentos/api_transporte/datos/2021-06-25/bondis.json")
df<-mutate(DF, fecha=ymd_hms(fecha))
max(df$fecha)



