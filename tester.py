#I have to write code for the code now
import numpy as np
from numpy import dot

digits=[
"11110111",
"10010010",
"11011101",
"11011011",
"10111010",
"11101011",
"11101111",
"11010010",
"11111111",
"11111011"
]

digits = [np.array([int(digits[i][j]) for j in range(0, 8)]) for i in range(0, 10)]
weights = np.array([-1, 0, 3, -1, -5, 2, 1, 0]) 

print [dot(weights, digits[i]) for i in range(0, 10)]

