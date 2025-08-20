import matplotlib.pyplot as plt
import numpy as np
from zad8a import read_points_from_file

def lagrange(xs, ys):
    n = len(xs)
    def fn(x, k):
        res = 1.0
        for j in range(n):
            if (j!=k):
                res *= (x - xs[j]) / (xs[k] - xs[j])
        return res
    return lambda x : sum(ys[i] * fn(x, i) for i in range(n))
    
if __name__ == "__main__": 
    xs, ys = read_points_from_file("punkty.csv")
    x = np.linspace(min(xs), max(xs), 1000)
    w = lagrange(xs, ys)
    y = [w(xk) for xk in x]
    plt.plot(x, y, color="red", label="w(x)")
    plt.scatter(x, y, color="blue", label="pkt interpolacji")
    plt.scatter(xs, ys, color="green", label="pkt wejściowe")
    plt.xlabel('X')
    plt.ylabel('Y')
    plt.ylim((-100, 300))
    plt.title('Wykres wielomianu interpolowanego na podstawie punktów z punkty.csv')
    plt.legend()
    plt.axhline(0, color='black', linewidth=0.8)  
    plt.axvline(0, color='black', linewidth=0.8)
    plt.show()
    for i in range(10, 2, -1):
        print(i)


