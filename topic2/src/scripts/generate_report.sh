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

# Create report
cat > REPORT.md << EOF
# Raport IGA-ADS

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

---

*Raport wygenerowany: $(date '+%Y-%m-%d %H:%M:%S')*
EOF
