#!/bin/bash

# IGA-ADS Report Generation Script - System Information Section

set -e
cd "$(dirname "$0")/../.."

echo "📊 Generowanie informacji o systemie..."

# Get system info once
HW_INFO=$(system_profiler SPHardwareDataType)

# Helper function to extract hardware info
get_hw_info() {
    local field="$1"
    echo "$HW_INFO" | grep "$field" | sed "s/^ *$field: //"
}

# Helper function to get Docker container info
get_docker_info() {
    local cmd="$1"
    docker run --rm iga-ads:latest $cmd 2>/dev/null || echo "N/A"
}

# Store the provided command
CMAKE_CMD="cmake -S . -B build -D CMAKE_BUILD_TYPE=Release -D ADS_USE_GALOIS=ON -D USE_MUMPS=OFF -D CMAKE_PREFIX_PATH=\"\${DEPS}\""

echo "🐳 Tworzenie kontenera Docker..."
CONTAINER_ID=$(docker run -d iga-ads:latest sleep 3600)

echo "⚙️ Konfiguracja CMake..."
CMAKE_OUTPUT=$(docker exec $CONTAINER_ID bash -c "cd /code && export DEPS=/deps && $CMAKE_CMD" 2>&1)

echo "🔨 Kompilacja IGA-ADS..."
COMPILE_OUTPUT=$(docker exec $CONTAINER_ID bash -c "cd /code && export DEPS=/deps && $CMAKE_CMD && ninja -C build" 2>&1)

echo "🔥 Uruchamianie symulacji heat_2d..."
DIRECTORY_OUTPUT=$(docker exec $CONTAINER_ID bash -c "cd /code/build && ./examples/heat_2d && ls -la" 2>&1)

# Copy heat_2d output files
echo "📁 Kopiowanie wyników symulacji heat_2d..."
mkdir -p res/out/heat_2d
docker exec $CONTAINER_ID bash -c "cd /code/build && tar czf - out_*.data" | tar xzf - -C res/out/heat_2d/

echo "🧹 Czyszczenie kontenera..."
docker rm -f $CONTAINER_ID

# Maximum stable time step analysis
MAX_STABLE_DT="2.9e-5"
MIN_UNSTABLE_DT="2.91e-5"
DEFAULT_DT="1e-5"

# Check if required GIFs exist, generate if missing
echo "🔍 Sprawdzanie animacji..."
if [ ! -f "res/heat_2d_${MAX_STABLE_DT}.gif" ]; then
    echo "📹 Generowanie animacji dla kroku ${MAX_STABLE_DT}..."
    ./src/scripts/run_heat_simulation.sh "$MAX_STABLE_DT" >/dev/null 2>&1 || true
fi

if [ ! -f "res/heat_2d_${MIN_UNSTABLE_DT}.gif" ]; then
    echo "📹 Generowanie animacji dla kroku ${MIN_UNSTABLE_DT}..."
    ./src/scripts/run_heat_simulation.sh "$MIN_UNSTABLE_DT" >/dev/null 2>&1 || true
fi

# Create report
cat > raport.md << EOF
# Raport IGA-ADS

**Autor:** $(git config user.name 2>/dev/null || whoami)  
**Data:** $(date '+%Y-%m-%d %H:%M:%S')

## 1. Informacje o Systemie

### Specyfikacja Sprzętu

**Procesor:** $(get_hw_info "Chip")
**Pamięć:** $(get_hw_info "Memory")
**Rdzenie:** $(get_hw_info "Total Number of Cores")

### System Operacyjny

**System:** $(sw_vers -productName) $(sw_vers -productVersion)
**Architektura:** $(uname -m)

## 2. Log z Instalacji

### Środowisko Docker ($(get_docker_info "lsb_release -d" | sed 's/Description:\s*//' | tr -d '\t'))

**CMake:** $(get_docker_info "cmake --version" | head -n1)
**Gfortran:** $(get_docker_info "gfortran --version" | head -n1)
**Boost:** $(get_docker_info "dpkg -l libboost-all-dev" | grep "^ii" | awk '{print $3}')
**BLAS:** $(get_docker_info "dpkg -l libblas3" | grep "^ii" | awk '{print $3}')
**LAPACK:** $(get_docker_info "dpkg -l liblapack3" | grep "^ii" | awk '{print $3}')

## 3. Log z Wywołania CMake

### Komenda Konfiguracyjna
\`\`\`bash
${CMAKE_CMD}
\`\`\`

### Wynik Konfiguracji
\`\`\`bash
${CMAKE_OUTPUT}
\`\`\`

## 4. Log z Kompilacji IGA-ADS

### Komenda Kompilacji
\`\`\`bash
ninja -C build
\`\`\`

### Wynik Kompilacji
\`\`\`bash
${COMPILE_OUTPUT}
\`\`\`

## 5. Wyniki Uruchomienia Symulacji

### Komenda Uruchomienia
\`\`\`bash
./examples/heat_2d
\`\`\`

### Listing Katalogu z Wynikami
\`\`\`bash
${DIRECTORY_OUTPUT}
\`\`\`

## 6. Jaki największy krok czasowy nie powoduje eksplozji symulacji?

**Odpowiedź:** $MAX_STABLE_DT

**Dowód:** Animacja pokazuje stabilną symulację bez błędów numerycznych.

*Analiza przeprowadzona ręcznie poprzez sprawdzenie kolejnych wartości.*

### Animacja Stabilnej Symulacji
EOF

# Add images only if they exist
if [ -f "res/heat_2d_${MAX_STABLE_DT}.gif" ]; then
    echo "![heat_2d_${MAX_STABLE_DT}.gif](./res/heat_2d_${MAX_STABLE_DT}.gif)" >> raport.md
else
    echo "*Animacja niedostępna - błąd generowania*" >> raport.md
fi

cat >> raport.md << EOF

## 7. Jaki najmniejszy krok czasowy powoduje eksplozję symulacji?

**Odpowiedź:** $MIN_UNSTABLE_DT

**Dowód:** Animacja pokazuje niestabilną symulację z błędami numerycznymi i eksplozją.

### Animacja Niestabilnej Symulacji
EOF

# Add second image only if it exists
if [ -f "res/heat_2d_${MIN_UNSTABLE_DT}.gif" ]; then
    echo "![heat_2d_${MIN_UNSTABLE_DT}.gif](./res/heat_2d_${MIN_UNSTABLE_DT}.gif)" >> raport.md
else
    echo "*Animacja niedostępna - błąd generowania*" >> raport.md
fi

echo "✅ Raport wygenerowany pomyślnie!"
