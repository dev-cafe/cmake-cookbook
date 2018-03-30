/* Example taken from
 * https://forum.kde.org/viewtopic.php?f=74&t=138728#
 */

#include <iostream>
#include <vector>

#include <Eigen/Dense>

using namespace Eigen;
using namespace std;

EIGEN_DONT_INLINE
int foo(vector<float> &input, VectorXf &delay, VectorXf &doubleTaps) {
  int numTaps = doubleTaps.size() / 2;
  float tot = 0;
  int state = 0;
  for (const float &i : input) {
    delay[state] = i;
    tot += doubleTaps.segment(numTaps - state, numTaps).dot(delay);

    if (--state < 0)
      state += numTaps;
  }
  return tot;
}

int main() {
  int numTaps = 1024;
  int numSamples = 10000000;

  // Create random input
  vector<float> input(numSamples);
  generate(input.begin(), input.end(), rand);

  // Generate taps, then create double taps, a vector of taps twice.
  VectorXf taps = VectorXf::Random(numTaps);

  VectorXf doubleTaps;
  doubleTaps.resize(2 * numTaps);
  doubleTaps.head(numTaps) = taps;
  doubleTaps.tail(numTaps) = taps;
  VectorXf delay = VectorXf::Zero(numTaps);

  int tot = foo(input, delay, doubleTaps);
}
