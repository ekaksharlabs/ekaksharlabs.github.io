# Simple Video Optimization Script for EkLabs Website
Write-Host "Starting video optimization..." -ForegroundColor Green

# Create optimized directory
$optimizedDir = "eklabs-website\assets\videos\optimized"
if (!(Test-Path $optimizedDir)) {
    New-Item -ItemType Directory -Path $optimizedDir -Force
    Write-Host "Created directory: $optimizedDir" -ForegroundColor Yellow
}

# Define videos to optimize
$videos = @(
    @{input=".\eklabs-website\assets\videos\robotics\factory.mp4"; output="eklabs-website\assets\videos\optimized\robotics\factory_optimized.mp4"},
    @{input=".\eklabs-website\assets\videos\robotics\labs.mp4"; output="eklabs-website\assets\videos\optimized\robotics\labs_optimized.mp4"},
    @{input=".\eklabs-website\assets\videos\robotics\manufacturing.mp4"; output="eklabs-website\assets\videos\optimized\robotics\manufacturing_optimized.mp4"}
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
