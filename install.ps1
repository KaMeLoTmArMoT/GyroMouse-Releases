# ═══════════════════════════════════════════════════════════════
#  GyroMouse Windows Installer Script
#  Installs the latest server EXE and Chrome Extension zip.
# ═══════════════════════════════════════════════════════════════
$ErrorActionPreference = "Stop"

Write-Host "🎯 Installing GyroMouse..." -ForegroundColor Cyan

# 1. Fetch Latest Release Assets & Manifest
$manifestUrl = "https://raw.githubusercontent.com/KaMeLoTmArMoT/GyroMouse-Releases/main/latest-versions.json"
$apiUrl = "https://api.github.com/repos/KaMeLoTmArMoT/GyroMouse-Releases/releases"
Write-Host "🔍 Fetching release metadata..." -ForegroundColor Gray

# Set SecurityProtocol to TLS 1.2/1.3 for download success
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

$exeUrl = $null
$zipUrl = $null
$version = "latest"

# Strategy A: Try downloading latest-versions.json (no rate limits, instant)
try {
    $manifest = Invoke-RestMethod -Uri $manifestUrl -UseBasicParsing -TimeoutSec 10
    if ($manifest.components.server.url -and $manifest.components.extension.url) {
        $exeUrl = $manifest.components.server.url
        $zipUrl = $manifest.components.extension.url
        $version = $manifest.components.server.version
        Write-Host "⚡ Resolved download URLs via version manifest ($version)." -ForegroundColor Gray
    }
} catch {
    # Non-critical, fallback to GitHub API
}

# Strategy B: Fallback to GitHub Releases API (traverse releases to support sparse releases)
if (!$exeUrl -or !$zipUrl) {
    try {
        $releases = Invoke-RestMethod -Uri $apiUrl -UseBasicParsing -TimeoutSec 15
        if ($releases -and $releases.Count -gt 0) {
            foreach ($rel in $releases) {
                if (!$exeUrl) {
                    $foundExe = $rel.assets | Where-Object { $_.name -like "*.exe" } | Select-Object -First 1
                    if ($foundExe) {
                        $exeUrl = $foundExe.browser_download_url
                        if ($version -eq "latest") { $version = $rel.tag_name }
                    }
                }
                if (!$zipUrl) {
                    $foundZip = $rel.assets | Where-Object { $_.name -like "*.zip" } | Select-Object -First 1
                    if ($foundZip) {
                        $zipUrl = $foundZip.browser_download_url
                    }
                }
                if ($exeUrl -and $zipUrl) { break }
            }
        }
    } catch {
        Write-Error "Failed to fetch release metadata from GitHub: $_"
        exit 1
    }
}

if (!$exeUrl) {
    Write-Error "Could not find a server (.exe) asset across recent releases."
    exit 1
}
if (!$zipUrl) {
    Write-Error "Could not find a Chrome Extension (.zip) asset across recent releases."
    exit 1
}

Write-Host "📦 Found latest server version: $version" -ForegroundColor Green

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
    Invoke-WebRequest -Uri $exeUrl -OutFile $exePath -UseBasicParsing
} catch {
    Write-Error "Failed to download Server EXE: $_"
    exit 1
}

# 4. Download and Extract Chrome Extension
Write-Host "⬇️ Downloading Chrome Extension..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath -UseBasicParsing
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
