#Innanzitutto andiamo a richiamare gli add-on necessari al nostro progetto
library(terra) # Per la funzione rast()
library(imageRy) # Per im.plotRGB() e im.classify()
library(viridis) # Per utilizzare colorRampPalette adatte a chi soffre di daltonismo
library(ggplot2) # Per la creazione dei boxplot
library(patchwork) # Per visualizzare i boxplot insieme

# Innanzitutto setto Rstudio nella cartella directory dove ho salvato le immagini 
setwd("/Users/Rubolide/Desktop/OasiManzolino")


# Le immagini prese in esame sono dell'Oasi di Manzolino e Tivoli SIC-ZPS  e si rifanno al mese di luglio dal 2017 al 2024 
# Dal'momento che le specie che popolano il sito sono molto sensibili ai cambiamenti di volume e profondità delle zone umide 
# Questo studio vuole vedere alla massima distanza temporale  possibile per Sentinel se vi sono state queste differenze.
# Dal momento che la gestione dei livelli idrici è da parte dell'uomo questo studio vuole vedere se vi sono state differenze di gestione.


# Le immagini sono state scaricate grazie al Copernicus Browser. 
# Le immagini sono state catturate con Sentinel-2.
# Le immagini sono in tiff a 16 bit e risoluzione spaziale massima di X 2m/px, Y 2m/px.
# Sono state scaricate le immagini relative alle bande del blu, verde, rosso e NIR
# Immagini di una porzione di territorio pari a 5.52km2
# Tutte le immagini sono state prese attorno al 20 di luglio di tutti e 8 gli anni.
# Carico le immagini dal 2017 al 2024 Ogni banda viene assegnata ad un oggetto. 
# Queste vengono poi incluse in uno stack per creare una immagine che contenga tutte le bande per ogni anno. 

            #2017

B022017<-rast("B04-2017.tiff")

B032017<-rast("B03-2017.tiff")

B042017<-rast("B02-2017.tiff")

B082017<-rast("B08-2017.tiff")

U17<-c(B022017,B032017,B042017,B082017)

           #2018

B022018<-rast("B04-2018.tiff")

B032018<-rast("B03-2018.tiff")

B042018<-rast("B02-2018.tiff")

B082018<-rast("B08-2018.tiff")

U18<-c(B022018,B032018,B042018,B082018)
         
          #2019

B022019<-rast("B04-2019.tiff")

B032019<-rast("B03-2019.tiff")

B042019<-rast("B02-2019.tiff")

B082019<-rast("B08-2019.tiff")

U19<-c(B022019,B032019,B042019,B082019)
       
          #2020

B022020<-rast("B04-2020.tiff")

B032020<-rast("B03-2020.tiff")

B042020<-rast("B02-2020.tiff")

B082020<-rast("B08-2020.tiff")

U20<-c(B022020,B032020,B042020,B082020)
      
         #2021

B022021<-rast("B04-2021.tiff")

B032021<-rast("B03-2021.tiff")

B042021<-rast("B02-2021.tiff")

B082021<-rast("B08-2021.tiff")

U21<-c(B022021,B032021,B042021,B082021)
          
          #2022 

B022022<-rast("B04-2022.tiff")

B032022<-rast("B03-2022.tiff")

B042022<-rast("B02-2022.tiff")

B082022<-rast("B08-2022.tiff")

U22<-c(B022022,B032022,B042022,B082022)

          #2023

B022023<-rast("B04-2023.tiff")

B022023<-rast("B04-2023.tiff")

B032023<-rast("B03-2023.tiff")

B042023<-rast("B02-2023.tiff")

B082023<-rast("B08-2023.tiff")

 U23<-c(B022023,B032023,B042023,B082023)
         
          #2024

B022024<-rast("B04-2024.tiff")

B022024<-rast("B04-2024.tiff")

B032024<-rast("B03-2024.tiff")

B042024<-rast("B02-2024.tiff")

B082024<-rast("B08-2024.tiff")

 U24<-c(B022024,B032024,B042024,B082024)


# imposto una visualizzazione delle immagini utilizzando la funzione par() di ImageRy, 
# creando una griglia di 4righe e 2 colonne. Il primo plot mostra le immagini in TrueColor. 
# Il secondo plot viene impostato con la banda del NIR in prima posizione così da evidenziare al meglio le zone umide


par(mfrow=c(4,2))
im.plotRGB(U17, 1,2,3)
im.plotRGB(U18, 1,2,3)
im.plotRGB(U19, 1,2,3)
im.plotRGB(U20, 1,2,3)
im.plotRGB(U21, 1,2,3)
im.plotRGB(U22, 1,2,3)
im.plotRGB(U23, 1,2,3)
im.plotRGB(U24, 1,2,3)

dev.off()

par(mfrow=c(4,2))
im.plotRGB(U17, 1,4,2)
im.plotRGB(U18, 1,4,2)
im.plotRGB(U19, 1,4,2)
im.plotRGB(U20, 1,4,2)
im.plotRGB(U21, 1,4,2)
im.plotRGB(U22, 1,4,2)
im.plotRGB(U23, 1,4,2)
im.plotRGB(U24, 1,4,2)


dev.off()

# calcolo l'NDWI (Normalized Difference Water Index) seguendo la formula: 
# NDWI=(B3-B8)/(B3+B8)   McFeeters (1996)
# N.B.: B3 qui è la banda del verde così come impostata su sentinel. B8 è per il NIR. 
# si sfruttano queste due bande per poter mettere in risalto l'acqua. 

# 2017

DifU17 = U17[[2]] - U17[[4]] # differenza tra GREEN e NIR
SumU17 = U17[[2]] + U17[[4]] # somma tra GREEN e NIR
ndwiU17 = DifU17 / SumU17

# 2018

DifU18 = U18[[2]] - U18[[4]] # differenza tra GREEN e NIR
SumU18 = U18[[2]] + U18[[4]] # somma tra GREEN e NIR
ndwiU18 = DifU18 / SumU18

# 2019

DifU19 = U19[[2]] - U19[[4]] # differenza tra GREEN e NIR
SumU19 = U19[[2]] + U19[[4]] # somma tra GREEN e NIR
ndwiU19 = DifU19 / SumU19

# 2020

DifU20 = U20[[2]] - U20[[4]] # differenza tra GREEN e NIR
SumU20 = U20[[2]] + U20[[4]] # somma tra GREEN e NIR
ndwiU20 = DifU20 / SumU20

# 2021

DifU21 = U21[[2]] - U21[[4]] # differenza tra GREEN e NIR
SumU21 = U21[[2]] + U21[[4]] # somma tra GREEN e NIR
ndwiU21 = DifU21 / SumU21

# 2022

DifU22 = U22[[2]] - U22[[4]] # differenza tra GREEN e NIR
SumU22 = U22[[2]] + U22[[4]] # somma tra GREEN e NIR
ndwiU22 = DifU22 / SumU22

#2023

difU23 = U23[[2]] - U23[[4]] # differenza tra GREEN e NIR
sumU23 = U23[[2]] + U23[[4]] # somma tra GREEN e NIR
ndwiU23 = difU23/ sumU23

#2024

difU24 = U24[[2]] - U24[[4]] # differenza tra GREEN e NIR
sumU24 = U24[[2]] + U24[[4]] # somma tra GREEN e NIR
ndwiU24 = difU24/ sumU24



# Visualizzazione delle immagini elaborate attraverso l'indice NDWI, 
# suddividendoli per gli 8 anni di riferimento
# La colorazione scelta è viridis perché la porzione di acqua verrà evidenziata in giallo, 
# il resto del territorio apparirà in una scala di blu. 
# Sfrutto sempre la stessa impostazione data da un par() con 4 righe e 2 colonne così da avere 
# in successione tutte le immagini dal 2017 al 2024

par(mfrow=c(4,2))
plot(ndwiU17, col=viridis (100)) # 2017 
plot(ndwiU18, col=viridis (100)) # 2018
plot(ndwiU19, col=viridis (100)) # 2019
plot(ndwiU20, col=viridis (100)) # 2020
plot(ndwiU21, col=viridis (100)) # 2021
plot(ndwiU22, col=viridis (100)) # 2022
plot(ndwiU23, col=viridis (100)) # 2023
plot(ndwiU24, col=viridis (100)) # 2024

dev.off()

# Creazione del par per la visualizzazione delle classificazioni di ogni anno
# utilizzando come base il risultato del NDWI.

par(mfrow=c(4,2))

U17c <- im.classify(ndwiU17, num_clusters=3)

# calcolo le percentuali di copertura per ogni classe per il 2017

U17e <- ncell(U17c)
F17e <- freq(U17c)
prop17 = F17e / U17e
perc17 = prop17 * 100
perc17

i17c <- im.classify(ndwiU17, num_clusters=3)

# calcolo le percentuali di copertura per ogni classe per 2018

U18c <- im.classify(ndwiU18, num_clusters=3)

U18e <- ncell(U18c)
F18e <- freq(U18c)
prop18 = F18e / U18e
perc18 = prop18 * 100
perc18

i18c <- im.classify(ndwiU18, num_clusters=3)

# calcolo le percentuali di copertura per ogni classe per 2019

U19c <- im.classify(ndwiU19, num_clusters=3)

U19e <- ncell(U19c)
F19e <- freq(U19c)
prop19 = F19e / U19e
perc19 = prop19 * 100
perc19

i19c <- im.classify(ndwiU19, num_clusters=3)

# calcolo le percentuali di copertura per ogni classe per 2020

U20c <- im.classify(ndwiU20, num_clusters=3)

U20e <- ncell(U20c)
F20e <- freq(U20c)
prop20 = F20e / U20e
perc20 = prop20 * 100
perc20

i20c <- im.classify(ndwiU20, num_clusters=3)

# calcolo le percentuali di copertura per ogni classe per il 2021

U21c <- im.classify(ndwiU21, num_clusters=3)

U21e <- ncell(U21c)
F21e <- freq(U21c)
prop21 = F21e / U21e
perc21 = prop21 * 100
perc21

i21c <- im.classify(ndwiU21, num_clusters=3)

# calcolo le percentuali di copertura per ogni classe per il 2022

U22c <- im.classify(ndwiU22, num_clusters=3)

U22e <- ncell(U22c)
F22e <- freq(U22c)
prop22 = F22e / U22e
perc22 = prop22 * 100
perc22

i22c <- im.classify(ndwiU22, num_clusters=3)

# calcolo le percentuali di copertura per ogni classe per il 2023

U23c <- im.classify(ndwiU23, num_clusters=3)

U23e <- ncell(U23c)
F23e <- freq(U23c)
prop23 = F23e / U23e
perc23 = prop23 * 100
perc23

i23c <- im.classify(ndwiU23, num_clusters=3)

# calcolo le percentuali di copertura per ogni classe per il 2024

U24c <- im.classify(ndwiU24, num_clusters=3)

U24e <- ncell(U24c)
F24e <- freq(U24c)
prop24 = F24e / U24e
perc24 = prop24 * 100
perc24

i24c <- im.classify(ndwiU24, num_clusters=3)

# creazione dei campi che verranno utilizzati per il dataframe 
# raccolgo le percentuali di copertura delle varie classi dividendole per anno

Anno <- c("2017","2018","2019","2020","2021","2022","2023","2024")


soil <- c( 52.580053,64.676829,42.42707,59.979688,47.40778,51.818871, 58.460798,49.857209) # percentuali di suolo nudo
veg <- c(38.436993,26.813452,42.42707,31.470599, 42.47723, 41.442443,32.295866,43.474236) # percentuali di vegetazione
water <- c(8.982954,8.509719,8.27440, 8.549713,10.11500,6.738687, 9.243336,6.668555) # percentuali della variazione di acqua 

# tali percentuali sono espresse in relazione alla superficie totale dell'area di studio pari a 5.54km2
#essendo un area fortemente antropica le variazioni di terreno nudo e vegetazione sono quasi del tutto dovute alle varie epoche di raccolta
#delle coltivazioni, pertanto non le prenderemo in studio. 

# creazione del dataframe

tab <- data.frame(Anno, soil, veg, water)
tab

# Visualizzo il dataframe in una versione tabellare

View(tab) 

# creazione del grafico a barre

anno <- c(2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024)
water <- c(8.982954, 8.509719, 8.274400, 8.549713, 10.115000, 6.738687, 9.243336, 6.668555)

# Calcolo delle variazioni percentuali anno su anno


variazioni_percentuali <- c(NA, diff(water) / head(water, -1) * 100)
 
# Creazione del grafico a barre
barplot(variazioni_percentuali,
+         names.arg = anno, 
+         col = ""skyblue"", 
+         main = "Variazioni Percentuali del livello idrico per Anno", 
+         xlab = "Anno", 
+         ylab = "Variazione Percentuale (%)", 
+         ylim = c(min(variazioni_percentuali, na.rm = TRUE) - 5, 
+                  max(variazioni_percentuali, na.rm = TRUE) + 5))
#lasciando aperta la parentesi tonda possiamo andare a capo nel comando id input

# Aggiungere una linea di base zero

abline(h = 0, col = "black")
# Il grafico mostra chiaramente come a partire dal 2019 vi è una grande differenza nella gestione dei livelli idrici, cosa che invece veniva fatta precedentemente
