import matplotlib.pyplot as plt

xs =  [15.5, 12.5, 8, 10, 7, 4, 8, 10, 9.5, 14, 18, 17, 22, 25, 19,
24.5, 23, 17, 16, 12.5, 16.5, 21, 17, 11, 5.5, 7.5, 10, 12]

ys = [32.5, 28.5, 29, 33, 33, 37, 39.5, 38.5, 42, 43.5, 42, 40, 41.5, 37, 35,
33.5, 29.5, 30.5, 32, 19.5, 24.5, 22, 15, 10.5, 2.5, 8, 14.5, 20]

t = [i/27 for i in range(28)]
def create_NIFS3(xs, ys, t, M) : 
    n = len(xs)
    p = [0] * n
    q = [0] * n
    h = [t[i] - t[i-1] for i in range(1, n)]
    lbda = [h[i] / (h[i] + h[i+1]) for i in range(n-2)]
    dx = [0] * n
    dy = [0] * n
    ux = [0] * n
    uy = [0] * n
    Mx = [0] * n
    My = [0] * n


    for i in range(1, n-2):
        p[i] = lbda[i] * q[i-1] + 2
        q[i] = (lbda[i] - 1) / p[i]

    for i in range(1, n-1): 
        t1 = t[i-1]
        t2 = t[i]
        t3 = t[i+1]
        dx[i] = 6 * ((((xs[i+1] - xs[i]) / (t3 - t2)) - ((xs[i] - xs[i-1]) / (t2 - t1))) / (t3 - t1))
        dy[i] = 6 * ((((ys[i+1] - ys[i]) / (t3 - t2)) - ((ys[i] - ys[i-1]) / (t2 - t1))) / (t3 - t1))

    for i in range(1, n-2):
        ux[i] = (dx[i] - lbda[i]*ux[i-1]) / p[i]
        uy[i] = (dy[i] - lbda[i]*uy[i-1]) / p[i]

    Mx[n-2] = ux[n-2]
    My[n-2] = uy[n-2]

    for i in range(n-3, 0, -1):
        Mx[i] = ux[i] + q[i] * Mx[i+1]
        My[i] = uy[i] + q[i] * My[i+1]

    def Si(M, f, i):
        return lambda x: (M[i] * (t[i+1] - x)**3) / (6*h[i]) + (M[i+1] * (x - t[i])**3) / (6 * h[i]) + ((f[i+1]/h[i]) - (M[i+1]*h[i]/6)) * (x - t[i]) + (((f[i]/h[i]) - (M[i]*h[i]/6))) * (t[i+1] - x)

    def Sx(x) : 
        for i in range(0, n-1):
            if (t[i] <= x <= t[i+1]): 
                f = Si(Mx, xs, i)
                return f(x)
            
    def Sy(x) : 
        for i in range(0, n-1):
            if (i/(n-1) <= x <= (i+1)/(n-1)): 
                f = Si(My, ys, i)
                return f(x)
            

    x_values = []
    y_values = []
    for j in range(M + 1) : 
        u = j/M
        x_values.append(Sx(u))
        y_values.append(Sy(u))
    return x_values, y_values


x_v, y_v = create_NIFS3(xs, ys, t, 1000)
plt.figure(figsize=(12,6))
plt.plot(x_v, y_v, color = 'blue', label='Łamana łącząca punkty')
plt.xlabel('sx(u)')
plt.ylabel('sy(u)')
plt.legend()
plt.show()
        