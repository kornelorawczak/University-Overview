#include <iostream>
#include <iomanip>
#include <cmath>
#include <math.h>

using namespace std;

float single_f3(float x) {
    return 1518.0f * (2.0f * x - sin(2.0f * x)) / (x * x * x);
}

double double_f3(double x) {
    return 1518.0 * (2.0 * x - sin(2.0 * x)) / (x * x * x);
}

void zadanie3() {
    cout << "Pojedyncza precyzja: " << endl;
    for (int i = 1; i <= 20; i++) {
        cout <<  "f(10^-" << i << ") = " << single_f3(pow(10, -i)) << endl;
    }
    cout << endl << "Podwojna precyzja: " << endl;
    for (int i = 1; i <= 20; i++) {
        cout << "f(10^-" << i << ") = " << double_f3(pow(10, -i)) << endl;
    }
}

float* single_f4(int n) {
    static float R[51];
    R[0] = 1.f;
    R[1] = -1/6.f;
    for (int i = 2; i <= n; i++) {
        R[i] = (35/6.f) * R[i-1] + R[i-2];
    }
    return R;
}

double* double_f4(int n) {
    static double R[51];
    R[0] = 1.0;
    R[1] = -1/6.0;
    for (int i = 2; i <= n; i++) {
        R[i] = (35/6.0) * R[i-1] + R[i-2];
    }
    return R;
}

void zadanie4() {
    cout << "Pojedyncza precyzja: " << endl;
    float* single = single_f4(50);
    for (int i = 2; i <= 50; i++) {
        cout << "y" << i << " = " << single[i] << endl;
    }
    cout << endl << "Podwojna precyzja: " << endl;
    double* dble = double_f4(50);
    for (int i = 2; i <= 50; i++) {
        cout << "y" << i << " = " << dble[i] << endl;
    }
}

int zadanie6() {
    double wyraz;
    int k = 0;
    do {
        k++;
        wyraz = 4 * (k % 2 == 0 ? 1.0 : -1.0) / (2.0 * k + 1.0);
    } while (abs(wyraz) > 1e-6);
    return k;
}

double maclaurin_sin(int k, double x) {
    double sin = 0.0;
    double fact = 1.0;
    double pow = x;
    for (int i = 0; i <= k; i++) {
        sin += (i % 2 == 0 ? 1.0 : -1.0) * pow / fact;
        cout << sin << endl;
        fact *= (2*i + 2) * (2*i + 3);
        pow *= x * x;
    }
    return sin;
}

void zadanie8(double x) {
    if (x > 2) {
        int i = 1;
        int pow = 2;
        while (pow < x) {
            i++;
            pow *= 2;
        }
        //cout << i - 1 << endl;
        //cout << x / (pow / 2.0f) << endl;
        cout << i - 1 << " + log2(" << x / (pow / 2.0f) << ")";
    }
    else if (x < 1) {
        cout << "[-1] * (";
        zadanie8(1.0/x);
        cout << ")" << endl;
    }
    else {
        cout << "log2(" << x << ")";
    }
}

void zadanie5() {
    double prev = log(2025.0/2024.0);
    cout << setprecision(10);
    cout << "I0 = " << prev << endl;
    for (int i = 1; i <= 20; i++) {
        double next = 1.0/i - 2024.0*prev;
        cout << "I" << i << " = " << next << endl;
        prev = next;
    }
    cout << endl;
    prev = log(2025.0/2024.0);
    cout << "I0 = " << prev << endl;
    cout << "I1 = " << 1.0 - 2024.0*prev << endl;
    prev = 1.0 - 2024.0*prev;
    for (int i = 3; i <= 19; i+=2) {
        double next = 1.0/i - 2024.0 * (1.0/(i-1.0) - 2024*prev);
        cout << "I" << i << " = " << next << endl;
        prev = next;
    }
    cout << endl;
    prev = log(2025.0/2024.0);
    cout << "I0 = " << prev << endl;
    for (int i = 2; i <= 20; i+=2) {
        double next = 1.0/i - 2024.0 * (1.0/(i-1.0) - 2024*prev);
        cout << "I" << i << " = " << next << endl;
        prev = next;
    }
}


int main() {
    //zad3
    //zadanie3();

    //zad4
    //zadanie4();

    //zad5
    //zadanie5();

    //zad6
    //cout << zadanie6() << endl;;

    // zad7
    maclaurin_sin(50, 2.0 * M_PI);

    //zad8
    // cout << "log2(520) = ";
    // zadanie8(520);
    // cout << endl;
    // cout << "log2(1/520) = ";
    // zadanie8(1/520.0);
    // cout << "log2(0.9) = ";
    // zadanie8(0.9);


    return 0;
}
