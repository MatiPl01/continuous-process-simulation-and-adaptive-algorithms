import numpy as np
from PIL import Image

def generate_seafloor_topography():
    """Generate a synthetic seafloor topography with a sloping shelf and deeper ocean."""
    H, W = 256, 256
    
    # Create depth map (0 = sea level, negative = below sea level)
    # Simulate a continental shelf that slopes down
    x = np.linspace(0, 2, W)  # domain is [0, 2] in x
    y = np.linspace(0, 1, H)  # domain is [0, 1] in y
    X, Y = np.meshgrid(x, y)
    
    # Create a sloping seafloor (deeper towards right side)
    # and add a Gaussian bump in the middle (underwater mountain/ridge)
    base_depth = -0.3 - 0.2 * X  # Slopes from -0.3 to -0.7
    
    # Add underwater feature (seamount)
    bump_x, bump_y = 1.0, 0.5
    bump_amplitude = 0.15
    bump_width = 0.3
    bump = bump_amplitude * np.exp(-((X - bump_x)**2 + (Y - bump_y)**2) / (2 * bump_width**2))
    
    depth = base_depth + bump
    
    # Normalize to [0, 255] for image (we'll denormalize when loading)
    # Store depth as grayscale: darker = deeper
    depth_min, depth_max = depth.min(), depth.max()
    depth_normalized = 255 * (depth - depth_min) / (depth_max - depth_min)
    
    image = Image.fromarray(depth_normalized.astype(np.uint8), mode='L')
    image.save("project2_tsunami/topography.png")
    
    print(f"Generated topography: depth range [{depth_min:.3f}, {depth_max:.3f}]")
    print("Saved to project2_tsunami/topography.png")

if __name__ == "__main__":
    generate_seafloor_topography()
