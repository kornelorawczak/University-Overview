import math
import matplotlib.pyplot as plt
fact = math.factorial

W = [[39.5,10.5], [30,20], [6,6], [13,-12], [63,-12.5], [18.5,17.5], [48,63], [7,25.5],
     [48.5,49.5], [9,19.5], [48.5,35.5], [59,32.5], [56,20.5]]
w = [1,2,3,2.5,6,1.5,5,1,2,1,3,5,1]
#w = [1 for i in range(len(W))] # default obraz, zmiana wag konkretnych punktów przyciąga krzywą do nich


def B(i, n, t):
    return (fact(n)/(fact(i)*fact(n-i))) * t**i * (1-t)**(n-i)

points = 1000
n = len(W)

def R(n, t):
    sum1 = [0,0]
    sum2 = 0
    for i in range(n):
        b = B(i, n, t)
        sum1[0] += w[i] * W[i][0] * b
        sum1[1] += w[i] * W[i][1] * b
        sum2 += w[i] * b
    return [sum1[0]/sum2, sum1[1]/sum2]

t_values = [j/points for j in range(points)]    
pts = [R(n, t) for t in t_values]

plt.figure(figsize=(12,6))
plt.plot([p[0] for p in pts], [p[1] for p in pts], color = 'blue', label='Krzywa Beziera dla punktów')
plt.legend()
plt.show()