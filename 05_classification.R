#Training Site: pixel presi in modo casuale da lì-->  Indiduamo gruppi (cluster) in base alla diversa riflettanza..
#Facciamo poi la media dei valori tra i vari cluster da qui calcoliamo la distanza di un nuovo pixel incognito e vediamo se il pixel è più distante al cluster vegetazione rispetto ad altri cluster
#

# quantifying land cover change

# install.packages("ggplot2")
# install.packages("patchwork")

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

# lista immagini 
im.list()
#importiamo i dati
im.import

m1992<-("matogrosso_l5_1992219_lrg.jpg")    

# https://www.esa.int/ESA_Multimedia/Images/2020/07/Solar_Orbiter_s_first_views_of_the_Sun6
# additional images: https://webbtelescope.org/contents/media/videos/1102-Video?Tag=Nebulas&page=1

#importiamo anche l'immagine del sole 

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# classifying images
#classififichiamo le varie classi di cluster da noi scelte in questo caso 3 
sunc <- im.classify(sun, num_clusters=3)
#
# importing Mato grosso images
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# classifying images in questo caso mettiamone solo 2 per rimarcare la differenza tra suolo nudo e la vegetazione
m1992c <- im.classify(m1992, num_clusters=2)

# rinominiamo le classi 
# class 1 = forest
# class 2 = human

m2006c <- im.classify(m2006, num_clusters=2)

# 2006
# class 1 = human
# class 2 = forest

# frequencies numero di pixel della foresta - il numero di pixel di suolo nudo
f1992 <- freq(m1992c)

# proportions
tot1992 <- ncell(m1992c)
prop1992 = f1992 / tot1992

# percentages
perc1992 = prop1992 * 100

# 17% human, 83% forest

# frequencies
f2006 <- freq(m2006c)

# proportions
tot2006 <- ncell(m2006c)
prop2006 = f2006 / tot2006

# percentages
perc2006 = prop2006 * 100

# 1992: 17% human, 83% forest
# 2006: 55% human, 45% forest

# let's build a dataframe
class <- c("forest", "human")
p1992 <- c(83, 17)
p2006 <- c(45, 55)

tabout <- data.frame(class, p1992, p2006)
tabout

# plotting the output
ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")

# patchwork
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2

# varying axis and using lines
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2
