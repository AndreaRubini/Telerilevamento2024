#importeremo un dato da una cartella all'interno del nostro pc 
#una volta salvata l'immagine da git hub all'interno del nostro pc 
#set working directory --> 
setwd("/Users/Rubolide/Downloads")rast
#per lanciare la l'importazione dell'immagine bisogna lanciare il comando rast("")
#il comando rast è all'interno del pacchetto terra ( quindi è prima da lanciare il suddetto pacchetto terra)
im.plotRGB(eclissi,1,2,3)
#band difference 
dif=eclissi[[1]]- eclissi[[2]]
plot(dif)
#importiamo una nuova immagine
dust <- rast("Algeria_TMO2004052_lrg.jpg")
im.plotRGB(dust,1,2,3)
#salva in pc, seleziona la working directory, usal il comando rast, usal il comando im.plotRGB
#copernicus global land service 
#cambiamenti climatici e i solo effetti su vegetazione, ghiaccio acqua, 4 blocchi di dati più altri 
#l'energia lens art temperator e hotspot 
#fapar fraction of absorbed photosynthetically active radiation, ndvi normalized index vegetation Vci Vegetation condition index 
#Dry matter productivity misura la quantità di biomassa secca della pianta
#burnt area: area di incendi in tutto il pianeta
#Soil Water index : misura dell'umidità del suolo
#Energia: riflettanza della parte + alta degli oggetti Toc, Albedo: riflettanza del sole lst: temperatura al suolo.
#water: lake water quality, water bodies 
#Cryosphere SnowCover lakeiceextent 
