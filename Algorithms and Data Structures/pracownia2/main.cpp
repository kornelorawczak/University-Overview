#include <iostream>
#include <vector>

using namespace std;

class Kopiec {
    private:
        vector<vector<long long> > K;
        long long n;
    public:
        Kopiec(long long l, long long i, long long j) {
            vector<long long> placeholder;
            placeholder.push_back(-1);
            placeholder.push_back(-1);
            placeholder.push_back(-1);
            this->K.push_back(placeholder); // dorownanie indeksow
            vector<long long> starter;
            starter.push_back(l);
            starter.push_back(i);
            starter.push_back(j);
            this->K.push_back(starter);
            this->n = 1;
        }
        void przesun_nizej(long long i) {
            long long k = i;
            long long j;
            do {
                j = k;
                if (2*j <= this->n && this->K[2*j][0] > this->K[k][0]) k = 2*j;
                if (2*j + 1 <= this->n && this->K[2*j + 1][0] > this->K[k][0]) k = 2*j + 1;
                swap(this->K[j], this->K[k]);  
            } while (j != k);
        }
        void przesun_wyzej(long long i) {
            long long k = i;
            long long j;
            do {
                j = k;
                if (j > 1 && this->K[j/2][0] < this->K[k][0]) k = j/2;
                swap(this->K[j], this->K[k]);
            } while (j != k);
        }
        vector<long long> pop_max() {
            vector<long long> temp = K[1];
            swap(this->K[1], this->K[n]);
            this->K.pop_back();
            this->n--;
            przesun_nizej(1);
            return temp;
        }
        void insert(long long x, long long i, long long j) {
            vector<long long> number;
            number.push_back(x);
            number.push_back(i);
            number.push_back(j);
            this->K.push_back(number);
            this->n++;
            przesun_wyzej(this->n);
        }
        void print() {
            for (auto v : this->K) {
                cout << v[0] << " ";
            }
        }
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(NULL);
    long long M, k;
    cin >> M >> k; 
    Kopiec heap = Kopiec(M*M, M, M);
    long long previous = M*M + 1;
    while (k > 0) {
        vector<long long> taken = heap.pop_max();
        if (taken[0] < previous) {
            cout << taken[0] << "\n";
            previous = taken[0];
            k--;
        }
        if (taken[1] > 1 && taken[2] == taken[1] - 1) heap.insert((taken[1] - 1) * (taken[2]), taken[1] - 1, taken[2]);
        if (taken[2] > 1) heap.insert((taken[1]) * (taken[2] - 1), taken[1], taken[2] - 1);

    
    }
    

    return 0;
}