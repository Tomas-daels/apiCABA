library(tidyverse)
library(jsonlite)
library(geojsonio)
library(lubridate)
library(taskscheduleR)
library(sf)
#seteamos el momento en que estamos haciendo el análisis
ahora<-now()

#bajamos la info de la API
  #leemos de la api 
  bondi<- do.call(rbind.data.frame, read_json("https://apitransporte.buenosaires.gob.ar/colectivos/vehiclePositionsSimple?client_id=fb5c063d6b1a4b3bb89825f3f49abd63&client_secret=fE7966343DC3436585De51A6715bE6e7"))
  #agregamos la fecha y hora
  bondi<-mutate(bondi,fecha = now())
  #lo interpretamos como un sf
  bondi_geo<-st_as_sf(bondi, coords = c("longitude", "latitude"), crs = 4326)
  #creamos la ruta
  ruta<-sprintf("D:/Documentos/api_transporte/datos/%s/bondis_geo_%s_%s%s.geojson", date(ahora),date(ahora),hour(ahora),minute(ahora))
  ruta_guardado<-sprintf("D:/Documentos/api_transporte/datos/%s/,date(ahora)")
  #guardamos el archivo que generamos
  
  
  if (dir.exists(ruta_guardado)){
     write_sf(bondi_geo,ruta)
  } else {
    dir.create(ruta_guardado)
    write_sf(bondi_geo,ruta)
  }


# #buscamos el historico, vamos a hacer un archivo por día para que sea manejable
#   #bucamos la ruta del histórico
#   ruta_hist<-sprintf("D:/Documentos/api_transporte/datos/bondis_geo_%s.geojson", date(ahora))
#   #chequeamos que exista
#   if (file.exists(ruta_hist)) {
#     bondi_historico<-read_sf(ruta_hist)
#     #lo incorporamos a los datos y generamos el nuevo archivo.
#     bondi_historico_2<-rbind(bondi_historico,bondi_geo) %>% 
#       unique()
# } else {
#     #lo incorporamos a los datos y generamos el nuevo archivo.
#     bondi_historico_2<-bondi_geo %>% 
#       unique()
# }
# 
# # generamos el nuevo archivo histórico.
# 
# geojson_write(bondi_historico_2,file = ruta_hist, overwrite = TRUE)
# 
