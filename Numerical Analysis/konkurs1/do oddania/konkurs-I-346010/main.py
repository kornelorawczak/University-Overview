import matplotlib.pyplot as plt
import numpy as np

'''
    Funkcja create_ts przyjmuje zestaw współrzędnych punktów dla danej krzywej NIFS3,
    w postaci dwóch list: 
    - współrzędne x-owe kolejnych punktów (xs)
    - współrzędne y-owe kolejnych punktów (ys)
    Oraz zwraca listę punktów wektora t z zakresu 0 - 1, obliczone proporcjonalnie do 
    odległości punktów od siebie 
'''
def create_ts(xs, ys):
    distances = [
        np.sqrt((xs[i] - xs[i-1])**2 + (ys[i] - ys[i-1])**2) # odległości wszystkich punktów
        for i in range(1, len(xs))
    ]
    total_distance = sum(distances)    
    t_values = [0]  
    cumulative_distance = 0
    for d in distances:
        cumulative_distance += d
        t_values.append(cumulative_distance / total_distance)
    
    return t_values


'''
    Poniżej znajduje się tablica z danymi współrzędnych x-owych punktów interpolacji.
    Każdy wiersz to dane jednej krzywej NIFS3.
    Punkty wyznaczane były używając własnego narzędzia wyznaczania tych punktów 
    z pliku interpolates_selector.py
'''
xs = [
    # Literka P
    [109, 117, 121, 108, 100, 140, 201, 183, 113],
    # Literka W
    [270, 268, 274, 286, 296, 316, 372, 392, 381],
    # Literka O
    [454, 458, 436, 424, 449, 491, 519, 524, 505, 487, 483],
    # Plusik 1
    [612, 684],
    [637, 640, 644, 651],
    # Plusik 2
    [818, 779, 743, 774, 772, 771],
    # Literka t
    [1039, 1049, 1048, 1043, 1040],
    [1021, 1042, 1030, 1042, 1064],
    # Literka o 
    [1102, 1096, 1077, 1100, 1131, 1139, 1131, 1122, 1114],
    # Literka n
    [1222, 1231, 1240, 1257, 1266, 1273, 1274, 1283],
    # Literki aj
    [1304, 1307, 1296, 1296, 1326, 1324, 1333, 1349, 1368, 1372, 1370, 1365, 1360, 1358],
    [1379, 1394],
    # Literki le 
    [1420, 1409, 1406, 1427, 1452, 1460, 1451, 1442, 1448, 1473],
    # Literka p
    [1504, 1500, 1498, 1491, 1484, 1485, 1506, 1532, 1538, 1523],
    # Literki rzy 
    [1555, 1565, 1567, 1578, 1630, 1616, 1607, 1621, 1637, 1645, 1656, 1663, 1676, 1695, 1699, 1695],
    # Literka j
    [86, 93, 93, 94, 97],
    [110, 111, 115],
    # Literka ę
    [130, 144, 159, 157, 146, 132, 164, 158, 164, 172],
    # Literki zy
    [183, 223, 213, 218, 234, 254, 253, 250, 261, 282, 291, 283, 285, 285],
    # Literka k
    [314, 312, 314, 323, 333, 343, 339, 345, 368],
    # Literki pr
    [563, 563, 567, 573, 578, 577, 569, 566, 572, 584, 602, 618, 624, 618, 631, 655, 654, 655, 670, 676],
    # Literka o
    [722, 718, 720, 725, 733, 741, 733, 717, 702, 700, 705, 711, 716, 719],
    # Literki gr
    [772, 765, 751, 763, 790, 799, 793, 800, 829, 852, 854, 851, 885],
    # Literka a
    [906, 900, 888, 879, 881, 887, 906, 916, 921, 924, 935, 945],
    # Literka m
    [968, 971, 979, 983, 990, 1004, 1018, 1027, 1043],
    # Literka o 
    [1082, 1074, 1075, 1088, 1099, 1088, 1067, 1049, 1049, 1059, 1063],
    # Literka w 
    [1104, 1121, 1121, 1115, 1119, 1143, 1164, 1176, 1183, 1175],
    # Literka an
    [1218, 1217, 1201, 1193, 1203, 1220, 1237, 1236, 1254, 1283, 1281, 1293, 1318, 1313, 1319],
    # Literka i 
    [1347, 1336, 1347],
    [1368, 1369, 1364],
    # Literka a
    [1393, 1388, 1376, 1368, 1377, 1395, 1409, 1411, 1429],
    # buźka
    [1580, 1581, 1576, 1572, 1577],
    [1585, 1588, 1585, 1580, 1583, 1585],
    [1600, 1614, 1617],
    [1642, 1654, 1651, 1639],

]


'''
    Poniżej znajduje się tablica z danymi współrzędnych y-owych punktów interpolacji.
    Każdy wiersz to dane jednej krzywej NIFS3.
    Punkty wyznaczane były używając własnego narzędzia wyznaczania tych punktów 
    z pliku interpolates_selector.py
'''
ys = [
    # Literka P
    [627, 546, 427, 473, 570, 629, 623, 554, 518],
    # Literka W
    [615, 548, 462, 490, 544, 514, 467, 526, 603],
    # Literka O
    [577, 602, 574, 526, 482, 473, 500, 549, 606, 608, 585],
    # Plusik 1
    [528, 539],
    [573, 550, 528, 511],
    # Plusik 2
    [555, 557, 556, 522, 546, 583],
    # Literka t
    [626, 645, 616, 570, 529],
    [572, 572, 579, 572, 571],
    # Literka o
    [566, 575, 556, 532, 543, 568, 585, 591, 580],
    # Literka n
    [575, 584, 551, 579, 589, 576, 557, 546],
    # Literki aj
    [566, 586, 573, 555, 566, 582, 565, 557, 568, 586, 562, 525, 485, 453],
    [610, 603],
    # Literki le
    [623, 593, 554, 538, 549, 575, 587, 574, 548, 528],
    # Literka p
    [573, 518, 484, 477, 489, 504, 553, 587, 558, 537],
    # Literki rzy
    [587, 549, 589, 592, 580, 566, 545, 539, 548, 564, 588, 571, 571, 594, 571, 405],
    # Literka j
    [229, 210, 181, 93, 78],
    [281, 266, 258],
    # Literka ę
    [197, 192, 201, 219, 224, 206, 174, 162, 151, 152],
    # Literki zy
    [223, 207, 183, 166, 177, 201, 216, 198, 192, 202, 217, 184, 141, 99],
    # Literka k
    [267, 237, 202, 185, 202, 236, 228, 206, 193],
    # Literki pr
    [220, 232, 236, 213, 174, 109, 118, 144, 178, 209, 238, 229, 202, 188, 214, 231, 207, 194, 228, 227],
    # Literka o
    [225, 231, 237, 241, 237, 218, 202, 195, 201, 215, 227, 237, 235, 232],
    # Literki gr
    [236, 243, 219, 201, 213, 246, 174, 120, 199, 239, 222, 200, 242],
    # Literka a 
    [244, 246, 235, 222, 211, 204, 205, 217, 242, 215, 201, 195],
    # Literka m
    [239, 211, 219, 230, 234, 225, 231, 217, 211],
    # Literka o 
    [217, 223, 236, 241, 222, 205, 199, 204, 222, 232, 225],
    # Literka w
    [223, 245, 234, 221, 214, 232, 214, 213, 230, 244],
    # Literka an
    [236, 242, 237, 222, 213, 218, 245, 221, 217, 248, 227, 223, 244, 224, 213],
    # Literka i 
    [249, 219, 214],
    [266, 258, 240],
    # Literka a
    [243, 248, 240, 222, 215, 219, 243, 226, 207],
    # Buźka
    [276, 269, 266, 273, 270],
    [241, 239, 236, 238, 239, 238],
    [255, 260, 256],
    [296, 248, 232, 211],

]


'''
    lista 'momentów w czasie' punktów interpolacji, wyznaczane używając powyższej 
    funkcji create_ts()
'''
ts = [create_ts(xs[i], ys[i]) for i in range(len(xs))]


'''
    Poniżej znajduje się lista punktów do rysowania, obieranych za pomocą własnego
    narzędzia znajdującego się w pliku drawpoints_selector.py
    Wartości punktów są z zakresu 0 - 1 i odpowiadają proporcji odległości punktów
    rysowania do odległości wszystkich punktów interpolacji 
'''
Ms = [
    # Literka P
    [0.0, 0.07, 0.21, 0.31, 0.35, 0.39, 0.42, 0.46, 0.50, 0.53, 0.56, 0.58, 0.60, 0.62, 0.66, 0.69, 0.72, 0.75, 0.79, 0.83, 0.86, 0.89, 0.93, 0.95, 0.97, 1.0],
    # Literka W
    [0.0, 0.06, 0.13, 0.21, 0.28, 0.31, 0.33, 0.36, 0.40, 0.42, 0.44, 0.46, 0.49, 0.53, 0.57, 0.61, 0.66, 0.69, 0.72, 0.75, 0.78, 0.81, 0.86, 0.88, 0.91, 0.94, 1.0],
    # Literka O
    [0.0, 0.03, 0.06, 0.07, 0.08, 0.12, 0.16, 0.21, 0.26, 0.32, 0.37, 0.42, 0.46, 0.49, 0.53, 0.57, 0.60, 0.63, 0.67, 0.70, 0.74, 0.77, 0.79, 0.81, 0.84, 0.87, 0.89, 0.91, 0.94, 0.95, 0.97, 1.0],
    # Plusik 1
    [0.0, 1.0],
    [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
    # Plusik 2
    [0.0, 0.16, 0.31, 0.4, 0.66, 0.79, 0.9, 1.0],
    # Literka t
    [0.0, 0.15, 0.35, 0.5, 0.7, 0.85, 1.0],
    [0.0, 0.3, 0.5, 0.7, 1.0],
    # Literka o
    [0.0, 0.05, 0.11, 0.15, 0.21, 0.28, 0.32, 0.37, 0.45, 0.5, 0.55, 0.64, 0.73, 0.81, 0.86, 0.88, 0.92, 0.96, 1.0],
    # Literka n
    [0.0, 0.1, 0.18, 0.3, 0.34, 0.4, 0.45, 0.53, 0.62, 0.68, 0.75, 0.85, 0.92, 1.0],
    # Literki aj
    [0.0, 0.01, 0.03, 0.07, 0.11, 0.14, 0.18, 0.2, 0.23, 0.25, 0.27, 0.3, 0.33, 0.35, 0.39, 0.42, 0.45, 0.48, 0.5, 0.52, 0.55, 0.57, 0.6, 0.63, 0.77, 0.86, 0.93, 1.0],
    [0.0, 0.4, 1.0],
    # Literki le
    [0.0, 0.06, 0.12, 0.21, 0.3, 0.36, 0.41, 0.46, 0.52, 0.57, 0.62, 0.67, 0.7, 0.72, 0.73, 0.78, 0.83, 0.89, 0.94, 1.0],
    # Literka p
    [0.0, 0.1, 0.19, 0.27, 0.32, 0.34, 0.37, 0.41, 0.45, 0.51, 0.57, 0.7, 0.77, 0.8, 0.83, 0.87, 0.92, 0.95, 1.0],
    # Literki rzy
    [0.0, 0.07, 0.09, 0.13, 0.14, 0.15, 0.17, 0.21, 0.26, 0.3, 0.33, 0.35, 0.37, 0.39, 0.41, 0.43, 0.46, 0.5, 0.52, 0.54, 0.57, 0.59, 0.62, 0.66, 0.8, 0.9, 1.0],
    # Literka j 
    [0, np.float64(0.07), np.float64(0.16), np.float64(0.24), np.float64(0.81), np.float64(0.93), np.float64(1.0)],
    [0, 0.3, 0.6, 1.0],
    # Literka ę
    [0, np.float64(0.18), np.float64(0.21), np.float64(0.23), np.float64(0.25), np.float64(0.28), np.float64(0.31), np.float64(0.33), np.float64(0.36), np.float64(0.4), np.float64(0.43), np.float64(0.45), np.float64(0.48), np.float64(0.52), np.float64(0.55), np.float64(0.58), np.float64(0.61), np.float64(0.64), np.float64(0.68), np.float64(0.7), np.float64(0.74), np.float64(0.76), np.float64(0.78), np.float64(0.81), np.float64(0.84), np.float64(0.85), np.float64(0.87), np.float64(0.9), np.float64(0.91), np.float64(0.93), np.float64(0.96), np.float64(0.98), np.float64(1.0)],
    # Literki zy
    [0, np.float64(0.03), np.float64(0.08), np.float64(0.12), np.float64(0.14), np.float64(0.18), np.float64(0.21), np.float64(0.22), np.float64(0.23), np.float64(0.25), np.float64(0.27), np.float64(0.29), np.float64(0.34), np.float64(0.38), np.float64(0.4), np.float64(0.42), np.float64(0.43), np.float64(0.43), np.float64(0.45), np.float64(0.48), np.float64(0.49), np.float64(0.5), np.float64(0.52), np.float64(0.55), np.float64(0.56), np.float64(0.59), np.float64(0.61), np.float64(0.64), np.float64(0.66), np.float64(0.7), np.float64(0.77), np.float64(0.84), np.float64(0.93), np.float64(1.0)],    
    # Literka k
    [0, np.float64(0.07), np.float64(0.16), np.float64(0.27), np.float64(0.37), np.float64(0.42), np.float64(0.43), np.float64(0.46), np.float64(0.5), np.float64(0.58), np.float64(0.65), np.float64(0.69), np.float64(0.71), np.float64(0.74), np.float64(0.77), np.float64(0.79), np.float64(0.83), np.float64(0.88), np.float64(0.89), np.float64(0.9), np.float64(0.96), np.float64(1.0)],
    # Literki pr
    [0, np.float64(0.01), np.float64(0.03), np.float64(0.03), np.float64(0.04), np.float64(0.06), np.float64(0.06), np.float64(0.1), np.float64(0.14), np.float64(0.19), np.float64(0.22), np.float64(0.25), np.float64(0.27), np.float64(0.28), np.float64(0.29), np.float64(0.3), np.float64(0.31), np.float64(0.32), np.float64(0.33), np.float64(0.35), np.float64(0.38), np.float64(0.41), np.float64(0.43), np.float64(0.45), np.float64(0.46), np.float64(0.49), np.float64(0.51), np.float64(0.54), np.float64(0.55), np.float64(0.57), np.float64(0.58), np.float64(0.59), np.float64(0.6), np.float64(0.62), np.float64(0.64), np.float64(0.66), np.float64(0.67), np.float64(0.69), np.float64(0.7), np.float64(0.71), np.float64(0.72), np.float64(0.73), np.float64(0.75), np.float64(0.76), np.float64(0.77), np.float64(0.79), np.float64(0.8), np.float64(0.81), np.float64(0.82), np.float64(0.83), np.float64(0.83), np.float64(0.83), np.float64(0.85), np.float64(0.86), np.float64(0.88), np.float64(0.89), np.float64(0.9), np.float64(0.91), np.float64(0.91), np.float64(0.93), np.float64(0.94), np.float64(0.95), np.float64(0.96), np.float64(0.97), np.float64(0.98), np.float64(0.99), np.float64(1.0)],
    # Literka o 
    [0, np.float64(0.03), np.float64(0.07), np.float64(0.1), np.float64(0.11), np.float64(0.14), np.float64(0.18), np.float64(0.2), np.float64(0.24), np.float64(0.29), np.float64(0.34), np.float64(0.38), np.float64(0.43), np.float64(0.48), np.float64(0.52), np.float64(0.58), np.float64(0.59), np.float64(0.64), np.float64(0.66), np.float64(0.71), np.float64(0.73), np.float64(0.77), np.float64(0.78), np.float64(0.85), np.float64(0.85), np.float64(0.89), np.float64(0.92), np.float64(0.95), np.float64(0.97), np.float64(1.0)],
    # Literki gr
    [0, np.float64(0.01), np.float64(0.02), np.float64(0.03), np.float64(0.04), np.float64(0.06), np.float64(0.07), np.float64(0.08), np.float64(0.1), np.float64(0.11), np.float64(0.12), np.float64(0.13), np.float64(0.14), np.float64(0.15), np.float64(0.17), np.float64(0.18), np.float64(0.2), np.float64(0.23), np.float64(0.24), np.float64(0.26), np.float64(0.3), np.float64(0.36), np.float64(0.4), np.float64(0.44), np.float64(0.47), np.float64(0.49), np.float64(0.51), np.float64(0.53), np.float64(0.55), np.float64(0.59), np.float64(0.65), np.float64(0.69), np.float64(0.74), np.float64(0.78), np.float64(0.79), np.float64(0.81), np.float64(0.84), np.float64(0.87), np.float64(0.88), np.float64(0.9), np.float64(0.93), np.float64(0.97), np.float64(0.99), np.float64(1.0)],
    # Literka a 
    [0, np.float64(0.03), np.float64(0.05), np.float64(0.06), np.float64(0.1), np.float64(0.16), np.float64(0.22), np.float64(0.26), np.float64(0.3), np.float64(0.32), np.float64(0.37), np.float64(0.41), np.float64(0.45), np.float64(0.48), np.float64(0.52), np.float64(0.57), np.float64(0.63), np.float64(0.68), np.float64(0.69), np.float64(0.73), np.float64(0.79), np.float64(0.83), np.float64(0.89), np.float64(0.93), np.float64(0.98), np.float64(1.0)],
    # Literka m
    [0, np.float64(0.1), np.float64(0.17), np.float64(0.2), np.float64(0.23), np.float64(0.28), np.float64(0.33), np.float64(0.36), np.float64(0.39), np.float64(0.39), np.float64(0.45), np.float64(0.48), np.float64(0.51), np.float64(0.57), np.float64(0.61), np.float64(0.67), np.float64(0.73), np.float64(0.73), np.float64(0.84), np.float64(0.89), np.float64(0.96), np.float64(1.0)],
    # Literka o
    [0, np.float64(0.01), np.float64(0.05), np.float64(0.07), np.float64(0.1), np.float64(0.12), np.float64(0.19), np.float64(0.2), np.float64(0.25), np.float64(0.31), np.float64(0.34), np.float64(0.39), np.float64(0.44), np.float64(0.48), np.float64(0.53), np.float64(0.58), np.float64(0.63), np.float64(0.64), np.float64(0.66), np.float64(0.71), np.float64(0.74), np.float64(0.77), np.float64(0.82), np.float64(0.84), np.float64(0.89), np.float64(0.94), np.float64(0.97), np.float64(1.0)],
    # Literka w
    [0, np.float64(0.06), np.float64(0.11), np.float64(0.14), np.float64(0.16), np.float64(0.2), np.float64(0.25), np.float64(0.31), np.float64(0.34), np.float64(0.36), np.float64(0.39), np.float64(0.45), np.float64(0.5), np.float64(0.56), np.float64(0.6), np.float64(0.64), np.float64(0.69), np.float64(0.72), np.float64(0.75), np.float64(0.77), np.float64(0.79), np.float64(0.83), np.float64(0.84), np.float64(0.88), np.float64(0.92), np.float64(0.96), np.float64(1.0)],
    # Literka an
    [0, np.float64(0.01), np.float64(0.02), np.float64(0.04), np.float64(0.06), np.float64(0.07), np.float64(0.1), np.float64(0.12), np.float64(0.14), np.float64(0.15), np.float64(0.17), np.float64(0.19), np.float64(0.21), np.float64(0.23), np.float64(0.24), np.float64(0.28), np.float64(0.32), np.float64(0.37), np.float64(0.4), np.float64(0.43), np.float64(0.46), np.float64(0.47), np.float64(0.48), np.float64(0.51), np.float64(0.53), np.float64(0.55), np.float64(0.58), np.float64(0.61), np.float64(0.65), np.float64(0.66), np.float64(0.7), np.float64(0.72), np.float64(0.75), np.float64(0.77), np.float64(0.8), np.float64(0.82), np.float64(0.86), np.float64(0.89), np.float64(0.94), np.float64(0.99), np.float64(1.0)],
    # Literka i 
    [0, np.float64(0.22), np.float64(0.3), np.float64(0.46), np.float64(0.58), np.float64(0.68), np.float64(0.72), np.float64(0.77), np.float64(0.82), np.float64(0.89), np.float64(1.0)],
    [0, np.float64(0.16), np.float64(0.31), np.float64(0.43), np.float64(0.76), np.float64(1.0)],
    # Literka a 
    [0, np.float64(0.01), np.float64(0.05), np.float64(0.08), np.float64(0.13), np.float64(0.2), np.float64(0.23), np.float64(0.27), np.float64(0.32), np.float64(0.37), np.float64(0.41), np.float64(0.48), np.float64(0.54), np.float64(0.59), np.float64(0.63), np.float64(0.7), np.float64(0.77), np.float64(0.83), np.float64(0.88), np.float64(0.93), np.float64(1.0)],
    # Buźka
    np.linspace(0, 1, 6),
    np.linspace(0, 1, 5),
    [0, np.float64(0.23), np.float64(0.48), np.float64(0.55), np.float64(0.68), np.float64(0.8), np.float64(1.0)],
    [0, np.float64(0.25), np.float64(0.39), np.float64(0.56), np.float64(0.68), np.float64(0.77), np.float64(0.84), np.float64(0.91), np.float64(1.0)]

]


'''
    Poniżej znajduje się funkcja create_NIFS3, która przyjmuje zestaw:
    - wektor xs - współrzędne x-owe punktów interpolacji do narysowania krzywej NIFS3 
    - wektor ys - współrzędne y-owe punktów interpolacji do narysowania krzywej NIFS3 
    - wektor t - momenty w czasie punktów interpolacji do narysownia krzywej NIFS3
    - wektor draw_pts - zawierający dane punktów do rysowania (wektor u)
    Oraz zwraca wektory x, y odpowiadające współrzędnym punktów do rysowania na krzywej NIFS3
'''
def create_NIFS3(xs, ys, t, draw_pts) : 
    n = len(xs)
    p = [0] 
    q = [0] 
    h = [t[i] - t[i-1] for i in range(1, n)]
    h.insert(0,0)
    lbda = [h[i] / (h[i] + h[i+1]) for i in range(n-1)]
    lbda.insert(0,0)
    dx = [0] 
    dy = [0] 
    ux = [0] 
    uy = [0] 

    for i in range(1, n-1):
        p.append(lbda[i] * q[i-1] + 2)
        q.append((lbda[i] - 1) / p[i])

    for i in range(1, n-1): 
        dx.append(6*(1/(t[i+1] - t[i-1]) * (((xs[i+1] - xs[i]) / (t[i+1] - t[i])) - ((xs[i] - xs[i-1]) / (t[i] - t[i-1])))))
        dy.append(6*(1/(t[i+1] - t[i-1]) * (((ys[i+1] - ys[i]) / (t[i+1] - t[i])) - ((ys[i] - ys[i-1]) / (t[i] - t[i-1])))))

    for i in range(1, n-1):
        ux.append((dx[i] - lbda[i] * ux[i-1])/p[i])
        uy.append((dy[i] - lbda[i] * uy[i-1])/p[i])


    Mx = [ux[n-2], 0]
    My = [uy[n-2], 0]

    for i in range(n-3, 0, -1):
        Mx.insert(0, ux[i] + q[i] * Mx[0])
        My.insert(0, uy[i] + q[i] * My[0])

    Mx.insert(0,0)
    My.insert(0,0)

    def S(draw_pts, pts, Moment):
        results = []
        k = 1
        for i in range(len(draw_pts)):
            if draw_pts[i] > t[k]:
                k += 1
            results.append(((Moment[k-1]/6)*(t[k]-draw_pts[i])**3 + (Moment[k]/6)*(draw_pts[i]-t[k-1])**3 + (pts[k-1] - (Moment[k-1]/6)*h[k]**2)*(t[k]-draw_pts[i]) + (pts[k] - (Moment[k]/6)*h[k]**2)*(draw_pts[i]-t[k-1])) / h[k] )
        return results

    x_values = S(draw_pts, xs, Mx)
    y_values = S(draw_pts, ys, My)
    return x_values, y_values



'''
    Wywołując z terminala plik main.py otwiera nam się wykres - odtworzenie napisu - 
    czyli essentially rozwiązanie konkursu, odkomentowując niektóre linie poniżej
    można testować wyniki lub podglądać punkty interpolacji i rysowania na wykresie
'''
if __name__ == '__main__':  
    plt.figure(figsize=(12,6))
    # 1786 x 738 - rozdzielczość obrazku bazowego

    for k in range(len(xs)):
        x_v, y_v = create_NIFS3(xs[k], ys[k], ts[k], Ms[k])
        #x_v, y_v = create_NIFS3(xs[k], ys[k], ts[k], np.linspace(0, 1, 1000)) # do testów punktów interpolacji
        plt.plot(x_v, y_v, color = 'blue') # przybliżony napis
        #plt.scatter(x_v, y_v, color="green", s=20) # punkty do rysowania
        #plt.scatter(xs[k], ys[k], color="red", s=7) # punkty interpolacji

    
    plt.xlim(0, 1786)  
    plt.ylim(0, 738)
    plt.show()
    print("Ilość NIFS3: " + str(len(xs)))
    print("Liczba punktów interpolacji: " + str(sum(len(l) for l in xs)))
    print("Liczba punktów rysowania: " + str(sum(len(l) for l in Ms)))
            