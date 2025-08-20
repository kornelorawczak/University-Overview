#include <iostream>
#include <cmath>
#include <iomanip>
#include <math.h>
using namespace std;

double zad1a(double x) {
    return 1.0 / (pow(x, 5.0) + sqrt(pow(x,10.0) + 2024.0));
}

double zad1a_fix(double x) {
    if (x >= 0.0) { return zad1a(x); }
    return (-1.0 * pow(x, 5.0) + sqrt(pow(x, 10.0) + 2024.0)) / 2024.0;

}


double zad1b(double x) {
    return pow(10.0, 8.0) * (pow(M_E, x) - pow(M_E, 2.0 * x));
}

double zad1b_fix(double x) {
    return pow(10.0, 8.0) * (-x - 3.0*pow(x, 2.0)/2.0 - 7.0*pow(x, 3.0)/6.0 - 15.0*pow(x, 4.0)/24.0);
}

double zad1c(double x) {
    return 6.0 * (asin(x) - x)/ pow(x, 3.0);
}

double zad1c_fix(double x) {
    return 1.0 + (9.0 * pow(x, 2.0))/20.0 ;
}


double zad1d(double x) {
    return 4.0 * pow(cos(x), 2.0) - 1.0;
}

double zad1d_fix(double x) {
    return (2.0 * cos(x) + 1.0) * (1.0 - pow(x, 2.0) + pow(x, 4.0) / 12.0 - pow(x, 6.0) / 360.0) + pow(x, 8.0) / 20160.0;
}


void zad2(double a, double b, double c) {
    double delta = sqrt(pow(b, 2.0) - 4.0 * a * c);
    double x1 = (-b - delta) / (2.0 * a);
    double x2 = (-b + delta) / (2.0 * a);
    cout << "x1 = " << x1 << endl;
    cout << "x2 = " << x2 << endl;
}

void zad2fixed(double a, double b, double c) {
    double x1, x2;
    double delta = sqrt(pow(b, 2.0) - 4.0 * a * c);
    if (b >= 0) {
        x1 = (-b - delta) / (2.0 * a);
        x2 = c / (a * x1);
    }
    else {
        x2 = ((-b + delta) / (2.0 * a));
        x1 = c / (a * x2);
    }
    cout << "x1 = " << x1 << endl;
    cout << "x2 = " << x2 << endl;
}


int main() {
    // ZAD 1
    for (int i = 1; i <= 20; i++) {
        //a
        //cout << zad1a(-1.0 * pow(10.0, i)) << " | " << zad1a_fix(-1.0 * pow(10.0, i)) << endl; // powinno dazyc do +inf

        //b
        cout << zad1b(pow(10.0, -1.0 * i)) << " | " << zad1b_fix(pow(10, -1.0 * i)) << endl;

        //c
        //cout << zad1c(pow(10.0, -1.0 * i)) << " | " << zad1c_fix(pow(10.0, -1.0 * i))<< endl;
    }

    //d
    //cout << zad1d(M_PI/3.0) << " | " << zad1d_fix(M_PI/3.0) << endl;

    // ZAD 2 -> testy dla duzego b i bardzo malego a i c
    // cout << setprecision(10);
    // zad2(pow(10.0, -5.0), pow(10.0, 5.0), pow(10.0, -5.0)); //x1 dobrze wyznaczone, x2 zaokraglone do 0 mimo tego ze tyle nie wynosi na pewno
    // zad2fixed(pow(10.0, -5.0), pow(10.0, 5.0), pow(10.0, -5.0)); //tutaj dobrze oba

    return 0;
}