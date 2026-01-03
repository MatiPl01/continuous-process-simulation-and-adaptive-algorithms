# Project 2: Tsunami Simulation with PINN

## Description

This project implements a Physics-Informed Neural Network (PINN) to simulate tsunami wave propagation over a variable sea floor topography. It solves the 2D shallow water equations (or a simplified wave equation) accounting for depth variations.

## Changes from Original

- **Topography Generation**: Added `generate_topography.py` to create `topography.png`, representing the sea floor.
- **Topography Integration**: Modified `PINN_tsunami_2d.ipynb`:
  - Loaded `topography.png` as a tensor.
  - Updated `floor(x, y)` function to sample from the topography tensor using `torch.nn.functional.grid_sample`.
  - Updated `plot_3D` to correctly visualize the vectorized floor.

## How to Run

1. Generate topography:
   ```bash
   python generate_topography.py
   ```
2. Run the notebook:
   - Open `PINN_tsunami_2d.ipynb` in Jupyter.
   - Run all cells.
   - The output `tsunami_wave12.gif` will be generated.
