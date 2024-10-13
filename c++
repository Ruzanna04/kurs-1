 #include <iostream>
#include <cmath>

using namespace std;

int main() {
    int firstElement, d, n, m;

    cout << "Enter the first element: ";
    cin >> firstElement;

    cout << "Enter d: ";
    cin >> d;

    cout << "Enter n: ";
    cin >> n;

    cout << "Enter m: ";
    cin >> m;

    int ap[n];

    for (int i = 0; i < n; ++i) {
        ap[i] = firstElement + i * d;
    }

    int closestLow = ap[0], closestHigh = ap[0];

    for (int i = 0; i < n; ++i) {
        if (ap[i] <= m) {
            closestLow = ap[i];
        } else {
            closestHigh = ap[i];
            break;
        }
    }

    cout << "Ամենամոտ  տարրերը :" << closestLow << " "<<closestHigh<<endl;

    return 0;
}
