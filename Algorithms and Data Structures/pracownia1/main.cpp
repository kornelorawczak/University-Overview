#include <iostream>
#include <vector>
#include <unordered_map>
#include <stack>
using namespace std;


struct Brick {
    int l;
    int m; 
    int r;
};


bool dfs(int s, unordered_map<int, vector<int> >& graph, vector<int>& pavement, vector<Brick>& bricks) {
    stack<int> b_stack;
    b_stack.push(s);

    while(!b_stack.empty()) {
        int current_l = b_stack.top();
        if (graph[current_l].empty()) { 
            b_stack.pop();
            if (!pavement.empty()) pavement.pop_back();
            continue;
        }

        int current_brick = graph[current_l].back();
        graph[current_l].pop_back();
        pavement.push_back(current_brick);
        if (bricks[current_brick].r == 0) return true;
        b_stack.push(bricks[current_brick].r);
    }

    return false;
}


int main()
{
    ios::sync_with_stdio(false);
    cin.tie(NULL);
    int n;
    cin >> n;
    vector<Brick> bricks(n);
    unordered_map<int, vector<int> > graph; 
    for (int i = 0; i < n; i ++) {
        cin >> bricks[i].l >> bricks[i].m >> bricks[i].r;
        graph[bricks[i].l].push_back(i);
    }
    
    vector<int> pavement;
    if(dfs(0, graph, pavement, bricks)) {
        cout << pavement.size() << "\n";
        for (long unsigned int i = 0; i < pavement.size(); i++) {
            cout << bricks[pavement[i]].l << " " << bricks[pavement[i]].m << " " << bricks[pavement[i]].r << "\n";
        }
    }
    else {
        cout << "BRAK";
    }

    return 0;
}