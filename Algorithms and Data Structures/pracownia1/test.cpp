/* bool dfs(int s, unordered_map<int, vector<int> >& graph, vector<int>& pavement, vector<Brick>& bricks) {
    while (!graph[s].empty()) {
        int next_brick = graph[s].back();
        if (bricks[next_brick].r == 0) {
            pavement.push_back(next_brick);
            return true;
        }
        else {
            graph[s].pop_back();
            if( dfs(bricks[next_brick].r, graph, pavement, bricks)) {
                pavement.push_back(next_brick);
                return true;
            }
        }
    }
    return false;
}
*/
/*
bool dfs(int s, unordered_map<int, vector<int> >& graph, vector<int>& pavement, vector<Brick>& bricks) {
    stack<pair<int, int> > b_stack; // wierzcholek i jego pozycja w liscie sasiedztwa
    b_stack.push(make_pair(s, 0));

    while(!b_stack.empty()) {
        auto& [brick, id] = b_stack.top();
        if (id >= graph[brick].size()) {
            b_stack.pop();
            if (!pavement.empty()) pavement.pop_back();
            continue;
        }
        int next_brick = graph[brick][id];
        b_stack.top().second++;
        pavement.push_back(next_brick);
        if(bricks[next_brick].r == 0) return true;
        b_stack.push(make_pair(bricks[next_brick].r, 0));
    }

    
    return false;
} 
*/