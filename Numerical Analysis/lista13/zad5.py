import math
def Romberg(f, a, b):
    T = [[0] * 21 for _ in range(21)]
    # pierwsza kolumna
    #print(T)
    for k in range(21):
        n = 2**k
        h = (b - a) / n
        suma = 0.5 * (f(a) + f(b))
        for i in range(1, n):
            x = a + i * h
            suma += f(x)
        T[0][k] = h * suma
    # kolejne kolumny 
    for m in range(1, 21):
        for k in range(21 - m):
            T[m][k] = ((4**m)*T[m-1][k+1] - T[m-1][k]) / (4**m - 1)
    return T 

def print_table(tab):
    for k in range(len(tab)):
        for m in range(len(tab)):
            print("%.6f" %tab[m][k], end=" | ")
        print("\n")

# symbolicznie wynosi -1,20333 * 10^8
print_table(Romberg(lambda x : 2025*(x**7) - 2006*(x**6) - 2016*(x**2), -5, 3))

# symbolicznie wynosi 0,54936
# print_table(Romberg(lambda x : 1/(1+25 * (x**2)), -1, 1))

# symbolicznie wynosi 0,471405
# print_table(Romberg(lambda x : math.cos(3*x + math.pi/4), -3*math.pi, math.pi/6))

