# Raport IGA-ADS

## 1. Informacje o Systemie

### Specyfikacja Sprzętu

**Procesor:** Apple M3 Pro
**Pamięć:** 18 GB
**Rdzenie:** 11 (5 performance and 6 efficiency)

### System Operacyjny

**System:** macOS 26.0.1
**Architektura:** arm64

## 2. Log z Instalacji

### Środowisko Docker (Ubuntu 24.04.3 LTS)

**CMake:** cmake version 3.28.3
**Gfortran:** GNU Fortran (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0
**Boost:** 1.83.0.1ubuntu2
**BLAS:** 3.12.0-3build1.1
**LAPACK:** 3.12.0-3build1.1

## 3. Log z Wywołania CMake

### Komenda Konfiguracyjna
```bash
cmake -S . -B build -D CMAKE_BUILD_TYPE=Release -D ADS_USE_GALOIS=ON -D USE_MUMPS=OFF -D CMAKE_PREFIX_PATH="${DEPS}"
```

### Wynik Konfiguracji
```bash
-- The CXX compiler identification is GNU 13.3.0
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Performing Test ADS_CXX_SUPPORTS_-Wall
-- Performing Test ADS_CXX_SUPPORTS_-Wall - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wextra
-- Performing Test ADS_CXX_SUPPORTS_-Wextra - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wpedantic
-- Performing Test ADS_CXX_SUPPORTS_-Wpedantic - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wunused
-- Performing Test ADS_CXX_SUPPORTS_-Wunused - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wnon-virtual-dtor
-- Performing Test ADS_CXX_SUPPORTS_-Wnon-virtual-dtor - Success
-- Performing Test ADS_CXX_SUPPORTS_-Woverloaded-virtual
-- Performing Test ADS_CXX_SUPPORTS_-Woverloaded-virtual - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wmisleading-indentation
-- Performing Test ADS_CXX_SUPPORTS_-Wmisleading-indentation - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wfloat-conversion
-- Performing Test ADS_CXX_SUPPORTS_-Wfloat-conversion - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wold-style-cast
-- Performing Test ADS_CXX_SUPPORTS_-Wold-style-cast - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wcast-align
-- Performing Test ADS_CXX_SUPPORTS_-Wcast-align - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wconversion
-- Performing Test ADS_CXX_SUPPORTS_-Wconversion - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wsuggest-override
-- Performing Test ADS_CXX_SUPPORTS_-Wsuggest-override - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wlogical-op
-- Performing Test ADS_CXX_SUPPORTS_-Wlogical-op - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wuseless-cast
-- Performing Test ADS_CXX_SUPPORTS_-Wuseless-cast - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wduplicated-cond
-- Performing Test ADS_CXX_SUPPORTS_-Wduplicated-cond - Success
-- Performing Test ADS_CXX_SUPPORTS_-Wduplicated-branches
-- Performing Test ADS_CXX_SUPPORTS_-Wduplicated-branches - Success
-- Found Git: /usr/bin/git (found version "2.43.0") 
-- Looking for sgemm_
-- Looking for sgemm_ - not found
-- Performing Test CMAKE_HAVE_LIBC_PTHREAD
-- Performing Test CMAKE_HAVE_LIBC_PTHREAD - Success
-- Found Threads: TRUE  
-- Looking for sgemm_
-- Looking for sgemm_ - found
-- Found BLAS: /usr/lib/aarch64-linux-gnu/libblas.so  
-- Looking for cheev_
-- Looking for cheev_ - not found
-- Looking for cheev_
-- Looking for cheev_ - found
-- Found LAPACK: /usr/lib/aarch64-linux-gnu/liblapack.so;/usr/lib/aarch64-linux-gnu/libblas.so  
-- Found Boost: /usr/lib/aarch64-linux-gnu/cmake/Boost-1.83.0/BoostConfig.cmake (found suitable version "1.83.0", minimum required is "1.58.0")  
-- Found Boost: /usr/lib/aarch64-linux-gnu/cmake/Boost-1.83.0/BoostConfig.cmake (found suitable version "1.83.0", minimum required is "1.58.0") found components: serialization iostreams 
-- Configuring done (0.7s)
-- Generating done (0.0s)
CMake Warning:
  Manually-specified variables were not used by the project:

    USE_MUMPS


-- Build files have been written to: /code/build
```

## 4. Log z Kompilacji IGA-ADS

### Komenda Kompilacji
```bash
ninja -C build
```

### Wynik Kompilacji
```bash
-- Found Boost: /usr/lib/aarch64-linux-gnu/cmake/Boost-1.83.0/BoostConfig.cmake (found suitable version "1.83.0", minimum required is "1.58.0")  
-- Found Boost: /usr/lib/aarch64-linux-gnu/cmake/Boost-1.83.0/BoostConfig.cmake (found suitable version "1.83.0", minimum required is "1.58.0") found components: serialization iostreams 
-- Configuring done (0.0s)
-- Generating done (0.0s)
-- Build files have been written to: /code/build
ninja: Entering directory `build'
[1/80] Building CXX object CMakeFiles/ads-objects.dir/src/ads/simulation/simulation_base.cpp.o
[2/80] Building CXX object CMakeFiles/ads-objects.dir/src/ads/quad/gauss_data.cpp.o
[3/80] Building CXX object CMakeFiles/ads-objects.dir/src/ads/version.cpp.o
[4/80] Building CXX object CMakeFiles/ads-objects.dir/src/ads/bspline/bspline.cpp.o
[5/80] Building CXX object CMakeFiles/ads-objects.dir/src/ads/form_matrix.cpp.o
[6/80] Building CXX object CMakeFiles/ads-objects.dir/src/ads/basis_data.cpp.o
[7/80] Building CXX object CMakeFiles/ads-objects.dir/src/ads/simulation/simulation_1d.cpp.o
[8/80] Building CXX object CMakeFiles/ads-objects.dir/src/ads/simulation/dimension.cpp.o
[9/80] Building CXX object tests/CMakeFiles/ads-suite.dir/ads/bspline/eval_test.cpp.o
[10/80] Building CXX object CMakeFiles/ads-objects.dir/src/ads/simulation/simulation_2d.cpp.o
[11/80] Building CXX object tests/CMakeFiles/ads-suite.dir/ads/util/multi_array_test.cpp.o
[12/80] Building CXX object tests/CMakeFiles/ads-suite.dir/ads/bspline/bspline_test.cpp.o
[13/80] Building CXX object CMakeFiles/ads-objects.dir/src/ads/executor/galois.cpp.o
[14/80] Building CXX object CMakeFiles/ads-objects.dir/src/ads/simulation/simulation_3d.cpp.o
[15/80] Linking CXX static library libads.a
[16/80] Building CXX object tests/CMakeFiles/ads-suite.dir/ads/lin/dense_solve_test.cpp.o
[17/80] Building CXX object tests/CMakeFiles/ads-suite.dir/ads/lin/band_solve_test.cpp.o
[18/80] Building CXX object tests/CMakeFiles/ads-suite.dir/ads/basis_data_test.cpp.o
[19/80] Building CXX object tests/CMakeFiles/ads-suite.dir/ads/lin/tensor_test.cpp.o
[20/80] Building CXX object examples/CMakeFiles/ads-example-heat_3d.dir/heat/heat_3d.cpp.o
[21/80] Linking CXX executable examples/heat_3d
[22/80] Building CXX object tests/CMakeFiles/ads-suite.dir/ads/solver_test.cpp.o
[23/80] Linking CXX executable tests/suite
[24/80] Building CXX object examples/CMakeFiles/ads-example-heat_1d.dir/heat/heat_1d.cpp.o
[25/80] Linking CXX executable examples/heat_1d
[26/80] Building CXX object examples/CMakeFiles/ads-example-validation.dir/validation/main.cpp.o
[27/80] Building CXX object examples/CMakeFiles/ads-example-scalability.dir/scalability/main.cpp.o
[28/80] Linking CXX executable examples/validation
[29/80] Linking CXX executable examples/scalability
[30/80] Building CXX object examples/CMakeFiles/ads-example-multistep.dir/multistep/scheme.cpp.o
[31/80] Building CXX object examples/CMakeFiles/ads-example-elasticity_victor.dir/elasticity/victor.cpp.o
[32/80] Building CXX object examples/CMakeFiles/ads-example-flow.dir/flow/main.cpp.o
[33/80] Building CXX object examples/CMakeFiles/ads-example-heat_2d.dir/heat/heat_2d.cpp.o
[34/80] Building CXX object examples/CMakeFiles/ads-example-linear_elasticity.dir/elasticity/main.cpp.o
[35/80] Linking CXX executable examples/heat_2d
[36/80] Linking CXX executable examples/elasticity_victor
[37/80] Linking CXX executable examples/flow
[38/80] Building CXX object examples/CMakeFiles/ads-example-maxwell-common.dir/maxwell/state.cpp.o
[39/80] Linking CXX executable examples/linear_elasticity
[40/80] Building CXX object examples/CMakeFiles/ads-example-pollution.dir/pollution/main.cpp.o
[41/80] Building CXX object examples/CMakeFiles/ads-example-maxwell-common.dir/maxwell/results.cpp.o
[42/80] Building CXX object examples/CMakeFiles/ads-example-maxwell-common.dir/maxwell/spaces.cpp.o
[43/80] Linking CXX executable examples/pollution
[44/80] Building CXX object examples/CMakeFiles/ads-example-maxwell_ads.dir/maxwell/head_data.cpp.o
[45/80] Building CXX object examples/CMakeFiles/ads-example-maxwell_ads.dir/maxwell/maxwell_head_problem.cpp.o
[46/80] Building CXX object examples/CMakeFiles/ads-example-elasticity_pouria.dir/elasticity/elasticity_pouria.cpp.o
[47/80] Building CXX object examples/CMakeFiles/ads-example-pollution_dpg_3d.dir/pollution/dpg3d.cpp.o
[48/80] Linking CXX executable examples/pollution_dpg_3d
[49/80] Linking CXX executable examples/elasticity_pouria
[50/80] Building CXX object examples/CMakeFiles/ads-example-pollution_dpg.dir/pollution/dpg.cpp.o
[51/80] Building CXX object examples/CMakeFiles/ads-example-tumor.dir/tumor/vasculature/plot.cpp.o
[52/80] Linking CXX executable examples/pollution_dpg
[53/80] Building CXX object examples/CMakeFiles/ads-example-tumor.dir/tumor/vasculature/vasculature.cpp.o
[54/80] Building CXX object examples/CMakeFiles/ads-example-victor.dir/victor/main.cpp.o
[55/80] Linking CXX executable examples/victor
[56/80] Building CXX object examples/CMakeFiles/ads-example-maxwell-common.dir/maxwell/maxwell_base.cpp.o
[57/80] Building CXX object examples/CMakeFiles/ads-example-tumor_3d.dir/tumor/3d/vasculature_parser.cpp.o
[58/80] Building CXX object examples/CMakeFiles/ads-example-erikkson.dir/erikkson/main.cpp.o
[59/80] Building CXX object examples/CMakeFiles/ads-example-multistep.dir/multistep/main.cpp.o
[60/80] Linking CXX executable examples/erikkson
[61/80] Building CXX object examples/CMakeFiles/ads-example-demkowicz.dir/demkowicz/main.cpp.o
[62/80] Linking CXX executable examples/multistep
[63/80] Linking CXX executable examples/demkowicz
[64/80] Building CXX object examples/CMakeFiles/ads-example-tumor.dir/tumor/tumor_main.cpp.o
[65/80] Building CXX object examples/CMakeFiles/ads-example-tumor.dir/tumor/tumor.cpp.o
[66/80] Linking CXX executable examples/tumor
[67/80] Building CXX object examples/CMakeFiles/ads-example-coupled.dir/implicit/coupled.cpp.o
[68/80] Linking CXX executable examples/coupled
[69/80] Building CXX object tools/CMakeFiles/ads-error.dir/error.cpp.o
[70/80] Linking CXX executable tools/ads-error
[71/80] Building CXX object examples/CMakeFiles/ads-example-fire.dir/fire/fire.cpp.o
In file included from /code/examples/fire/fire.cpp:4:
/code/examples/fire/fire.hpp: In lambda function:
/code/examples/fire/fire.hpp:98:36: warning: unused parameter 'x' [-Wunused-parameter]
   98 |         auto fuel_init = [](double x, double y) { return 1; };
      |                             ~~~~~~~^
/code/examples/fire/fire.hpp:98:46: warning: unused parameter 'y' [-Wunused-parameter]
   98 |         auto fuel_init = [](double x, double y) { return 1; };
      |                                       ~~~~~~~^
/code/examples/fire/fire.hpp: In lambda function:
/code/examples/fire/fire.hpp:129:22: warning: variable 'x' set but not used [-Wunused-but-set-variable]
  129 |                 auto x = point(e, q);
      |                      ^
/code/examples/fire/fire.hpp: In member function 'void ads::problems::fire::compute_rhs(double)':
/code/examples/fire/fire.hpp:116:29: warning: unused parameter 't' [-Wunused-parameter]
  116 |     void compute_rhs(double t) {
      |                      ~~~~~~~^
[72/80] Linking CXX executable examples/fire
[73/80] Building CXX object examples/CMakeFiles/ads-example-implicit.dir/implicit/main.cpp.o
[74/80] Linking CXX executable examples/implicit
[75/80] Building CXX object examples/CMakeFiles/ads-example-tumor_3d.dir/tumor/3d/main.cpp.o
[76/80] Linking CXX executable examples/tumor_3d
[77/80] Building CXX object examples/CMakeFiles/ads-example-maxwell_uniform.dir/maxwell/main_uniform.cpp.o
[78/80] Linking CXX executable examples/maxwell_uniform
[79/80] Building CXX object examples/CMakeFiles/ads-example-maxwell_ads.dir/maxwell/main_ads.cpp.o
[80/80] Linking CXX executable examples/maxwell_ads
```

## 5. Listing Katalogu po Uruchomieniu ./heat_2d

### Komenda Uruchomienia
```bash
./examples/heat_2d
```

### Wynik Uruchomienia i Listing Katalogu
```bash
WARNING: Numa support configured but not present at runtime.  Assuming numa topology matches socket topology.
integration: 11248
total 220064
drwxr-xr-x 10 root root    4096 Oct 15 06:22 .
drwxr-xr-x  1 root root    4096 Oct 15 06:21 ..
-rw-r--r--  1 root root  256032 Oct 15 06:21 .ninja_deps
-rw-r--r--  1 root root    7991 Oct 15 06:21 .ninja_log
-rw-r--r--  1 root root   28776 Oct 15 06:21 CMakeCache.txt
drwxr-xr-x  7 root root    4096 Oct 15 06:21 CMakeFiles
-rw-r--r--  1 root root    3305 Oct 15 06:21 CPackConfig.cmake
-rw-r--r--  1 root root    3651 Oct 15 06:21 CPackSourceConfig.cmake
-rw-r--r--  1 root root     318 Oct 15 06:21 CTestTestfile.cmake
-rw-r--r--  1 root root    2437 Oct 15 06:21 DartConfiguration.tcl
drwxr-xr-x  3 root root    4096 Oct 15 06:21 Testing
-rw-r--r--  1 root root    2762 Oct 15 06:21 ads-config-version.cmake
-rw-r--r--  1 root root     421 Oct 15 06:21 ads-config.cmake
-rw-r--r--  1 root root  132512 Oct 15 06:21 build.ninja
-rw-r--r--  1 root root    4545 Oct 15 06:21 cmake_install.cmake
drwxr-xr-x  3 root root    4096 Oct 15 06:21 examples
drwxr-xr-x  3 root root    4096 Oct 15 06:21 external
drwxr-xr-x  3 root root    4096 Oct 15 06:21 include
-rw-r--r--  1 root root 2222055 Oct 15 06:21 init.data
-rw-r--r--  1 root root  198572 Oct 15 06:21 libads.a
-rw-r--r--  1 root root 2222055 Oct 15 06:21 out_0.data
-rw-r--r--  1 root root 2222055 Oct 15 06:21 out_100.data
-rw-r--r--  1 root root 2222055 Oct 15 06:21 out_1000.data
-rw-r--r--  1 root root 2222055 Oct 15 06:21 out_1100.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_1200.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_1300.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_1400.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_1500.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_1600.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_1700.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_1800.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_1900.data
-rw-r--r--  1 root root 2222055 Oct 15 06:21 out_200.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_2000.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_2100.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_2200.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_2300.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_2400.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_2500.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_2600.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_2700.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_2800.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_2900.data
-rw-r--r--  1 root root 2222055 Oct 15 06:21 out_300.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_3000.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_3100.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_3200.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_3300.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_3400.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_3500.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_3600.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_3700.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_3800.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_3900.data
-rw-r--r--  1 root root 2222055 Oct 15 06:21 out_400.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_4000.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_4100.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_4200.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_4300.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_4400.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_4500.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_4600.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_4700.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_4800.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_4900.data
-rw-r--r--  1 root root 2222055 Oct 15 06:21 out_500.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_5000.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_5100.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_5200.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_5300.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_5400.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_5500.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_5600.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_5700.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_5800.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_5900.data
-rw-r--r--  1 root root 2222055 Oct 15 06:21 out_600.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_6000.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_6100.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_6200.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_6300.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_6400.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_6500.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_6600.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_6700.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_6800.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_6900.data
-rw-r--r--  1 root root 2222055 Oct 15 06:21 out_700.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_7000.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_7100.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_7200.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_7300.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_7400.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_7500.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_7600.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_7700.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_7800.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_7900.data
-rw-r--r--  1 root root 2222055 Oct 15 06:21 out_800.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_8000.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_8100.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_8200.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_8300.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_8400.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_8500.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_8600.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_8700.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_8800.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_8900.data
-rw-r--r--  1 root root 2222055 Oct 15 06:21 out_900.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_9000.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_9100.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_9200.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_9300.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_9400.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_9500.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_9600.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_9700.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_9800.data
-rw-r--r--  1 root root 2222055 Oct 15 06:22 out_9900.data
drwxr-xr-x  4 root root    4096 Oct 15 06:21 src
drwxr-xr-x  3 root root    4096 Oct 15 06:21 tests
drwxr-xr-x  3 root root    4096 Oct 15 06:21 tools
```

## 6. Maksymalny Stabilny Krok Czasowy

**Maksymalny stabilny krok czasowy: 0.000104123**

*Analiza przeprowadzona metodą wyszukiwania binarnego z tolerancją 1e-10.*

---

*Raport wygenerowany: 2025-10-15 08:22:16*
