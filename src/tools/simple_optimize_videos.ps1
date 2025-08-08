# Simple Video Optimization Script for EkLabs Website
Write-Host "Starting video optimization..." -ForegroundColor Green

# Create optimized directory
$optimizedDir = "assets\videos\optimized"
if (!(Test-Path $optimizedDir)) {
    New-Item -ItemType Directory -Path $optimizedDir -Force
    Write-Host "Created directory: $optimizedDir" -ForegroundColor Yellow
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
        Write-Host "Processing: $inputPath" -ForegroundColor Cyan
        Write-Host "Output: $outputPath" -ForegroundColor Gray
        
        try {
            & ffmpeg -i $inputPath -vcodec libx264 -preset fast -crf 28 -vf "scale=-2:720" -acodec aac -b:a 96k -movflags "+faststart" -pix_fmt yuv420p -y $outputPath 2>$null
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "Successfully optimized: $($video.output)" -ForegroundColor Green
                
                if (Test-Path $outputPath) {
                    $originalSize = (Get-Item $inputPath).Length
                    $optimizedSize = (Get-Item $outputPath).Length
                    $compressionRatio = [math]::Round((1 - ($optimizedSize / $originalSize)) * 100, 1)
                    
                    Write-Host "Original: $([math]::Round($originalSize/1MB, 2)) MB" -ForegroundColor Gray
                    Write-Host "Optimized: $([math]::Round($optimizedSize/1MB, 2)) MB" -ForegroundColor Gray
                    Write-Host "Compression: $compressionRatio% smaller" -ForegroundColor Green
                }
                
                $successCount++
            } else {
                Write-Host "Failed to optimize: $inputPath" -ForegroundColor Red
                $errorCount++
            }
        } catch {
            Write-Host "Error processing $inputPath : $_" -ForegroundColor Red
            $errorCount++
        }
    } else {
        Write-Host "File not found: $inputPath" -ForegroundColor Yellow
        $errorCount++
    }
    Write-Host "---" -ForegroundColor Gray
}

Write-Host "Video optimization complete!" -ForegroundColor Green
Write-Host "Success: $successCount videos" -ForegroundColor Green
Write-Host "Errors: $errorCount videos" -ForegroundColor Red
