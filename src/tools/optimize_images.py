#!/usr/bin/env python3
"""
Image Optimization Script for EkLabs Website
This script optimizes images by:
- Converting to WebP format
- Creating multiple sizes (thumbnails and full size)
- Compressing without significant quality loss
"""

import os
import sys
from PIL import Image, ImageOps
import pillow_heif

# Register HEIF opener with Pillow
pillow_heif.register_heif_opener()

def optimize_image(input_path, output_dir, base_name, sizes=[400, 800]):
    """
    Optimize a single image file
    """
    try:
        # Open and process image
        with Image.open(input_path) as img:
            # Convert to RGB if necessary (for WebP compatibility)
            if img.mode in ('RGBA', 'LA', 'P'):
                img = img.convert('RGB')
            
            # Auto-orient based on EXIF data
            img = ImageOps.exif_transpose(img)
            
            # Create different sizes
            for size in sizes:
                # Calculate new dimensions maintaining aspect ratio
                img_ratio = img.width / img.height
                if img.width > img.height:
                    new_width = size
                    new_height = int(size / img_ratio)
                else:
                    new_height = size
                    new_width = int(size * img_ratio)
                
                # Resize image
                resized_img = img.resize((new_width, new_height), Image.LANCZOS)
                
                # Save as WebP with high quality
                output_path = os.path.join(output_dir, f"{base_name}_{size}w.webp")
                resized_img.save(output_path, 'WebP', quality=85, method=6)
                print(f"✅ Created: {output_path}")
                
                # Also create JPEG fallback for older browsers
                jpeg_path = os.path.join(output_dir, f"{base_name}_{size}w.jpg")
                resized_img.save(jpeg_path, 'JPEG', quality=85, optimize=True)
                print(f"✅ Created: {jpeg_path}")
                
    except Exception as e:
        print(f"❌ Error processing {input_path}: {e}")

def main():
    # Define input images and their base names
    images_to_optimize = [
        ("assets/images/hyper/florida/florida_etm_2011314_432_xlrg.jpg", "florida_432"),
        ("assets/images/hyper/piqiang/piqiang_ast_2005055_468_decorrelation_lrg.jpg", "piqiang_468"),
        ("assets/images/hyper/piqiang/piqiang_ast_2005055_nir_gray_lrg.jpg", "piqiang_nir"),
    ]
    
    output_dir = "assets/images/optimized"
    
    # Create output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)
    
    print("🚀 Starting image optimization...")
    print(f"📁 Output directory: {output_dir}")
    
    for input_path, base_name in images_to_optimize:
        if os.path.exists(input_path):
            print(f"\n📸 Processing: {input_path}")
            optimize_image(input_path, output_dir, base_name)
        else:
            print(f"⚠️  File not found: {input_path}")
    
    print("\n✨ Image optimization complete!")
    print("\n📊 Summary:")
    print("- Created WebP versions for modern browsers (85% quality)")
    print("- Created JPEG fallbacks for older browsers")
    print("- Generated 400px and 800px versions for responsive loading")

if __name__ == "__main__":
    # Check if Pillow is installed
    try:
        import PIL
        print(f"📦 Using Pillow version: {PIL.__version__}")
    except ImportError:
        print("❌ Pillow is not installed. Please install it with: pip install Pillow pillow-heif")
        sys.exit(1)
    
    main()
