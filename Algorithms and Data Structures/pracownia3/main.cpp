#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

// zamysł: zmiana zabronionych patternow na bitmaski 9 bitowe 
// x..
// .xx
// xxx
// tłumaczy się na 100 011 111, oczywiście wartości otrzymywane są z przedziału 0...511
// z powodu sposobu zapisu aby nie odwracać tabeli to dane binarne są odwrocone

unsigned int maskPattern(const vector<string>& pattern) {
    unsigned int bitmask = 0;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if (pattern[i][j] == 'x') {
                bitmask |= (1 << (i * 3 + j));
            }
        }
    }

    return bitmask;
}

bool isForbidden(unsigned int bitPattern, const unordered_set<unsigned int>& f_p) {
    return f_p.count(bitPattern);
}

unsigned int box_to_bits(const unsigned int& col0, const unsigned int& col1, const unsigned int& col2, int num) {
    unsigned int bits = 0;
    for (int i = 0; i < 3; i++) {
        int current_row = num + i;
        int bit0 = (col0 >> current_row) & 1;
        int bit1 = (col1 >> current_row) & 1;
        int bit2 = (col2 >> current_row) & 1;
        bits |= bit0 << (i*3 + 0);
        bits |= bit1 << (i*3 + 1);
        bits |= bit2 << (i*3 + 2);
    }
    return bits;
}


vector<vector<int> > possibleColumns(const unordered_set<unsigned int>& f_p) {
    vector<vector<int> > pc(1024);
    for (int i = 0; i < 1024; i++) {
            int col0 = (i >> 5); // bity 5 - 9
            int col1 = (i & 31); // bity 0 - 4
            for (int next_col = 0; next_col < 32; next_col++) {
                // sprawdzamy wszystkie możliwe pokolorwania nowej kolumny
                bool ok = true;
                unsigned int box;
                for (int box_number = 0; box_number < 3; box_number++) {
                    box = box_to_bits(col0, col1, next_col, box_number);
                    if (!ok) break;
                    if (isForbidden(box, f_p)) {ok = false; break;}
                }

                if(ok) {
                    pc[i].push_back(next_col);
                }
            }
        }

    return pc;
}


int main() {
    ios::sync_with_stdio(false);
    cin.tie(NULL);
    int n, p, m;
    cin >> n >> p >> m;
    unordered_set<unsigned int> forbidden_patterns;
    for (int i = 0; i < p; i++) {
        vector<string> s_pattern(3);
        for (int j = 0; j < 3; j++) {
            cin >> s_pattern[j];
        }
        forbidden_patterns.insert(maskPattern(s_pattern));
    }

    // zawsze interesują nas tylko dwie poprzednie kolumny, czyli max 2^10 możliwości
    // dp[col][m] = x:
    // col = 0 lub col = 1
    // m od 0 do 1023 - wszystkie możliwości wypełnienia obu kolumn na 10 bitach
    // x oznacza liczbe dobrych kolorowan planszy do kolumny col jeśli ostatnie dwie kolumny mają stan m
    vector<vector<int> > pc = possibleColumns(forbidden_patterns);
    vector<vector<int> > dp(2, vector<int>(1024, 0));
    for (int i = 0; i < 1024; i++) {
        dp[0][i] = 1; 
        // na pierwszych 2 kolumnach nie ma szans na zakazany pattern
        // wypełniamy to w kolumnie 0 bo reprezentuje ona stan tak na prawde kolumn 1 i 2
        // index 1 to już bedzie kolumna 3 przy stanie poprzednich dwoch zapisanych w dp[0][stan]
    }

    int current = 0;
    for (int col = 2; col < n; col++) {
        int next = 1 - current;
        fill(dp[next].begin(), dp[next].end(), 0);

        for (int i = 0; i < 1024; i++) {
            if (dp[current][i] == 0) continue; // oznacza to że dla tego stanu (i) nie da się nic pokolorować
            int col0 = i & 31;
            for (int col1 : pc[i]) {
                int coloring = ((col0 << 5) | col1) & 1023;
                dp[next][coloring] = (dp[next][coloring] + dp[current][i]) % m;
            }
        }
        current = next;
        
    }

    int result = 0;
    for(int i = 0; i < 1024; i++) {
        result = (result + dp[current][i]) % m;
    }
    cout << result;

    return 0;
}