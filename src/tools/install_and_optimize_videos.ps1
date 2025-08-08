# FFmpeg Installation and Video Optimization Script
# This script will help install FFmpeg and optimize videos

Write-Host "🚀 EkLabs Video Optimization Setup" -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Cyan

# Check if FFmpeg is available
$ffmpegAvailable = $false
try {
    & ffmpeg -version 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) {
        $ffmpegAvailable = $true
        Write-Host "✅ FFmpeg is already installed!" -ForegroundColor Green
    }
} catch {
    Write-Host "❌ FFmpeg is not installed" -ForegroundColor Red
}

if (-not $ffmpegAvailable) {
    Write-Host "`n📥 Installing FFmpeg..." -ForegroundColor Yellow
    
    # Try to install with winget (Windows Package Manager)
    try {
        Write-Host "🔄 Attempting to install with winget..." -ForegroundColor Cyan
        & winget install "Gyan.FFmpeg" --accept-source-agreements --accept-package-agreements
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ FFmpeg installed successfully with winget!" -ForegroundColor Green
            Write-Host "🔄 Please restart this script or open a new terminal to use FFmpeg" -ForegroundColor Yellow
            $ffmpegAvailable = $true
        }
    } catch {
        Write-Host "⚠️  winget installation failed" -ForegroundColor Yellow
    }
    
    if (-not $ffmpegAvailable) {
        Write-Host "`n📋 Manual Installation Instructions:" -ForegroundColor Yellow
        Write-Host "1. Go to: https://www.gyan.dev/ffmpeg/builds/" -ForegroundColor Gray
        Write-Host "2. Download the 'release essentials' build" -ForegroundColor Gray
        Write-Host "3. Extract to C:\ffmpeg" -ForegroundColor Gray
        Write-Host "4. Add C:\ffmpeg\bin to your PATH environment variable" -ForegroundColor Gray
        Write-Host "5. Restart this script" -ForegroundColor Gray
        Write-Host "`nOr install with Chocolatey:" -ForegroundColor Yellow
        Write-Host "choco install ffmpeg" -ForegroundColor Gray
        
        Read-Host "`nPress Enter after installing FFmpeg to continue"
        
        # Check again
        try {
            & ffmpeg -version 2>$null | Out-Null
            if ($LASTEXITCODE -eq 0) {
                $ffmpegAvailable = $true
                Write-Host "✅ FFmpeg is now available!" -ForegroundColor Green
            } else {
                Write-Host "❌ FFmpeg still not found. Please install manually." -ForegroundColor Red
                exit 1
            }
        } catch {
            Write-Host "❌ FFmpeg still not found. Please install manually." -ForegroundColor Red
            exit 1
        }
    }
}

# Continue with video optimization if FFmpeg is available
if ($ffmpegAvailable) {
    Write-Host "`n🎬 Starting video optimization..." -ForegroundColor Green
    
    # Create optimized directory if it doesn't exist
    $optimizedDir = "assets\videos\optimized"
    if (!(Test-Path $optimizedDir)) {
        New-Item -ItemType Directory -Path $optimizedDir -Force
        Write-Host "📁 Created directory: $optimizedDir" -ForegroundColor Yellow
    }
    
    # Define videos to optimize
    $videos = @(
        @{input="assets\videos\fireball_small.mp4"; output="fireball_small_720p.mp4"},
        @{input="assets\videos\nightvision.mp4"; output="nightvision_720p.mp4"},
        @{input="assets\videos\thermal.mp4"; output="thermal_720p.mp4"},
        @{input="assets\videos\particle.mp4"; output="particle_720p.mp4"},
        @{input="assets\videos\motion.mp4"; output="motion_720p.mp4"},
        @{input="assets\videos\robo.mp4"; output="robo_720p.mp4"},
        @{input="assets\videos\bacteria.mp4"; output="bacteria_720p.mp4"},
        @{input="assets\videos\career.mp4"; output="career_720p.mp4"}
    )
    
    $successCount = 0
    $errorCount = 0
    
    foreach ($video in $videos) {
        $inputPath = $video.input
        $outputPath = Join-Path $optimizedDir $video.output
        
        if (Test-Path $inputPath) {
            Write-Host "`n🎬 Processing: $inputPath" -ForegroundColor Cyan
            Write-Host "📤 Output: $outputPath" -ForegroundColor Gray
            
            # FFmpeg optimization parameters for web
            $ffmpegArgs = @(
                "-i", $inputPath,
                "-vcodec", "libx264",
                "-preset", "fast",              # Faster encoding
                "-crf", "28",                   # Higher compression for web
                "-vf", "scale=-2:720",          # Scale to 720p
                "-acodec", "aac",
                "-b:a", "96k",                  # Lower audio bitrate
                "-movflags", "+faststart",
                "-pix_fmt", "yuv420p",
                "-y",
                $outputPath
            )
            
            try {
                # Show progress
                Write-Host "🔄 Optimizing video..." -ForegroundColor Yellow
                & ffmpeg @ffmpegArgs 2>$null
                
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "✅ Successfully optimized: $($video.output)" -ForegroundColor Green
                    
                    # Get file sizes for comparison
                    if (Test-Path $outputPath) {
                        $originalSize = (Get-Item $inputPath).Length
                        $optimizedSize = (Get-Item $outputPath).Length
                        $compressionRatio = [math]::Round((1 - ($optimizedSize / $originalSize)) * 100, 1)
                        
                        Write-Host "📊 Original: $([math]::Round($originalSize/1MB, 2)) MB" -ForegroundColor Gray
                        Write-Host "📊 Optimized: $([math]::Round($optimizedSize/1MB, 2)) MB" -ForegroundColor Gray
                        Write-Host "🗜️  Compression: $compressionRatio% smaller" -ForegroundColor Green
                    }
                    
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
    Write-Host "   - Reduced to 720p resolution" -ForegroundColor Gray
    Write-Host "   - H.264 codec with CRF 28" -ForegroundColor Gray
    Write-Host "   - AAC audio at 96kbps" -ForegroundColor Gray
    Write-Host "   - Optimized for web streaming" -ForegroundColor Gray
}
