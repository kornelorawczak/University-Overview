#include <iostream>
#include <cmath>

using namespace std;
//zad7
double f(double x) {
    return 8096.0 * ((sqrt(pow(x,13.0) + 4.0) - 2.0) / pow(x, 14.0));
}
double f2(double x) {
    return 1.0 / (x * (sqrt(pow(x, 13.0) + 4.0) + 2.0));
}
//zad8
double g(double x) {
    return 1518.0 * (2.0 * x - sin(2.0 * x)) / (x * x * x);
}

double g2(double x) {
    int prec = 10;
    double result = 1.0;
    double pow = 1.0;
    double fact = 1.0;
    for (int i = 1; i <= prec; i++) {
        pow *= x * x * 2 * 2;
        fact *= (2 * i + 2) * (2 * i + 3);
        result += (i % 2 == 0 ? 1.0 : -1.0) * pow / fact;
    }
    return result * 2024.0;
}

//zad9
void h(int k) {
    double x = 2.0;
    for (int i = 1; i <= k; i++) {
        double next = pow(2.0, i) * sqrt(2.0 * (1.0 - sqrt(1.0 - pow(x / pow(2.0, i), 2.0))));
        cout << "x(" << i + 1 << ") = " << next << endl;
        x = next;
    }
}

void h2(int k) {
    double x = 2.0;
    for (int i = 1; i <= k; i++) {
        double next = sqrt((2.0 * pow(x, 2.0)) / (1.0 + sqrt(1.0 - pow(x / pow(2.0, i), 2.0))));
        cout << "x(" << i + 1 << ") = " << next << endl;
        x = next;
    }
}


int main() {
    // cout << f(0.001) << endl;
    // double x = 0.1;
    // while (x > pow(10,-10)) {
    //     x /= 10;
    //     cout << f2(x) << endl;
    // }
    // cout << pow(0.001, 13.0) + 4.0 << endl;

    //cout << g(pow(10, -11)) << endl;
    //cout << g2(pow(10, -2)) << endl;

    h(40);
    h2(400);
}