
import numpy as np
from PIL import Image, ImageDraw

def generate_topography():
    # Domain size in pixels (should match N_POINTS_PLOT or be high enough resolution)
    H, W = 256, 256
    
    # Create a new image with mode 'F' (32-bit floating point pixels)
    # We want values between 0.0 (deep) and maybe 0.5 (shallow/mountains)
    # Let's create an image to visualize first, then specific values can be mapped.
    # Using 'L' (8-bit pixels, black and white) for easy visualization and compatibility.
    image = Image.new('L', (W, H), 0)
    draw = ImageDraw.Draw(image)
    
    # Gradient background - deeper as x increases? or a hill int the middle?
    # Let's make a rising slope: deep at x=0 (black), shallow at x=LENGTH (white)
    # x is horizontal, y is vertical in PIL coordinates?
    # Usually: (0,0) is top-left in PIL.
    
    # Let's create a "sea mount" or "island" shape in the middle.
    # A radial gradient.
    
    # We can iterate specifically to create a numpy array and save it.
    
    x = np.linspace(0, 1, W)
    y = np.linspace(0, 1, H)
    xv, yv = np.meshgrid(x, y)
    
    # 2D Gaussian hill
    sigma = 0.2
    x0, y0 = 0.5, 0.5
    # Height of 0.8 at peak
    z = 0.8 * np.exp(-((xv - x0)**2 + (yv - y0)**2) / (2 * sigma**2))
    
    # Convert to 0-255 uint8 for L mode
    z_img = (z * 255).astype(np.uint8)
    
    image = Image.fromarray(z_img, mode='L')
    
    # Save
    image.save("project2_tsunami/topography.png")
    print("Generated topography.png with a Gaussian hill.")

if __name__ == "__main__":
    generate_topography()
