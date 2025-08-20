#include<iostream>
#include<vector>
#include<cmath>
#include<limits>
#include<stack>
using namespace std;

typedef pair<int, int> Point;
typedef pair<Point, Point> PairPoint;

long long distance(const Point &p1, const Point &p2) {
    long long dx = static_cast<long long>(p1.first) - p2.first;
    long long dy = static_cast<long long>(p1.second) - p2.second;
    return dx * dx + dy * dy;
}

bool compareX(const Point &point1, Point &point2) {
    if (point1.first == point2.first) return point1.second < point2.second;
    return point1.first < point2.first;
}

bool compareY(const Point &point1, const Point &point2) {
    if (point1.second == point2.second) return point1.first < point2.first;
    return point1.second < point2.second;
}

template<typename Compare>
void insert_sort(vector<Point>& points, int left, int right, Compare comp) {
    for(int i = left + 1; i<=right; i++) {
        Point key = points[i];
        int j = i - 1;
        while (j >= left && comp(key, points[j])) {
            points[j + 1] = points[j];
            j--;
        }
        points[j + 1] = key;
    }
}

template<typename Compare>
void quick_sort(vector<Point>& points, int left, int right, Compare comp) {
    stack<pair<int, int> > stk;
    stk.push(make_pair(left, right));
    while(!stk.empty()) {
        auto current = stk.top();
        stk.pop();
        int l = current.first;
        int r = current.second;
        if (r - l + 1 <= 16) {
            insert_sort(points, l, r, comp);
            continue;
        }
        int mid = l + (r - l)/2;
        if (comp(points[r], points[l])) swap(points[l], points[r]);
        if (comp(points[mid], points[l])) swap(points[mid], points[l]);
        if (comp(points[r], points[mid])) swap(points[mid], points[r]);
        Point pivot = points[mid];
        int i = l;
        int j = r;
        while (i <= j) {
            while (comp(points[i], pivot)) i++;
            while (comp(pivot, points[j])) j--;
            if (i <= j) {
                swap(points[i], points[j]);
                i++;
                j--;
            }
        }
        if (l < j) stk.push(make_pair(l, j));
        if (i < r) stk.push(make_pair(i, r));
    }
}


PairPoint bruteForce(vector<Point>& points, int left, int right) {
    long long min = numeric_limits<long long>::max();
    PairPoint closest;
    for (int i = left; i <= right; i++) {
        for (int j = i + 1; j <= right; j++) {
            long long d = distance(points[i], points[j]);
            if (d < min) {
                min = d;
                closest = make_pair(points[i], points[j]);
            }
        }
    }
    return closest;
}

PairPoint closest_pair_in_strip(vector<Point>& strip, long long d, const PairPoint& current_pair) {
    if (strip.size() < 2) return current_pair;
    long long mind = d;
    PairPoint cpair = current_pair;
    quick_sort(strip, 0, strip.size() - 1, compareY);
    long long ds, dy;
    for (long unsigned int i = 0; i < strip.size(); i++) {
        for (long unsigned int j = i + 1; j < strip.size() && j < i + 8; j++) {
            dy = (static_cast<long long>(strip[j].second) - strip[i].second) * (strip[j].second - strip[i].second);
            if (dy >= d) break;
            ds = distance(strip[j], strip[i]);
            if (ds < mind) {
                mind = ds;
                cpair = make_pair(strip[i], strip[j]);
            }
        }
    }
    return cpair;
}

PairPoint closest_points(vector<Point> &points, int left, int right) {
    if (right - left + 1 <= 3) {
        return bruteForce(points, left, right);
    }

    int mid = left + (right - left)/2;
    auto lpair = closest_points(points, left, mid);
    auto rpair = closest_points(points, mid + 1, right);
    long long dl = distance(lpair.first, lpair.second);
    long long dr = distance(rpair.first, rpair.second);
    PairPoint cpair;
    long long d;

    if (dl < dr) {
        cpair = lpair;
        d = dl;
    }
    else {
        cpair = rpair;
        d = dr;
    }

    int midx = points[mid].first;
    vector<Point> strip;
    for (int i = left; i <= right; i++) {
        int dx = abs(points[i].first - midx);
        if (dx * dx < d) {
            strip.push_back(points[i]);
        }
    }

    auto strip_pair = closest_pair_in_strip(strip, d, cpair);
    long long strip_d = distance(strip_pair.first, strip_pair.second);
    if (strip_d < d) return strip_pair;
    return cpair;
}


int main() {
    ios::sync_with_stdio(false);
    cin.tie(NULL);
    int n;
    cin >> n;
    vector<Point> points(n);
    for (int i = 0; i < n; i++) {
        int x, y;
        cin >> x >> y;
        points[i] = make_pair(x, y);
    }
    quick_sort(points, 0, points.size() - 1, compareX);
    auto cpair = closest_points(points, 0, n-1);
    cout << cpair.first.first << " " << cpair.first.second << "\n";
    cout << cpair.second.first << " " << cpair.second.second;

    return 0;
}