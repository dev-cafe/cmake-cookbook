#include "evolution.hpp"

#include <string>
#include <vector>

std::vector<int> evolve(const std::vector<int> row, const std::string rule_binary) {
  std::vector<int> result;

  for (int i = 0; i < row.size(); i++) {

    int left = i - 1;
    int center = i;
    int right = i + 1;

    if (left < 0)
      left += row.size();
    if (right >= row.size())
      right -= row.size();

    int ancestors = 4 * row[left] + 2 * row[center] + 1 * row[right];
    ancestors = 7 - ancestors;

    int new_state = std::stoi(rule_binary.substr(ancestors, 1));

    result.push_back(new_state);
  }

  return result;
}
