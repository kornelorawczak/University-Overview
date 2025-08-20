#include <iostream>
#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

int n, p, mod;
vector<unsigned int> forbidden; // each forbidden pattern is a 15-bit integer (3x3 bits)

unsigned int patternToBits(const vector<string>& pattern) {
    unsigned int bits = 0;
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 3; ++j) {
            if (pattern[i][j] == 'x') {
                bits |= 1 << (i * 3 + j);
            }
        }
    }
    return bits;
}

bool isForbidden(unsigned int window) {
    for (unsigned int pat : forbidden) {
        if (window == pat) {
            return true;
        }
    }
    return false;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> p >> mod;

    for (int i = 0; i < p; ++i) {
        vector<string> pattern(3);
        for (int j = 0; j < 3; ++j) {
            cin >> pattern[j];
        }
        cout << patternToBits(pattern) << "\n";
        forbidden.push_back(patternToBits(pattern));
    }

    // Remove duplicates
    sort(forbidden.begin(), forbidden.end());
    forbidden.erase(unique(forbidden.begin(), forbidden.end()), forbidden.end());

    const int STATE_BITS = 10; // 5 bits for prev_col, 5 bits for curr_col
    const int STATE_SIZE = 1 << STATE_BITS;

    vector<vector<int> > dp(2, vector<int>(STATE_SIZE, 0));
    int curr = 0;

    // Initialize for the first two columns (no 3x3 window possible)
    for (int state = 0; state < STATE_SIZE; ++state) {
        dp[curr][state] = 1;
    }

    for (int col = 2; col < n; ++col) {
        int next = 1 - curr;
        fill(dp[next].begin(), dp[next].end(), 0);

        for (int state = 0; state < STATE_SIZE; ++state) {
            if (dp[curr][state] == 0) continue;

            int prev_col = (state >> 5) & 0x1F;
            int curr_col = state & 0x1F;

            for (int next_col = 0; next_col < (1 << 5); ++next_col) {
                bool valid = true;

                // Check all possible 3-row windows in columns col-2, col-1, col
                for (int row_start = 0; row_start <= 2; ++row_start) {
                    unsigned int window = 0;
                    for (int i = 0; i < 3; ++i) {
                        int row = row_start + i;
                        if (row >= 5) {
                            valid = false;
                            break;
                        }
                        int bit_col0 = (prev_col >> row) & 1;
                        int bit_col1 = (curr_col >> row) & 1;
                        int bit_col2 = (next_col >> row) & 1;
                        window |= bit_col0 << (i * 3 + 0);
                        window |= bit_col1 << (i * 3 + 1);
                        window |= bit_col2 << (i * 3 + 2);
                    }
                    if (!valid) break;
                    if (isForbidden(window)) {
                        valid = false;
                        break;
                    }
                }

                if (valid) {
                    int new_state = ((curr_col << 5) | next_col) & (STATE_SIZE - 1);
                    dp[next][new_state] = (dp[next][new_state] + dp[curr][state]) % mod;
                }
            }
        }
        curr = next;
    }

    int total = 0;
    for (int state = 0; state < STATE_SIZE; ++state) {
        total = (total + dp[curr][state]) % mod;
    }

    cout << total << endl;
    
    return 0;
}