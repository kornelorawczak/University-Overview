#include <iostream>
#include <vector>

using namespace std;

class Kopiec {
    private:
        vector<pair<int, int> > K;
        int n;
    public:
        Kopiec(int i, int j) {
            pair<int, int> placeholder;
            placeholder.first = -1;
            placeholder.second = -2;
            this->K.push_back(placeholder); // dorownanie indeksow
            pair<int, int> starter;
            starter.first = i;
            starter.second = j;
            this->K.push_back(starter);
            this->n = 1;
        }
        void przesun_nizej(int i) {
            int k = i;
            int j;
            do {
                j = k;
                if (2*j <= this->n && static_cast<long long>(this->K[2*j].first) * this->K[2*j].second > static_cast<long long>(this->K[k].first) * this->K[k].second) k = 2*j;
                if (2*j + 1 <= this->n && static_cast<long long>(this->K[2*j + 1].first) * this->K[2*j + 1].second > static_cast<long long>(this->K[k].first) * this->K[k].second) k = 2*j + 1;
                swap(this->K[j], this->K[k]);  
            } while (j != k);
        }
        void przesun_wyzej(int i) {
            int k = i;
            int j;
            do {
                j = k;
                if (j > 1 && static_cast<long long>(this->K[j/2].first) * this->K[j/2].second < static_cast<long long>(this->K[k].first) * this->K[k].second) k = j/2;
                swap(this->K[j], this->K[k]);
            } while (j != k);
        }
        pair<int, int> pop_max() {
            pair<int, int> temp = K[1];
            swap(this->K[1], this->K[n]);
            this->K.pop_back();
            this->n--;
            przesun_nizej(1);
            return temp;
        }
        void insert(int i, int j) {
            pair<int, int> number;
            number.first = i;
            number.second = j;
            this->K.push_back(number);
            this->n++;
            przesun_wyzej(this->n);
        }
        void print() {
            for (auto v : this->K) {
                cout << (long long)v.first * v.second << " ";
            }
        }
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(NULL);
    int M, k;
    cin >> M >> k; 
    Kopiec heap = Kopiec(M, M);
    long long previous = static_cast<long long>(M)*M + 1;
    while (k > 0) {
        pair<int, int> taken = heap.pop_max();
        long long value = (long long)taken.first * taken.second;
        if (value < previous) {
            cout << value << "\n";
            previous = value;
            k--;
        }
        if (taken.first > 1 && taken.second == taken.first - 1) heap.insert(taken.first - 1, taken.second);
        if (taken.second > 1) heap.insert(taken.first, taken.second - 1);

    
    }
    

    return 0;
}