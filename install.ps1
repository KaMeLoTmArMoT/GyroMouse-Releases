# ═══════════════════════════════════════════════════════════════
#  GyroMouse Windows Installer Script
#  Installs the latest server EXE and Chrome Extension zip.
# ═══════════════════════════════════════════════════════════════
$ErrorActionPreference = "Stop"

Write-Host "🎯 Installing GyroMouse..." -ForegroundColor Cyan

# 1. Fetch Latest Release
$apiUrl = "https://api.github.com/repos/KaMeLoTmArMoT/GyroMouse-Releases/releases/latest"
Write-Host "🔍 Fetching release metadata from GitHub..." -ForegroundColor Gray

try {
    # Set SecurityProtocol to TLS 1.2/1.3 for download success
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13
    $release = Invoke-RestMethod -Uri $apiUrl -UseBasicParsing
} catch {
    Write-Error "Failed to fetch latest release metadata from GitHub: $_"
    exit 1
}

$exeAsset = $release.assets | Where-Object { $_.name -like "*.exe" } | Select-Object -First 1
$zipAsset = $release.assets | Where-Object { $_.name -like "*.zip" } | Select-Object -First 1

if (!$exeAsset) {
    Write-Error "Could not find a server (.exe) asset in the latest release."
    exit 1
}
if (!$zipAsset) {
    Write-Error "Could not find a Chrome Extension (.zip) asset in the latest release."
    exit 1
}

$version = $release.tag_name
Write-Host "📦 Found latest version: $version" -ForegroundColor Green

# 2. Setup Directories
$installDir = Join-Path $env:LOCALAPPDATA "GyroMouse"
if (!(Test-Path $installDir)) {
    Write-Host "📁 Creating installation directory at $installDir..." -ForegroundColor Gray
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
}

$exePath = Join-Path $installDir "GyroMouse.exe"
$zipPath = Join-Path $installDir "chrome_extension.zip"
$extDir = Join-Path $installDir "chrome_extension"

# 3. Download Server EXE
Write-Host "⬇️ Downloading GyroMouse Server..." -ForegroundColor Gray
try {
    # Force Taskkill if running to prevent file locking
    taskkill /F /IM GyroMouse.exe > $null 2>&1
    Start-Sleep -Milliseconds 500
} catch {}

try {
    Invoke-WebRequest -Uri $exeAsset.browser_download_url -OutFile $exePath -UseBasicParsing
} catch {
    Write-Error "Failed to download Server EXE: $_"
    exit 1
}

# 4. Download and Extract Chrome Extension
Write-Host "⬇️ Downloading Chrome Extension..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri $zipAsset.browser_download_url -OutFile $zipPath -UseBasicParsing
} catch {
    Write-Error "Failed to download Chrome Extension: $_"
    exit 1
}

Write-Host "📦 Extracting Chrome Extension..." -ForegroundColor Gray
try {
    if (Test-Path $extDir) {
        Remove-Item -Recurse -Force $extDir
    }
    # Unpack Zip
    Expand-Archive -Path $zipPath -DestinationPath $extDir -Force
    Remove-Item -Force $zipPath
} catch {
    Write-Error "Failed to extract Chrome Extension: $_"
    exit 1
}

# 5. Create Shortcuts
Write-Host "🔗 Creating shortcuts..." -ForegroundColor Gray
try {
    $wscript = New-Object -ComObject WScript.Shell

    # Desktop Shortcut
    $desktopShortcut = $wscript.CreateShortcut("$env:USERPROFILE\Desktop\GyroMouse.lnk")
    $desktopShortcut.TargetPath = $exePath
    $desktopShortcut.WorkingDirectory = $installDir
    $desktopShortcut.Description = "GyroMouse PC Server"
    $desktopShortcut.IconLocation = "$exePath,0"
    $desktopShortcut.Save()

    # Start Menu Shortcut
    $programsPath = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs"
    $startShortcut = $wscript.CreateShortcut("$programsPath\GyroMouse.lnk")
    $startShortcut.TargetPath = $exePath
    $startShortcut.WorkingDirectory = $installDir
    $startShortcut.Description = "GyroMouse PC Server"
    $startShortcut.IconLocation = "$exePath,0"
    $startShortcut.Save()
} catch {
    Write-Warning "Failed to create shortcuts: $_"
}

Write-Host "`n🎉 Installation Completed Successfully!" -ForegroundColor Green
Write-Host "--------------------------------------------------------" -ForegroundColor Gray
Write-Host "🚀 GyroMouse $version has been installed to:" -ForegroundColor Gray
Write-Host "   $exePath" -ForegroundColor Cyan
Write-Host "🌐 The Chrome Extension has been extracted to:" -ForegroundColor Gray
Write-Host "   $extDir" -ForegroundColor Cyan
Write-Host "`n👉 To start:" -ForegroundColor Gray
Write-Host "   1. Launch GyroMouse using the shortcut on your Desktop or Start Menu." -ForegroundColor Gray
Write-Host "   2. Install the Chrome Extension: Open Chrome -> chrome://extensions/ -> Enable 'Developer mode' -> Click 'Load unpacked' -> Select the Chrome Extension directory listed above." -ForegroundColor Gray
Write-Host "--------------------------------------------------------"
