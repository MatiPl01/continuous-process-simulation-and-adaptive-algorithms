
import numpy as np
from PIL import Image
import scipy.ndimage

def generate_topography():
    size = 256
    # Black background (deep water)
    img = np.zeros((size, size), dtype=np.float32)
    
    # Draw L-shape (asymmetrical)
    # Vertical bar
    img[40:216, 60:120] = 1.0
    # Horizontal bar
    img[156:216, 100:210] = 1.0
    
    # Apply Gaussian blur to smooth the edges
    # Sigma=5 provides a balance between shape definition and differentiability for the PINN
    img_smooth = scipy.ndimage.gaussian_filter(img, sigma=5)
    
    # Normalize to desired height range (0.8 max height)
    if img_smooth.max() > 0:
        img_smooth = img_smooth / img_smooth.max() * 0.8
        
    # Convert to consistent uint8 for saving
    img_uint8 = (img_smooth * 255).astype(np.uint8)
    
    # Save
    image = Image.fromarray(img_uint8, mode='L')
    image.save("project2_tsunami/topography.png")
    print("Generated topography.png with Smoothed L-shape (Sigma=5).")

if __name__ == "__main__":
    generate_topography()
