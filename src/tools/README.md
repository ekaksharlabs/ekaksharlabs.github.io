# 🛠️ Asset Optimization Tools

This folder contains scripts and tools for optimizing website assets.

## 📁 Contents

### **Image Optimization**
- `optimize_images.py` - Python script to convert images to WebP format with multiple sizes
  - Requires: `pip install Pillow`
  - Usage: `python optimize_images.py`
  - Creates optimized WebP + JPEG versions in `assets/images/optimized/`

### **Video Optimization**
- `optimize_videos.ps1` - Advanced PowerShell script with FFmpeg for video compression
- `simple_optimize_videos.ps1` - Simple PowerShell script for basic video compression
- `install_and_optimize_videos.ps1` - Downloads FFmpeg and optimizes videos automatically

### **Batch Scripts**
- `optimize_assets.bat` - Windows batch file to run both image and video optimization

### **Testing**
- `performance_test.html` - Test page to verify lazy loading and optimization results

## 🚀 Quick Start

### **Option 1: Full Automation (Recommended)**
```bash
# Run the batch file (installs everything needed)
.\optimize_assets.bat
```

### **Option 2: Manual Steps**
```bash
# 1. Install Python dependencies
pip install Pillow

# 2. Optimize images
python optimize_images.py

# 3. Optimize videos (requires FFmpeg)
.\simple_optimize_videos.ps1
```

## 📊 Expected Results

- **Images**: 50% smaller file sizes with WebP format
- **Videos**: 60-70% smaller file sizes with 720p H.264 compression
- **Page Load**: 60-70% faster initial load times

## ⚠️ Notes

- These scripts only need to be run when adding new assets
- Already optimized assets are stored in `assets/images/optimized/` and `assets/videos/optimized/`
- Original files are preserved for future re-optimization if needed
