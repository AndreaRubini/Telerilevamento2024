# how to make multivariate analysis in R with remote sensing data
# come fare a individuare una sola variabile su cui fare il calcolo?
#possiamo rendere due dimensioni e racchiuderle in una singola dimensione
#analisi delle compontenti principali
#partendo da due bande originali anzichè usare gli assi tradizioni utilizzaizamo un nuovo asse PC1 con un range molto piu alto del secondo PC2 
library(terra)
library(imageRy)
library(viridis) # for the final plot

im.list()
#iniziamo con l'importazione di ogni singola banda
b2 <- im.import("sentinel.dolomites.b2.tif")  #blue
b3 <- im.import("sentinel.dolomites.b3.tif")  #verde
b4 <- im.import("sentinel.dolomites.b4.tif")  #rosso
b8 <- im.import("sentinel.dolomites.b8.tif")  #nir
#stack per ricopomporre l'immagine satellitare
sentdo <- c(b2, b3, b4, b8)

im.plotRGB(sentdo, 4, 3, 2)

pairs(sentdo)

# PCA

# 1. Sample
# sample <- spatSample(sentdo, 100)
# sample

# 2. PCA
# pca <- prcomp(sample)

# variance explained
# summary(pca)

# 3. PCA map
# pcmap <- predict(sentdo, pca, index=c(1:4))

pcimage <- im.pca(sentdo)

# [1] 1719.25654  626.98962   54.63642   34.92315
tot <- sum(1719.25654,626.98962,54.63642,34.92315)
1719.25654*100 / tot

viridis <- colorRampPalette(viridis(7))(255)
plot(pcimage, col=viridis)

magma <- colorRampPalette(magma(7))(255)
plot(pcimage, col=magma)


