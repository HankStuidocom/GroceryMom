Add-Type -AssemblyName System.Drawing

$srcPath = "H:\Grocery List\App Image\Logo.png"
$resDir = "H:\Grocery List\android\app\src\main\res"

if (-not (Test-Path $srcPath)) {
    Write-Error "Source logo not found at $srcPath"
    exit 1
}

$densities = @(
    @{ name = "mipmap-mdpi"; iconSize = 48; fgSize = 108 },
    @{ name = "mipmap-hdpi"; iconSize = 72; fgSize = 162 },
    @{ name = "mipmap-xhdpi"; iconSize = 96; fgSize = 216 },
    @{ name = "mipmap-xxhdpi"; iconSize = 144; fgSize = 324 },
    @{ name = "mipmap-xxxhdpi"; iconSize = 192; fgSize = 432 }
)

$srcImage = [System.Drawing.Image]::FromFile($srcPath)

function Resize-Image($image, $targetWidth, $targetHeight, $destPath) {
    $bmp = New-Object System.Drawing.Bitmap($targetWidth, $targetHeight)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear([System.Drawing.Color]::Transparent)
    $g.DrawImage($image, 0, 0, $targetWidth, $targetHeight)
    $bmp.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $bmp.Dispose()
}

function Create-Foreground($image, $fgSize, $destPath) {
    $bmp = New-Object System.Drawing.Bitmap($fgSize, $fgSize)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear([System.Drawing.Color]::Transparent)
    
    # In adaptive icons, the safe central circle is ~72dp of the 108dp area (66.6% to 75%)
    $innerSize = [int]($fgSize * 0.72)
    $offset = [int](($fgSize - $innerSize) / 2)
    $g.DrawImage($image, $offset, $offset, $innerSize, $innerSize)
    $bmp.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $bmp.Dispose()
}

# Generate launcher icons for each mipmap density
foreach ($d in $densities) {
    $dir = Join-Path $resDir $d.name
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }

    # 1. Standard launcher icon
    $icLauncher = Join-Path $dir "ic_launcher.png"
    Resize-Image $srcImage $d.iconSize $d.iconSize $icLauncher

    # 2. Round launcher icon
    $icRound = Join-Path $dir "ic_launcher_round.png"
    Resize-Image $srcImage $d.iconSize $d.iconSize $icRound

    # 3. Adaptive launcher foreground
    $icFg = Join-Path $dir "ic_launcher_foreground.png"
    Create-Foreground $srcImage $d.fgSize $icFg

    Write-Host "Generated $($d.name): $($d.iconSize)x$($d.iconSize) icon and $($d.fgSize)x$($d.fgSize) foreground"
}

# Also update splash screen in res/drawable
$drawableDir = Join-Path $resDir "drawable"
if (Test-Path $drawableDir) {
    $splashPath = Join-Path $drawableDir "splash.png"
    Resize-Image $srcImage 240 240 $splashPath
    Write-Host "Updated splash.png in res/drawable"
}

# Update splash in orientation directories
$splashDirs = @(
    "drawable-land-hdpi", "drawable-land-mdpi", "drawable-land-xhdpi", "drawable-land-xxhdpi", "drawable-land-xxxhdpi",
    "drawable-port-hdpi", "drawable-port-mdpi", "drawable-port-xhdpi", "drawable-port-xxhdpi", "drawable-port-xxxhdpi"
)

foreach ($sd in $splashDirs) {
    $sdir = Join-Path $resDir $sd
    if (Test-Path $sdir) {
        $splashPath = Join-Path $sdir "splash.png"
        Resize-Image $srcImage 240 240 $splashPath
    }
}

$srcImage.Dispose()
Write-Host "All Android icons and splash assets successfully generated from Logo.png!"
