#I have to write code for the code now
import numpy as np
from numpy import dot

digits=[
"11110111", #0
"10010010", #1
"11011101", #2
"11011011", #3
"10111010", #4
"11101011", #5
"11101111", #6
"11010010", #7
"11111111", #8
"11111011"  #9
]

digits = [np.array([int(digits[i][j]) for j in range(0, 8)]) for i in range(0, 10)]
weights = np.array([-1,1,-6,0,-9,-5,1,-8]) 

print [dot(weights, digits[i]) for i in range(0, 10)]

