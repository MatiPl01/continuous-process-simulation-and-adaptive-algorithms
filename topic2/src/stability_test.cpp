#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>
#include <cstdlib>

int main() {
    std::cout << "Testing stability..." << std::endl;
    
    // Test different time steps
    std::vector<double> time_steps = {1e-5, 1e-4, 1e-3, 1e-2, 1e-1, 1.0, 10.0, 100.0};
    
    double max_stable = 0.0;
    double min_unstable = 0.0;
    bool found_unstable = false;
    
    for (double dt : time_steps) {
        std::cout << "Testing dt = " << dt << " ... ";
        
        // Run simulation with current time step
        std::string cmd = "./heat_2d " + std::to_string(dt) + " 40 1000";
        int result = system(cmd.c_str());
        
        if (result == 0) {
            // Check if output is valid
            std::ifstream file("out_900.data");
            if (file.is_open()) {
                double value;
                int valid = 0, total = 0;
                while (file >> value) {
                    total++;
                    if (std::isfinite(value) && value < 1e6) valid++;
                }
                file.close();
                
                if (valid * 100 / total >= 95) {
                    std::cout << "STABLE" << std::endl;
                    max_stable = dt;
                } else {
                    std::cout << "UNSTABLE" << std::endl;
                    if (!found_unstable) {
                        min_unstable = dt;
                        found_unstable = true;
                    }
                    break;
                }
            } else {
                std::cout << "UNSTABLE" << std::endl;
                if (!found_unstable) {
                    min_unstable = dt;
                    found_unstable = true;
                }
                break;
            }
        } else {
            std::cout << "UNSTABLE" << std::endl;
            if (!found_unstable) {
                min_unstable = dt;
                found_unstable = true;
            }
            break;
        }
    }
    
    std::cout << "Max stable: " << max_stable << std::endl;
    if (found_unstable) {
        std::cout << "Min unstable: " << min_unstable << std::endl;
    }
    
    return 0;
}
