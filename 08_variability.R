# Measuring variability from satellite imagery
#variabilità--> deviazione standard:  scarto, lo elevo al quadrato
library(imageRy)
library(terra)
# install.packages("viridis") pacchetto per creare grafici che possano essere visibili anche da persone afette da daltonismo
library(viridis)

im.list()

sent <- im.import("sentinel.png")

im.plotRGB(sent, 1, 2, 3)

# NIR = band 1
# red = band 2
# green = band 3
# creo una finestrella di tre pixel che scansionerà l'immagine al cui interno farò la deviazione standard 
im.plotRGB(sent, r=2, g=1, b=3)

nir <- sent[[1]] #nir ora equivale all'oggetto1 
cl <- colorRampPalette(c("black", "blue", "green", "yellow"))(4)
plot(nir, col=cl)
#statistiche all'interno di un gruppo di valori sd3 
#focal = calcolo deviazione standard in questo caso della finestra 3x3
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)
#utilizzeremo la palette viridis già presente all'interno del pacchetto omonimo
#il pacchetto 7 all'interno di viridis sono le legende, per averle visualizzate quindi dobbiamo richiamare il pacchetto 7 
viridisc <- colorRampPalette(viridis(7))(256)
plot(sd3, col=viridisc)

# Standard deviation 7x7 
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

# stack
stacksd <- c(sd3, sd7)
plot(stacksd, col=viridisc)

# Standard deviation 13x13
sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd)

stacksd <- c(sd3, sd7, sd13)
plot(stacksd, col=viridisc)
#la deviazione standard è un valore relativo rispetto alla riflettanza originale  che va (da 0 a 255) 
# introduzione all'analisi multivariata: nella prossima lezion 09 analizzeremo salvador dali e banchoff 
# principal component pc1 e pc2 asse pc1 e tengo quell'asse perdo il 10% dell'informazione a cui è legato l'asse 2 ma
