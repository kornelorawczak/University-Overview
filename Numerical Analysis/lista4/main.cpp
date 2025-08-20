#include <iostream>
#include <cmath>

using namespace std;

double f(double x) {
    return x - 0.49;
}

void zad3() {
    double a = 0.0;
    double b = 1.0;
    double alpha = 0.49;
    double en = 1.0;
    for (int i = 1; i < 6; i++) {
        double mid = (a + b) / 2.0;
        en /= 2;
        double fa = f(a);
        double fx = f(mid);
        if (fx * fa < 0 ) {
            b = mid;
        }
        else {
            a = mid;
        }
        cout << "Dla kroku " << i << ", mamy blad: " << abs(alpha - mid) << ", oszacowanie |en| <= " << en << endl;
    }
}

double g(double x) {
    return pow(x, 2.0) - atan(x + 2.0);
}

void zad4() {
    double a = -2.0;
    double b = 0.0;
    int i = 0;
    while ((b - a) > 1e-6) {
        i+=1;
        double mid = (a + b) / 2.0;
        double fa = g(a);
        double fx = g(mid);
        if (fx * fa < 0 ) {
            b = mid;
        }
        else {
            a = mid;
        }
    }
    cout << "x1 = " << (a + b) / 2.0 << endl;
    cout << i << endl;
    b = 2.0;
    a = 0.0;
    i = 0;
    while ((b - a) > 1e-6) {
        i+=1;
        double mid = (a + b) / 2.0;
        double fa = g(a);
        double fx = g(mid);
        if (fx * fa < 0 ) {
            b = mid;
        }
        else {
            a = mid;
        }
    }
    cout << "x2 = " << (a + b) / 2.0 << endl;
    cout << i << endl;
}

void zad5(double R, double x0, int k) {
    double prev = x0;
    double next;
    for (int i = 1; i <= k; i++) {
        next = prev * (2.0 - prev * R);
        cout << "x" << i << " = " << next << endl;
        prev = next;
    }
}

void zad6(double a, double x0, int k) {
    double prev = x0;
    double next;
    for (int i = 1; i <= k; i++) {
        next = 0.5 * prev * (3.0 - prev * prev * a);
        cout << "x" << i << " = " << next << endl;
        prev = next;
    }
}


void zad7(double a, double x0, int j) {
    int c = 0;
    double m;
    int k;
    while (a > 2.0) {
        c++;
        a /= 2.0;
    }
    if (c % 2 != 0) {
        k = (c - 1) / 2;
        m = 2.0 * a;
    }
    else {
        k = c / 2;
        m = a;
    }


    double prev = abs(x0); // - i tak chcemy tylko dodatnie;
    double next;
    for (int i = 1; i <= j; i++) {
        next = 0.5 * ( prev + m / prev );
        cout << "a" << i << " = " << next << " * 2^" << k << endl;
        prev = next;
    }
}

void zad9(double x0, int k) {
    double prev = x0;
    double next;
    for (int i = 1; i <= k; i++) {
        next = prev - (prev - 2.0) / 3.0;
        cout << "x" << i << " = " << next << endl;
        prev = next;
    }
}

int main() {
    //zad3();
    //zad4();

    //zad5(5, 0.1, 10); // dla przybliżania 0.2 potrzeba 5 iteracji
    //zad5(3, 0.2, 10); // 4 iteracje
    //zad5(3, 0.4, 10); // dla takiego x0 też 4 iteracje

    //zad6(9, 0.2, 10); // 5 iteracji
    //zad6(9, 0.5, 10); // 6 iteracji
    //zad6(64, 0.525, 100); // poza zakresem zbieżności
    //zad6(64, 0.2, 10); // 7 iteracji

    //zad7(40.210384, 0.1, 10); // poprawnie dla wszystkich x0


    //zad9(1.5, 100); // potrzeba aż 29 wyrazów
    return 0;
}
