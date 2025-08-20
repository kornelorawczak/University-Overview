import numpy as np
import matplotlib.pyplot as plt

def p(xs, wezly):
    rets = []
    for x in xs:
        ret = 1
        for w in wezly:
            ret *= (x - w)
        rets.append(ret);
    return rets

def wezly_czebyszewa(n):
    w_czebyszewa = []
    for i in range(1, n + 1):
        w_czebyszewa.append(np.cos(((2*i - 1)*np.pi) / (2 * n)))
    return w_czebyszewa


def draw1(r1, r2):
    punkty_rowno = np.linspace(-1, 1, 100) # do rysowania
    for n in range(r1, r2 + 1):
        wezly_rowne = np.linspace(-1, 1, n + 1)
        wielomiany = p(punkty_rowno, wezly_rowne)
        plt.plot(punkty_rowno, wielomiany, label = f"n = {n}")
        
    plt.title(f"Wielomiany dla węzłów równoodległch (n = {r1},...,{r2})")
    plt.tight_layout()
    plt.grid(alpha=0.5)
    plt.show()


def draw2(r1, r2): 
    punkty_rowno = np.linspace(-1, 1, 100) # do rysowania
    for n in range(r1, r2 + 1):
        w_cz = wezly_czebyszewa(n)
        wielomiany = p(punkty_rowno, w_cz)
        plt.plot(punkty_rowno, wielomiany, label = f"n = {n}")
        
    plt.title(f"Wielomiany dla węzłów Czebyszewa (n = {r1},...,{r2})")
    plt.tight_layout()
    plt.grid(alpha=0.5)
    plt.show()

draw1(10, 10)
#draw2(10, 10) # tutaj widać ładnie że rzeczywiście jest to dużo dokładniejsze