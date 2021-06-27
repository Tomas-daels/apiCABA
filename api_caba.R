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
# bondi<- do.call(rbind.data.frame, read_json("https://apitransporte.buenosaires.gob.ar/colectivos/vehiclePositionsSimple?client_id=fb5c063d6b1a4b3bb89825f3f49abd63&client_secret=fE7966343DC3436585De51A6715bE6e7"))

url_api<-"https://apitransporte.buenosaires.gob.ar/colectivos/vehiclePositionsSimple?client_id=fb5c063d6b1a4b3bb89825f3f49abd63&client_secret=fE7966343DC3436585De51A6715bE6e7"

bondi<-fromJSON(url_api)

bondi<-mutate(bondi,fecha = as.POSIXct(timestamp, origin="1970-01-01")) #reinterpretamos la fecha y hora del timestamp

ruta<-sprintf("D:/Documentos/api_transporte/datos/%s/bondi%1$s_%s%s.json", date(ahora),hour(ahora),minute(ahora))
ruta_guardado<-sprintf("D:/Documentos/api_transporte/datos/%s/",date(ahora))
#guardamos el archivo que generamos

tic("json")
if (dir.exists(ruta_guardado)){
  write_json(bondi,ruta)
} else {
  dir.create(ruta_guardado)
  write_json(bondi,ruta)
}
toc()

ruta<-sprintf("D:/Documentos/api_transporte/datos/%s/bondi%1$s_%s%s.rds", date(ahora),hour(ahora),minute(ahora))
tic("rds")

  if (dir.exists(ruta_guardado)){
    saveRDS(bondi,ruta, compress = F)
  } else {
    dir.create(ruta_guardado)
    saveRDS(bondi,ruta, compress = F)
  }
toc()


bondi_2<-fromJSON("/Documentos/api_transporte/datos/2021-06-26/bondi2021-06-26_2140.json")

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
