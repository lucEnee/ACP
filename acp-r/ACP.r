#/!\DOIT ETRE INSTALLE UNE SEULE FOIS, PASSER EN COMMENTAIRE APRES L'INSTALLATION EFFECTUEE
#install.packages('openxlsx')
#install.packages('rstudioapi')
#install.packages('ggplot2')
#install.packages('FactoMineR')
#install.packages('explor')

library(openxlsx)
library(rstudioapi)
library(FactoMineR)
library(explor)

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

#Création des graphiques + régression linéaire et enregistrement en png pour visualisation dans le fichier "saved_plot"
for (i in colnames(carsData)){
  for(j in colnames(carsData)){
    if (i != j){
      
      mypath <- file.path("saved_plot",paste(i, " + ", j, ".png", sep = ""))
      
      png(file=mypath)
        mytitle = paste("plot_", i, j) 
        plot(carsData[[i]], carsData[[j]], xlab = i, ylab = j)
        droite <- lm(formula = carsData[[j]] ~ carsData[[i]], data = carsData)
        abline(droite, col = "red")
        resume <- summary(droite)
        legend("topleft", legend = paste("R²=",resume[8]))
        legend("bottomleft", legend = paste("Equation=",droite$coefficients[1],"+",droite$coefficients[2]))
      dev.off()
    }
  }
}

#Matrice de corrélation du dataframe
cor(carsData)

#ACP du dataframe
carsPCA <- PCA(carsData) 

#/!\UTILISEZ LES FLECHES DANS LE COIN EN HAUT A GAUCHE DE LA FENETRE "Plots" AFIN DE VISUALISER LES DIFFERENTS GRAPHES
#Projection sur les axes 1 et 2
axe12 <- explor::prepare_results(carsPCA)
explor::PCA_var_plot(axe12, xax = 1, yax = 2, var_sup = FALSE, var_sup_choice = ,
                     var_lab_min_contrib = 0, col_var = NULL, labels_size = 11, scale_unit = TRUE,
                     transitions = TRUE, labels_positions = NULL, xlim = c(-1.1, 1.1), ylim = c(-1.1,
                                                                                                1.1))
#Projection sur les axes 1 et 3
axe13 <- explor::prepare_results(carsPCA)
explor::PCA_var_plot(axe13, xax = 1, yax = 3, var_sup = FALSE, var_sup_choice = ,
                     var_lab_min_contrib = 0, col_var = NULL, labels_size = 11, scale_unit = TRUE,
                     transitions = TRUE, labels_positions = NULL, xlim = c(-1.1, 1.1), ylim = c(-1.1,
                                                                                                1.1))
#Projection sur les axes 2 et 3
axe23 <- explor::prepare_results(carsPCA)
explor::PCA_var_plot(axe23, xax = 2, yax = 3, var_sup = FALSE, var_sup_choice = ,
                     var_lab_min_contrib = 0, col_var = NULL, labels_size = 11, scale_unit = TRUE,
                     transitions = TRUE, labels_positions = NULL, xlim = c(-1.1, 1.1), ylim = c(-1.1,
                                                                                                1.1))