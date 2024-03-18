# Installing new packages in R
# Utilizzando la funzione install.packages() si possono installare librerie. Di default R prende le librerie dal CRAN.
# Lanciando la funzione può richiedere di scegliere la città di provenienza per terminare l'installazione.
# Si possono installare anche pacchetti sviluppati da programmatori esterni dal CRAN. 
# Per poter scaricare e utilizzare pacchetti presenti su GitHub bisogna installare il pacchetto devtools presente nel CRAN.
# Il pacchetto presente su GitHub è imageRy 

install.packages("terra")
install.packages("devtools")
devtools::install_github("ducciorocchini/imageRy")

# Una volta installato il pacchetto si richiama la funzione library per caricare il pacchetto.
# Può essere utilizzata anche per controllare se è già presente il pacchetto e non c'è bisogno di utilizzare le virgolette.

library(terra)
library(devtools)
library(imageRy)

remove.packages () #rimuovere il pacchetto selezionato
