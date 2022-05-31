from matplotlib import pyplot as plt
import numpy
import acp, regressionLineaire

file = acp.openXLSX("./carDB.xlsx")
acp.cleanRow(file)

#regressionLineaire.generateAllCourbe(file)

regressionLineaire.generateAllCourbe(file)