from zad8a import read_points_from_file
import matplotlib.pyplot as plt 
import numpy as np

xs, ys = read_points_from_file("punkty.csv")

Pw = [[1] * len(xs)]


def f(x):
    i = 0
    for xx in xs:
        if x == xx:
            return ys[i]
        i+=1

N = len(xs)
P = [[1.0]] # P0 = 1, to jest lista współczynników
c = [0.0] # c0 = 0 
d = [0.0, 0.0] # d0 = 0 oraz d1 = 0
P_scalars = [N] # lista skalarów typu <Pk, Pk>, gdzie pierwszy <1, 1> to po prostu ilość punktów

def wartosc_wielomianu(x, wspolczynniki):
    wspolczynniki = wspolczynniki[::-1] # odwracamy liste wspolczynników - dla czytelności
    n = len(wspolczynniki) - 1
    res = 0.0
    while (n > -1) : 
        res += x**n * wspolczynniki[n]
        n-=1
    return res
    

def iloczyn_skalarny(f, g):
    res = 0.0
    for k in range(N):
        res += f(xs[k]) * g(xs[k])
    return res


c.append(iloczyn_skalarny(lambda x : x, lambda x : 1.0) / P_scalars[0])
# ------------
# Pw.append(x - c[1] for x in xs)
# for k in range(2, 16): 
#     newPscalars = 0
#     newC = 0
#     for i in range(len(xs)):
#         newPscalars += Pw[k-1][i] ** 2
#         newC += Pw[k-1][i] * xs[i]
#     P_scalars.append(newPscalars)



# ------------

# wyznaczanie P1 za pomocą c1
P.append([1, -1 * c[1]])

# wyznaczanie c, d, P na raz (od 2 do 15)
for k in range(2, 30):
    P_scalars.append(iloczyn_skalarny(
        lambda x : wartosc_wielomianu(x, P[k-1]), 
        lambda x : wartosc_wielomianu(x, P[k-1])))

    c.append(iloczyn_skalarny(
        lambda x : x * wartosc_wielomianu(x, P[k-1]),
        lambda x : wartosc_wielomianu(x, P[k-1])
    ) / P_scalars[k-1])

    d.append(P_scalars[k-1] / P_scalars[k-2])

    # Pk(x) = x * Pk-1(x) - ck * Pk-1(x) - dk * Pk-2(x)
    new_P = [0.0] * (k + 1) # wypełniam zerami
    new_P[0] = P[k-1][0] # pierwszy współczynnik taki jak w poprzednim
    new_P[1] = P[k-1][1] - c[k] * P[k-1][0] # drugi współczynnik taki jak 2 z Pk-1 - ck * pierwszy z Pk-1
    for j in range(2, k) : 
        new_P[j] = P[k-1][j] - c[k] * P[k-1][j-1] - d[k] * P[k-2][j-2]
    new_P[k] = - c[k] * P[k-1][k-1] - d[k] * P[k-2][k-2]
    P.append(new_P)

P_scalars.append(iloczyn_skalarny(
        lambda x : wartosc_wielomianu(x, P[15]),
        lambda x : wartosc_wielomianu(x, P[15])
    ))

a=[]
for i in range(0, 30):
    a.append(iloczyn_skalarny(
        lambda x : f(x), lambda x : wartosc_wielomianu(x, P[i])
    ) / P_scalars[i])

def W(x, st) : 
    res = 0
    for i in range(st + 1):
        res += a[i] * wartosc_wielomianu(x, P[i])
    return res

def draw(stopien):
    x = np.linspace(min(xs) - 1, max(xs) + 1, 100)
    y = [W(xx, stopien) for xx in x] 
    plt.plot(x, y, color="red", label="f(x)")
    plt.xlabel('X')
    plt.ylabel('Y')
    plt.title('Wykres przyblizonego wielomianu o stopniu: ' + str(stopien))
    plt.scatter(xs, ys, color="green", label="pkt wejściowe")
    plt.legend()
    plt.axhline(0, color='black', linewidth=1.8)  
    plt.axvline(0, color='black', linewidth=1.8)
    plt.show() 

draw(29) # od 3 jest idealne dopasowanie dla punktów a od 12 widać na brzegach coraz większe odklejki