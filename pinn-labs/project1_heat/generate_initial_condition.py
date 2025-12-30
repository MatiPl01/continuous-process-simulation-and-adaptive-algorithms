
import numpy as np
from PIL import Image, ImageDraw

def generate_simple_smiley():
    # Create 256x256 canvas (black background)
    H, W = 256, 256
    image = Image.new('L', (W, H), 0)
    draw = ImageDraw.Draw(image)
    
    # Draw a LARGE white circle for the face (bigger and simpler)
    draw.ellipse([30, 30, 226, 226], fill=255)
    
    # Draw LARGER black circles for eyes
    draw.ellipse([70, 80, 110, 120], fill=0)
    draw.ellipse([146, 80, 186, 120], fill=0)
    
    # Draw a SIMPLER black smile (just a crescent/arc, thicker)
    # Use chord to fill a section
    draw.pieslice([70, 100, 186, 180], start=0, end=180, fill=0)
    # Cover the top part to leave just the smile
    draw.ellipse([70, 100, 186, 160], fill=255)
    
    # Save
    image.save("project1_heat/initial_condition.png")
    print("Generated SIMPLE, BOLD smiley face initial_condition.png")

if __name__ == "__main__":
    generate_simple_smiley()
