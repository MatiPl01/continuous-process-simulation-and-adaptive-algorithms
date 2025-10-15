#include <algorithm>
#include <cmath>
#include <fstream>
#include <iostream>
#include <limits>
#include <string>
#include <vector>

// Simple stability test for heat equation
// Tests different time steps to find maximum stable one

bool isStable(double dt, int nx = 50, int ny = 50) {
  // Grid parameters
  double dx = 1.0 / (nx - 1);
  double dy = 1.0 / (ny - 1);

  // Stability condition: dt <= 0.25 * min(dx^2, dy^2)
  // For heat equation: alpha = 1, so dt <= 0.5 * min(dx^2, dy^2) / 2
  double maxStableDt = 0.25 * std::min(dx * dx, dy * dy);

  return dt <= maxStableDt;
}

double findMaxStableTimeStep(bool verbose = false, double tolerance = 1e-10) {
  double dtMin = 0.0001; // Known stable
  double dtMax = 0.1;    // Likely unstable

  // Binary search for maximum stable time step
  while (dtMax - dtMin > tolerance) {
    double dtTest = (dtMin + dtMax) / 2.0;

    if (isStable(dtTest)) {
      dtMin = dtTest;
      if (verbose) {
        std::cout << "✅ dt = " << dtTest << " - STABILNY" << std::endl;
      }
    } else {
      dtMax = dtTest;
      if (verbose) {
        std::cout << "❌ dt = " << dtTest << " - NIESTABILNY" << std::endl;
      }
    }
  }

  return dtMin;
}

int main(int argc, char *argv[]) {
  // Expect exactly 2 arguments: verbose flag and tolerance
  if (argc != 3) {
    std::cerr << "Usage: " << argv[0] << " <verbose> <tolerance>" << std::endl;
    std::cerr << "  verbose: 0 or 1" << std::endl;
    std::cerr << "  tolerance: e.g., 1e-10" << std::endl;
    return 1;
  }

  bool verbose = (std::stoi(argv[1]) == 1);
  double tolerance = std::stod(argv[2]);

  std::cout << findMaxStableTimeStep(verbose, tolerance) << std::endl;

  return 0;
}
