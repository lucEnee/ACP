#Installation des packages (à effectuer qu'une seule fois)
install.packages('openxlsx')
install.packages('rstudioapi')
install.packages('ggplot2')

#Appel des librairies
library(openxlsx)
library(rstudioapi)
library(ggplot2)

#Définition du répertoire de travail
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#Ouverture du fichier de données dans un dataframe
carsData <- openxlsx::read.xlsx(xlsxFile = "carsData.xlsx")

#Nettoyage du dataframe en supprimant les lignnes avec une donnée manquante       
carsData <- carsData[rowSums(is.na(carsData)) ==0,]

#Conversion du dataframe en numérique(dans le but de le centrer et le réduire)
carsData <- data.frame(sapply(carsData, function(x) as.numeric(as.character(x))))

#Centrage et réduction du dataframe
scale(carsData, center = TRUE, scale = TRUE)

#Génération des graphes avec Longueur en abscisse
par(new = TRUE)
par(mfrow=c(3,2))
plot(carsData$Longueur, carsData$Largeur, xlab = "Longueur", ylab = "Largeur")
plot(carsData$Longueur, carsData$Poids.à.vide, xlab = "Longueur", ylab = "Poids à vide")
plot(carsData$Longueur, carsData$Cylindrée, xlab = "Longueur", ylab = "Cylindrées")
plot(carsData$Longueur, carsData$Puissance.de.moteur, xlab = "Longueur", ylab = "Puissance moteur")
plot(carsData$Longueur, carsData$Vitesse.max, xlab = "Longueur", ylab = "Vitesse max")

#Génération des graphes avec Largeur en abscisse
par(new = TRUE)
par(mfrow=c(3,2))
plot(carsData$Largeur, carsData$Longueur, xlab = "Largeur", ylab = "Longueur")
plot(carsData$Largeur, carsData$Poids.à.vide, xlab = "Largeur", ylab = "Poids à vide")
plot(carsData$Largeur, carsData$Cylindrée, xlab = "Largeur", ylab = "Cylindrées")
plot(carsData$Largeur, carsData$Puissance.de.moteur, xlab = "Largeur", ylab = "Puissance moteur")
plot(carsData$Largeur, carsData$Vitesse.max, xlab = "Largeur", ylab = "Vitesse max")

#Génération des graphes avec Poids à vide en abscisse
par(new = TRUE)
par(mfrow=c(3,2))
plot(carsData$Poids.à.vide, carsData$Longueur, xlab = "Poids à vide", ylab = "Longueur")
plot(carsData$Poids.à.vide, carsData$Largeur, xlab = "Poids à vide", ylab = "Largeur")
plot(carsData$Poids.à.vide, carsData$Cylindrée, xlab = "Poids à vide", ylab = "Cylindrées")
plot(carsData$Poids.à.vide, carsData$Puissance.de.moteur, xlab = "Poids à vide", ylab = "Puissance moteur")
plot(carsData$Poids.à.vide, carsData$Vitesse.max, xlab = "Poids à vide", ylab = "Vitesse max")
  