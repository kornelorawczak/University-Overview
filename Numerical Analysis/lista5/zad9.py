import numpy as np 
import mpmath as mp

mp.dps = 128
precision = mp.mpf

def olver(f, df, d2f, x0, n): 
    xs = []
    x = x0
    for i in range(n): 
        xs.append(x)
        fx = f(x)
        dfx = df(x)
        d2fx = d2f(x)

        x1 = x - (fx / dfx) - (0.5 * d2fx * fx**2) / (dfx**3)
        x = x1
    return xs

def fp(x1, x2, x3, x4): 
    return mp.log(abs((x4 - x3) / (x3 - x2))) / mp.log(abs((x3 - x2) / (x2 - x1)))

print("przyklad 1 -> f(x) = x^2 - 4")
f = lambda x : x**2 - 4
df = lambda x : 2*x
d2f = lambda x : 2
xs = olver(f, df, d2f, precision(1.0), 100)
ps = []
for i in range(3, len(xs)):
    try:
        p = fp(xs[i-3], xs[i-2], xs[i-1], xs[i])        
        ps.append(p)
    except ZeroDivisionError:
        print(ps[-2])
        break


print("przyklad 2 -> f(x) = x^3 - 2*x + 2")
f = lambda x : x**3 - 2*x + 2
df = lambda x : 3*x**2 - 2
d2f = lambda x : 6 * x
xs = olver(f, df, d2f, precision(-1.0), 100)
ps = []
for i in range(3, len(xs)):
    try:
        p = fp(xs[i-3], xs[i-2], xs[i-1], xs[i])        
        ps.append(p)
    except ZeroDivisionError:
        print(ps[-2])
        break


print("przyklad 3 -> f(x) = 1/x - 4")
f = lambda x : 1 / x - 4
df = lambda x : -1 / x**2
d2f = lambda x : 2 / x**3
xs = olver(f, df, d2f, precision(0.1), 100)
ps = []
for i in range(3, len(xs)):
    try:
        p = fp(xs[i-3], xs[i-2], xs[i-1], xs[i])        
        ps.append(p)
    except ZeroDivisionError:
        print(ps[-2])
        break


print("przyklad 4 -> f(x) = e^x - 2")
f = lambda x : mp.e ** x - 2
df = lambda x : mp.e ** x
d2f = lambda x : mp.e ** x
xs = olver(f, df, d2f, precision(0.5), 100)
ps = []
for i in range(3, len(xs)):
    try:
        p = fp(xs[i-3], xs[i-2], xs[i-1], xs[i])        
        ps.append(p)
    except ZeroDivisionError:
        print(ps[-2])
        break


print("przyklad 5 -> f(x) = log2(x + 2) - 3")
f = lambda x : mp.log(x + 2, 2) - 3
df = lambda x : 1 / (mp.log(2) * (x + 2))
d2f = lambda x : -1 / (mp.log(2) * (x + 2)**2)
xs = olver(f, df, d2f, precision(5.0), 100)

ps = []
for i in range(3, len(xs)):
    try:
        p = fp(xs[i-3], xs[i-2], xs[i-1], xs[i])        
        ps.append(p)
    except ZeroDivisionError:
        print(ps[-2])
        break
