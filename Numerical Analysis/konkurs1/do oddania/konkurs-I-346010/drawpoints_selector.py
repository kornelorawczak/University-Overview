import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import main as m
import numpy as np
import interpolates_selector as ins


'''
    Wywołując z terminala plik drawpoints_selector.py (komenda python3 drawpoints_selector.py)
    otwiera się plik z napisem oryginalnym na którym wybieramy punkty do rysowania,
    są one potem przepuszczane przez funkcje create_ts z pliku main.py i wypisywane na terminal
'''
if __name__ == '__main__':
    path = "./img.png"
    xs, ys = ins.select_points(path)
    print(list(round(p, 2) for p in m.create_ts(xs, ys)))

