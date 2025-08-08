# Video Optimization Script for EkLabs Website
# This script optimizes videos by:
# - Reducing resolution to 720p for background videos
# - Compressing with H.264 codec
# - Optimizing for web playback

Write-Host "🚀 Starting video optimization..." -ForegroundColor Green
Write-Host "📁 Output directory: assets/videos/optimized" -ForegroundColor Cyan

# Create optimized directory if it doesn't exist
$optimizedDir = "assets\videos\optimized"
if (!(Test-Path $optimizedDir)) {
    New-Item -ItemType Directory -Path $optimizedDir -Force
    Write-Host "📁 Created directory: $optimizedDir" -ForegroundColor Yellow
}

# Define videos to optimize
$videos = @(
    @{input="..\..\assets\videos\robotics\factory.mp4"; output="eklabs-website\assets\videos\optimized\robotics\factory_optimized.mp4"},
    @{input="..\..\assets\videos\robotics\labs.mp4"; output="eklabs-website\assets\videos\optimized\robotics\labs_optimized.mp4"},
    @{input="..\..\assets\videos\robotics\manufacturing.mp4"; output="eklabs-website\assets\videos\optimized\robotics\manufacturing_optimized.mp4"}
)

# Check if FFmpeg is installed
try {
    $ffmpegVersion = & ffmpeg -version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ FFmpeg is available" -ForegroundColor Green
    }
} catch {
    Write-Host "❌ FFmpeg is not installed or not in PATH" -ForegroundColor Red
    Write-Host "📥 Please install FFmpeg from: https://ffmpeg.org/download.html" -ForegroundColor Yellow
    Write-Host "💡 Or use chocolatey: choco install ffmpeg" -ForegroundColor Yellow
    exit 1
}

$successCount = 0
$errorCount = 0

foreach ($video in $videos) {
    $inputPath = $video.input
    $outputPath = Join-Path $optimizedDir $video.output
    
    if (Test-Path $inputPath) {
        Write-Host "`n🎬 Processing: $inputPath" -ForegroundColor Cyan
        Write-Host "📤 Output: $outputPath" -ForegroundColor Gray
        
        # FFmpeg optimization parameters
        $ffmpegArgs = @(
            "-i", $inputPath,
            "-vcodec", "libx264",           # H.264 codec
            "-preset", "slow",              # Better compression
            "-crf", "23",                   # Constant Rate Factor (23 = good quality)
            "-vf", "scale=-2:720",          # Scale to 720p height, maintain aspect ratio
            "-acodec", "aac",               # AAC audio codec
            "-b:a", "128k",                 # Audio bitrate
            "-movflags", "+faststart",      # Optimize for web streaming
            "-pix_fmt", "yuv420p",          # Ensure compatibility
            "-y",                           # Overwrite output file
            $outputPath
        )
        
        try {
            & ffmpeg @ffmpegArgs 2>$null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ Successfully optimized: $($video.output)" -ForegroundColor Green
                
                # Get file sizes for comparison
                $originalSize = (Get-Item $inputPath).Length
                $optimizedSize = (Get-Item $outputPath).Length
                $compressionRatio = [math]::Round((1 - ($optimizedSize / $originalSize)) * 100, 1)
                
                Write-Host "📊 Original: $([math]::Round($originalSize/1MB, 2)) MB" -ForegroundColor Gray
                Write-Host "📊 Optimized: $([math]::Round($optimizedSize/1MB, 2)) MB" -ForegroundColor Gray
                Write-Host "🗜️  Compression: $compressionRatio% smaller" -ForegroundColor Green
                
                $successCount++
            } else {
                Write-Host "❌ Failed to optimize: $inputPath" -ForegroundColor Red
                $errorCount++
            }
        } catch {
            Write-Host "❌ Error processing $inputPath : $_" -ForegroundColor Red
            $errorCount++
        }
    } else {
        Write-Host "⚠️  File not found: $inputPath" -ForegroundColor Yellow
        $errorCount++
    }
}

Write-Host "`n✨ Video optimization complete!" -ForegroundColor Green
Write-Host "📊 Summary:" -ForegroundColor Cyan
Write-Host "   ✅ Success: $successCount videos" -ForegroundColor Green
Write-Host "   ❌ Errors: $errorCount videos" -ForegroundColor Red
Write-Host "`n🎯 Optimizations applied:" -ForegroundColor Yellow
Write-Host "   • Reduced to 720p resolution" -ForegroundColor Gray
Write-Host "   • H.264 codec with CRF 23" -ForegroundColor Gray
Write-Host "   • AAC audio at 128kbps" -ForegroundColor Gray
Write-Host "   • Optimized for web streaming" -ForegroundColor Gray
