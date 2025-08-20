import matplotlib.pyplot as plt
import numpy as np

def f(t):
    return 6.02 * (t + 3.2) * (t - 0.02) * (t + 1.7)

def read_points_from_file(file):
    xs = []
    ys = []
    with open(file, 'r') as f:
        for line in f:
            x, y = map(float, line.strip().split(", "))
            xs.append(x)
            ys.append(y)
        f.close()
    return xs, ys

if __name__ == "__main__":
    t, y = read_points_from_file("punkty.csv")
    # punkty z pliku
    plt.scatter(t, y, color='blue', marker='o', label='Punkty')

    # wykres f
    xs = np.linspace(min(t), max(t), 2000)
    ys = [f(x) for x in xs]
    plt.plot(xs, ys, color="red", label="f(x)")

    plt.xlabel('X')
    plt.ylabel('Y')
    plt.title('Wykres punktów z pliku punkty.csv i funkcji f')
    plt.legend()
    plt.axhline(0, color='black', linewidth=1.8)  
    plt.axvline(0, color='black', linewidth=1.8)
    plt.show()