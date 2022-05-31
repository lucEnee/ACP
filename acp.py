import openpyxl
from pathlib import Path
import matplotlib.pyplot

"""
openXLSX : return openned file
"""
def openXLSX(file):
    xlsx_file = Path("save-data", file)
    wb_obj = openpyxl.load_workbook(xlsx_file) 
    carFile = wb_obj.active
    return carFile

"""
cleanRow : clean line with empty value
"""
def cleanRow(file): 
  for row in file:        
    if not all(cell.value for cell in row):      
      file.delete_rows(row[0].row, 1)         
      cleanRow(file) 
      return 

"""
moyenneFile : averages a given column of the file
"""
def moyenneFile(file, column):
    sum = 0
    n = -1
    for ligne in file:  
        if n >= 0 :
            sum += int(ligne[column].value)
        n += 1
    return(sum/n)

"""
moyenneList : averages a given list
"""
def moyenneList(list):
    somme = 0
    for val in list:  
        somme = somme + val
    return(somme/len(list))

"""
normalize : normalized data
"""
def normalize(file, column):
    moyenne = moyenneFile(file, column)
    normalizedList = list()
    n = 0
    for ligne in file:      
        if n > 0 :
            normalizedList.append(int(ligne[column].value) - moyenne)
        n += 1
    return normalizedList

"""
nuagesPoints : generates a scatter plot for values 2 to 2
"""
def nuagePoints(file, variable1, variable2):

    normalize(file, variable1)
    normalize(file, variable2)

    variableName1 = file[1][variable1].value
    variableName2 = file[1][variable2].value

    n = 0
    x = list()
    y = list()
    for ligne in file:      
        if n > 0 :    
            x.append(int(ligne[variable1].value))      
            y.append(int(ligne[variable2].value))
        n += 1    

    matplotlib.pyplot.subplots()
    matplotlib.pyplot.scatter(x, y)  
    matplotlib.pyplot.title('Nuage de points')
    matplotlib.pyplot.xlabel(variableName1)
    matplotlib.pyplot.ylabel(variableName2)

    variableName1 = variableName1.replace("/",".")
    variableName2 = variableName2.replace("/",".")
    
    matplotlib.pyplot.savefig('./save-data/nuages-points/nuage-' + variableName1 + '-' + variableName2 + '.png')

"""
generateAllNuage : call nuagePoints and apply it to all the columns of a given file
"""
def generateAllNuage(file) :
  for ligne in range(len(file[1])):
    for colonne in range(len(file[1])):
      if colonne>ligne :
        nuagePoints(file, ligne, colonne)



