# Symulacja Przenoszenia Ciepła IGA-ADS

## Przegląd Skryptów

### Skrypty Główne

- **`src/scripts/setup.sh`** - Początkowa konfiguracja projektu (Docker, zależności)
- **`src/scripts/cleanup.sh`** - Czyszczenie artefaktów budowania i kontenerów Docker
- **`src/scripts/run_heat_simulation.sh <time_step>`** - Uruchomienie animacji z niestandardowym krokiem czasowym
- **`src/scripts/generate_markdown_report.sh`** - Generowanie raportu markdown z informacjami o systemie
- **`src/scripts/generate_pdf_report.sh`** - Konwersja markdown do PDF

### Użycie

1. **Konfiguracja**: `./src/scripts/setup.sh`
2. **Uruchomienie symulacji**: `./src/scripts/run_heat_simulation.sh 1e-5`
3. **Generowanie raportu markdown**: `./src/scripts/generate_markdown_report.sh`
4. **Tworzenie raportu PDF z markdown**: `./src/scripts/generate_pdf_report.sh`

### Wymagania

- Docker Desktop
- Git
- Gnuplot (`brew install gnuplot`)
- Pandoc (`brew install pandoc`)
- ImageMagick (`brew install imagemagick`)
- LaTeX (opcjonalne, dla lepszego formatowania PDF)

### Wyniki

- **Wyniki symulacji**: `res/out/heat_2d_<time_step>/`
- **Animacje**: `res/heat_2d_<time_step>.gif`
- **Raport**: `raport.md` i `raport.pdf`

## Wygenerowany Raport

Projekt generuje kompleksowy raport analizujący symulację przenoszenia ciepła:

- **[raport.md](raport.md)** - Szczegółowy raport markdown z informacjami o systemie, wynikami symulacji i analizą stabilności
- **raport.pdf** - Profesjonalna wersja PDF z odpowiednim formatowaniem i statycznymi obrazami

Raport zawiera:

- Specyfikacje sprzętu systemu
- Szczegóły środowiska Docker
- Logi konfiguracji CMake i kompilacji
- Wyniki wykonania symulacji
- Analizę stabilności numerycznej (maksymalny stabilny vs minimalny niestabilny krok czasowy)
- Wizualne porównania z wygenerowanymi animacjami
