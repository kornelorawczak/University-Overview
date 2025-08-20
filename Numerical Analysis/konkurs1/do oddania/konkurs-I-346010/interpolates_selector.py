import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import main as m
import numpy as np

'''
    Funkcja select_points() odpowiada za wyświetlenie obrazu oryginalnego na wykresie
    i umożliwia wybieranie punktów interpolacji za pomocą myszki. Następnie zwraca 
    zaokrąglone współrzędne tych punktów 
'''
def select_points(path):
    img = mpimg.imread(path)
    plt.figure(figsize=(16, 7))
    plt.imshow(img, extent=[0, 1786, 0, 738])
    plt.title("Wybierz punkty i kliknij enter")
    selected_points = plt.ginput(n=0, timeout=0)
    plt.close()
    xs = [round(p[0]) for p in selected_points]
    ys = [round(p[1]) for p in selected_points]
    print(xs)
    print(ys)
    return xs, ys



'''
    Wywołując plik interpolates_selector.py z terminala, najpierw za pomocą funkcji 
    select_points wybieramy punkty interpolacji, a potem rysowana jest na ich podstawie
    krzywa NIFS3 używając równoodległych punktów rysowania. Jeśli ona nam pasuje to 
    kopiujemy wyświetlone na terminalu punkty do pliku z danymi w main.py
'''
if __name__ == '__main__':
    path = "./img.png"
    xs, ys = select_points(path)
    x_v, y_v = m.create_NIFS3(xs, ys, m.create_ts(xs, ys), np.linspace(0,1,200))
    img = mpimg.imread(path)
    plt.figure(figsize=(16, 7))
    plt.imshow(img, extent=[0, 1786, 0, 738])
    plt.plot(xs, ys, color='blue')
    plt.show()

