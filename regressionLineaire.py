from matplotlib import pyplot as plt
import numpy
import acp


def moyenne(file, column):
    list = acp.normalize(file, column)
    moyenne = 0
    for i in range(len(list)):
        moyenne += list[i]
    return moyenne/len(list)

def Y_YBxX_XB(file, column1, column2):
    listX = acp.normalize(file, column2)
    listY = acp.normalize(file, column1)
    moyenneX = moyenne(file, column2)
    moyenneY = moyenne(file, column1)
    listY_YBxX_XB = list()
    
    for i in range(len(listX)):
        listY_YBxX_XB.append((listX[i]-moyenneX)*(listY[i]-moyenneY))

    return listY_YBxX_XB

def X_XB2(file, column1, column2):
    listX = acp.normalize(file, column2)
    listY = acp.normalize(file, column1)
    listX_XB2 = list()

    for i in range(len(listX)):
        listX_XB2.append((listX[i]-listY[i])**2)

    return listX_XB2

def centreeCarre(file,column):  
    listX = acp.normalize(file, column)
    listCentreCarre = list()
    
    for i in range(len(listX)):
        listCentreCarre.append(listX[i]*listX[i])
    return listCentreCarre


def yChapeau(file,column1,column2):
    listYChapeau = list()
    a = acp.moyenneList(Y_YBxX_XB(file,column1,column2))/acp.moyenneList(centreeCarre(file,column1))
    b = acp.moyenneFile(file,column2)-a*acp.moyenneFile(file,column1)

    n=0
    for ligne in file:      
        if n > 0 :    
            listYChapeau.append(a*int(ligne[column1].value)+b)
        n += 1   
        
    return listYChapeau
  

  
def residu(file,column1,column2):
    listResidus = list()
    Ychap = yChapeau(file,column1,column2)

    n=-1
    for ligne in file:      
        if n >= 0 :    
            listResidus.append(int(ligne[column1].value)-Ychap[n])
        n += 1  
    
    return listResidus


def residuCarre(file,column1,column2):
    listResidusCarre = list()
    listResidus = residu(file,column1,column2)
    
    for i in range(len(listResidus)):
        listResidusCarre.append(listResidus[i]*listResidus[i])

    return listResidusCarre
    
"""
sommeCarreTotal : 
"""
def sommeCarreTotal(file):
    SCT = 0
    for i in range(len(file[1])):
        liste = centreeCarre(file,i)
        for j in range(len(liste)):
            SCT = SCT + liste[j]
    return SCT

def courbesRegression(file, column1, column2):
    acp.nuagePoints(file, column1, column2)

    columnName1 = file[1][column1].value
    columnName2 = file[1][column2].value

    a = sum(Y_YBxX_XB(file, column1, column2))/sum(X_XB2(file, column1, column2))
    b = moyenne(file, column1)-(a*moyenne(file, column2))

    w = 0
    m = list()
    n = list()
    for ligne in file:      
        if w > 0 :    
            m.append(int(ligne[column1].value))
            n.append(int(ligne[column2].value))
        w += 1  

    x = numpy.arange(min(m),max(m))
    y = a*x+b

    columnName1 = columnName1.replace("/",".")
    columnName2 = columnName2.replace("/",".")

    plt.plot(x, y)
    plt.savefig("./save-data/courbe-regression/courbe-"+ columnName1 + "-" + columnName2 +".png")

"""
generateAllCourbe : call courbeRegression and apply it to all the columns of a given file
"""
def generateAllCourbe(file) :
  for ligne in range(len(file[1])):
    for colonne in range(len(file[1])):
        if colonne>ligne :
            courbesRegression(file, ligne, colonne)