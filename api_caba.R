library(tidyverse)
library(jsonlite)
library(geojsonio)
library(lubridate)
library(taskscheduleR)
library(sf)
library(tictoc)
#seteamos el momento en que estamos haciendo el análisis
ahora<-now()

#bajamos la info de la API

client_id<-"fb5c063d6b1a4b3bb89825f3f49abd63" #mi numero de cliente provisto por CABA
client_secret<-"fE7966343DC3436585De51A6715bE6e7" #mi pass de cliente provisto por CABA
url_api<-"https://apitransporte.buenosaires.gob.ar/colectivos/vehiclePositionsSimple?" #url de la pagina donde se publican los datos
url_api_datos<-sprintf("%sclient_id=%s&client_secret=%s",url_api,client_id,client_secret) #url completa con mis datos

bondi<-fromJSON(url_api_datos) #leemos de la api  

bondi<-mutate(bondi,fecha = as.POSIXct(timestamp, origin="1970-01-01")) #reinterpretamos la fecha y hora del timestamp
ruta_guardado<-sprintf("D:/Documentos/api_transporte/datos/%s",date(ahora)) #ruta de la carpeta que va a contenero los archivos guardados
ruta<-sprintf("%s/bondi%s_%02d%02d.rds", ruta_guardado,date(ahora),hour(ahora),minute(ahora)) #ruta archivo generado
  tic("rds")
  
    if (dir.exists(ruta_guardado)){
      saveRDS(bondi,ruta, compress = F) #si existe la carpeta, guarda ahi adentro
    } else {
      dir.create(ruta_guardado) #si no existe la carpeta, la crea
      saveRDS(bondi,ruta, compress = F) #guarda el archivo en la carpeta generada
    }
  toc() #mide el tiempo


