import numpy as np

def horner_division(coefficients, a): 
    # W tym zadaniu zawsze dzielimy bez reszty
    # przyjmujemy że x^2 - 1 jest reprezentowane jako [1, 0, -1]
    n = len(coefficients)
    result = [0] * (n - 1)
    result[0] = coefficients[0]
    for i in range(1, n - 1):
        result[i] = coefficients[i] + result[i - 1] * a
    return result

def iloczynowa_to_potegowa(roots):
    coefficients = [1]
    for root in roots:
        new_coefs = [0] * (len(coefficients) + 1)
        for i in range(len(coefficients)):
            new_coefs[i] += coefficients[i]
            new_coefs[i + 1] -= coefficients[i] * root
        coefficients = new_coefs
    return coefficients

def derivative(coefficients):
    n = len(coefficients)
    if n <= 1:
        return [0]
    return [coefficients[i] * (n - i - 1) for i in range(0, n - 1)]

    

def polynomial_value(coefficients, x):
    n = len(coefficients)
    returnal = 0
    for i in range(n):
        returnal += coefficients[i] * (x ** (n - i - 1))
    return returnal

def integral(coefficients, a, b):
    n = len(coefficients)
    integral_coefs = [coeff / (n - i) for i, coeff in enumerate(coefficients)]
    integral_coefs.append(0)
    return polynomial_value(integral_coefs, b) - polynomial_value(integral_coefs, a)

def add_reversed(tab, p):
    # p = 0 lub = 1 w zależności od parzystości wyjściowej tablicy
    temp = list(tab)
    for el in list(reversed(temp))[p::]:
        tab.append(el)
    return tab

def QNC(f, n, a, b):
    A = []
    mid = n // 2 + 1
    h = (b - a) / n
    roots = [j for j in range(n + 1)]
    P = iloczynowa_to_potegowa(roots)
    dP = derivative(P)
    for k in range(n + 1):
        if (k >= mid):
           break
        else:
            currentP = horner_division(P, k)
            integratedP = integral(currentP, 0, n)
            A.append(h * integratedP / polynomial_value(dP, k))
    A = add_reversed(A, (n + 1) % 2) 
    # dla czytelności nowa pętla
    returnal = 0
    for k in range(n + 1):
        returnal += A[k] * f(a + k * h)
    return returnal


# całka cos(x) od -3 do 4 symbolicznie = -0,615682
print(QNC(lambda x : np.cos(x), 10, -3, 4))
# całka 1/x od 1 do 2 symbolicznie = 0,693147
print(QNC(lambda x : 1/x, 10, 1, 2))
# całka 1 / (1 + x^2) od -5 do 5 symbolicznie = 2,7468
# efekt rungego
print(QNC(lambda x : (1/(x**2 + 1)), 7, -5, 5))





