#False Color, vi sono indici di falso colore di diverso tipo, uno di questi utilizzano il colori assorbiti dalle piante, infrarosso e rosso,le piante hanno la riflettanza dell'infrarosso per motivi strutturali le piante lo riflettono, il rosso invece viene assorbito per far partire la fotosintesi
#la riflettanza è un indice che varia da 0 a 1  nel infrarosso ipotizziamo di avere 0.9 nel rosso ipotizziamo 0.2 --> si crea una operazione tra due bande, Mapalgerba (0.9-0.2=0.7) 
#Difference Vegetation Index-DVI 
#redegde limite  tra il rosso e infrarosso 
# vegetation indices

library(imageRy)
library(terra)

im.list() #lista immagini di imageRy
#importiamo l'immagine dopo averla salvata m1992
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")   
# bands: 1=NIR, 2=RED, 3=GREEN (set impostazioni colori default di questa immg)
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m1992, 1, 2, 3)
im.plotRGB(m1992, r=2, g=1, b=3) # infrarosso nella banda del verde 
im.plotRGB(m1992, r=2, g=3, b=1) # infrarosso nella banda del blu
#l'acqua assorbe tutto l'infrarosso nell'immagine è giallo perchè l'acqua è torbida im
# import the recent image del 2006
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=2, g=3, b=1)

# build a multiframe with 1992 and 2006 images
par(mfrow=c(1,2))
im.plotRGB(m1992, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=3, b=1)

# DVI = NIR - RED
# bands: 1=NIR, 2=RED, 3=GREEN

dvi1992 = m1992[[1]] - m1992[[2]]
plot(dvi1992)

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col=cl)

# exercise: calculate dvi of 2006
dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006, col=cl)

# NDVI
ndvi1992 = (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]])
ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]])
plot(ndvi1992, col=cl)

# NDVI
ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col=cl)

# par
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100) # specifying a color scheme
par(mfrow=c(1,2))
plot(ndvi1992, col=clvir)
plot(ndvi2006, col=clvir)

# speediing up calculation
ndvi2006a <- im.ndvi(m2006, 1, 2)
plot(ndvi2006a, col=cl)


