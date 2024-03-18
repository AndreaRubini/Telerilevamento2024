# Satellite data visualisation in R by imageRy
# https://sentinels.copernicus.eu/web/sentinel/user-guides/sentinel-2-msi/resolutions/spatial
#assicurarsi che i pacchetti terra e imageRy siano installati e richiamarli

library(terra)
library(imageRy)
#Utilizzare im.list() per visializzare la lista delle immagini caricate
# List of data avialable in imageRy
im.list()

# Importing data
#importiamo un immagine e assegnamole un nome
b2 <- im.import("sentinel.dolomites.b2.tif")

# Plotting the data
clg <- colorRampPalette(c("black", "grey", "light grey"))(3)
plot(b2, col=clg)

clg <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(b2, col=clg)
# cerchiamo i nomi dei colori disponibili su R attraverso google
clcyan <- colorRampPalette(c("magenta", "cyan4", "cyan"))(3)
plot(b2, col=clcyan)

clcyan <- colorRampPalette(c("magenta", "cyan4", "cyan"))(100)
plot(b2, col=clcyan)

clch <- colorRampPalette(c("magenta", "cyan4", "cyan", "chartreuse"))(100)
plot(b2, col=clch)

# importing the additional bands
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3, col=clch)

b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col=clch)

b8 <- im.import("sentinel.dolomites.b8.tif")
plot(b8, col=clch)

# multiframe
# utilizzando mfrow 2,2 avremo una tabella con due righe e due colonne 
par(mfrow=c(2,2))
plot(b2, col=clch)
plot(b3, col=clch)
plot(b4, col=clch)
plot(b8, col=clch)

# Exercise
# plot the four bands one after the other in a single row
#utilizzando invece mfrow=1,4 avremo le immagini in una singola riga orizzonatale
par(mfrow=c(1,4))
plot(b2, col=clch)
plot(b3, col=clch)
plot(b4, col=clch)
plot(b8, col=clch)

# Let's make a satellite image
#questo comando permette di unire le varie immagini al fine di formarne una singola
# N.B. le immagini vengono visualizzate a griglia 2x2 non vengono sovrapposte una sull'altra 
stacksent <- c(b2, b3, b4, b8) # c() concatenate concatena insieme i plot
plot(stacksent, col=clch)

dev.off()
plot(stacksent[[4]], col=clch)

dev.off() # cancella il precedente plot

# RGB plotting 
# stacksent [[1]] = b2= blue
# stacksent [[2]] = b3= green
# stacksent [[3]] = b4= red
# stacksent [[4]] = b8= nir

# impilare le immagini una sull altra per creare una nuova immagine che è la somma delle precedenti
im.plotRGB(stacksent,3,2,1) 
# se si vuole visualizzare il vicino infrarosso al posto del rosso, swicth del 3 in 4 e 2 in 3 e 1 in due. TECNICA DEL FALSO COLORE 
im.plotRGB(stacksent,4,3,2) 

#  per visualizzare in colori naturali e in infrarosso
par(mfrow=c(1,2)
# nir in green
> im.plotRGB(stacksent,3,4,2)        
# nir in blue
> im.plotRGB(stacksent,3,2,4)     
# final multiframe
par(mfrow=c(2,2))
im.plotRGB(stacksent,3,2,1) 
im.plotRGB(stacksent,3,4,2)     
im.plotRGB(stacksent,3,2,4)        
im.plotRGB(stacksent,4,2,3)     
#grafico che mostra la correlazione tra le varie bande (correlation of information)
pairs (stacksent)    
im.plotRGB(stacksent,3,2,1) 
im.plotRGB(stacksent,3,4,2)     
im.plotRGB(stacksent,3,2,4)        
im.plotRGB(stacksent,4,2,3)    
#grafici di correlazone tra i vari colori  
