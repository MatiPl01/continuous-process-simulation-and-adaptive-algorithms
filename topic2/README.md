# IGA-ADS Heat Transfer Simulation

This project demonstrates heat transfer simulation using the IGA-ADS (Isogeometric Analysis) framework with Docker containerization.

## Project Structure

```
topic2/
├── README.md                    # This file
├── .gitignore                   # Git ignore rules
├── iga-ads/                     # IGA-ADS source code (cloned)
├── scripts/                     # Automation scripts
│   ├── setup.sh                 # Setup project
│   ├── run_simulation.sh        # Run simulation
│   ├── generate_plots.sh        # Generate visualizations
│   ├── static_plots.gp          # Gnuplot static plots
│   └── animation.gp             # Gnuplot animation
├── res/                         # Simulation results and visualizations
└── instructions/                # Documentation PDFs
```

## Prerequisites

- Docker installed and running
- Git (for cloning the repository)

## Quick Start

### 1. Setup Project

```bash
# Clone repository and build Docker image
./scripts/setup.sh
```

### 2. Run Simulation

```bash
# Run the heat transfer simulation
./scripts/run_simulation.sh
```

### 3. Generate Visualizations

```bash
# Generate static plots and animation
./scripts/generate_plots.sh
```

## Manual Setup (Alternative)

### 1. Clone the IGA-ADS Repository

```bash
git clone https://github.com/IGA-ADS/iga-ads.git
```

### 2. Build Docker Image

```bash
cd iga-ads/
docker build -t iga-ads:latest .
cd ..
```

### 3. Run Simulation

```bash
# Run the heat transfer simulation
docker run --rm -v $(pwd)/../../res:/output iga-ads:latest bash -c "
  cd /code/build/examples &&
  ./heat_2d &&
  cp out_*.data /output/out/
"
```

### 4. Generate Visualizations

```bash
# Install gnuplot (macOS)
brew install gnuplot

# Generate static plots
gnuplot scripts/static_plots.gp

# Generate animation
gnuplot scripts/animation.gp
```

## Results

After running the simulation, you'll find in the `res/` directory:

- **`out/`** - 100 data files (out_0.data to out_9900.data) containing temperature fields
- **`heat_initial.png`** - Initial temperature distribution
- **`heat_final.png`** - Final temperature distribution
- **`heat_transfer_animation.gif`** - Animated visualization of heat transfer

## Simulation Details

- **Problem**: 2D heat transfer simulation
- **Grid**: 40×40 points
- **Time steps**: 10,000 iterations
- **Output**: Every 100 steps
- **Method**: Isogeometric Analysis with Galois parallel processing

## Troubleshooting

- If Docker build fails, ensure Docker is running and you have sufficient disk space
- If gnuplot fails, install it via `brew install gnuplot` (macOS) or your system package manager
- Large data files are excluded from git - they will be generated when you run the simulation
