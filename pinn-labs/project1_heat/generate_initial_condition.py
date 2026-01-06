import numpy as np
import imageio.v3 as iio
import os

def create_l_shape(size=256):
    # Black background
    img = np.zeros((size, size), dtype=np.uint8)
    
    # Draw L-shape (asymmetrical)
    # Vertical bar: from row 40 to 216, col 60 to 100
    img[40:216, 60:100] = 255
    # Horizontal bar: from row 176 to 216, col 100 to 200
    img[176:216, 100:210] = 255
    
    return img

if __name__ == "__main__":
    img = create_l_shape()
    output_path = "initial_condition.png"
    iio.imwrite(output_path, img)
    print(f"Generated asymmetrical L-shape initial condition at {output_path}")
