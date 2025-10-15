// SPDX-FileCopyrightText: 2015 - 2023 Marcin Łoś <marcin.los.91@gmail.com>
// SPDX-License-Identifier: MIT
// Modified version for stability testing

#include "heat_2d.hpp"
#include <iostream>
#include <string>

int main(int argc, char *argv[]) {
  // Default parameters
  double time_step = 1e-5;
  int grid_size = 40;
  int total_steps = 10000;

  // Parse command line arguments
  if (argc > 1) {
    time_step = std::stod(argv[1]);
  }
  if (argc > 2) {
    grid_size = std::stoi(argv[2]);
  }
  if (argc > 3) {
    total_steps = std::stoi(argv[3]);
  }

  std::cout << "Running heat_2d with parameters:" << std::endl;
  std::cout << "  Time step: " << time_step << std::endl;
  std::cout << "  Grid size: " << grid_size << "x" << grid_size << std::endl;
  std::cout << "  Total steps: " << total_steps << std::endl;

  try {
    ads::dim_config dim{2, grid_size};
    ads::timesteps_config steps{total_steps, time_step};
    int ders = 1;

    ads::config_2d c{dim, dim, steps, ders};
    ads::problems::heat_2d sim{c};
    sim.run();

    std::cout << "Simulation completed successfully" << std::endl;
  } catch (const std::exception &e) {
    std::cerr << "Simulation failed: " << e.what() << std::endl;
    return 1;
  }

  return 0;
}