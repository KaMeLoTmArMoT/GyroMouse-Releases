# GyroMouse Release Distribution Repository 🎯🖱️

Official release distribution channel for GyroMouse binaries, installers, and release verification workflows.

---

## ⬇️ Download & Installation

### Option A: PowerShell Automatic Installer (Windows Recommended)

#### Method 1: Safe Installer (Recommended to prevent Windows Defender false positives)

If Windows Defender flags one-liner script execution, run this safe downloader command:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/KaMeLoTmArMoT/GyroMouse-Releases/main/install.ps1" -OutFile "$env:TEMP\install.ps1"; powershell -ExecutionPolicy Bypass -File "$env:TEMP\install.ps1"; Remove-Item "$env:TEMP\install.ps1"
```

#### Method 2: Direct One-Liner

```powershell
powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/KaMeLoTmArMoT/GyroMouse-Releases/main/install.ps1 | iex"
```

*Installs binaries to `%LOCALAPPDATA%\GyroMouse` and creates Desktop and Start Menu shortcuts.*

### Option B: Manual Assets

Download platform binaries from the [**Releases**](https://github.com/KaMeLoTmArMoT/GyroMouse-Releases/releases/latest) page:

- 🖥️ **`GyroMouse-vX.X.X.exe`** — Windows Server (standalone EXE ~20MB).
- 📱 **`gyromouse-android-vX.X.X.apk`** — Android Client (ARM64 `arm64-v8a` ~9MB).
- 🌐 **`gyromouse-extension-vX.X.X.zip`** — Chrome Extension (load unpacked in `chrome://extensions`).

### Option C: Quick QR Code APK Download

1. Launch `GyroMouse.exe` on your PC.
2. Open Web Dashboard (`http://127.0.0.1:5000`).
3. Scan the Aztec/QR code on screen with your phone camera to open GitHub Releases directly.

---

## 🌟 Latest Release Highlights (v0.19.0)

- 📱 **Background Media Remote & Lock Screen Controls**: Low-power Android foreground service with native MediaSession and lock screen playback controls (⏪ 15s, ⏯️, ⏩ 15s, Volume +/-) with zero sensor drain while minimized.
- 🎙️ **Smart Voice Typing & 3-Finger Pinch Gestures**: Smart TV-style voice dictation with live text/cursor synchronization, and iOS-style 3-finger pinch in/out for instant Copy & Paste macros.
- 🔄 **Live Updater with Rollback Circuit Breaker**: Real-time download progress bar and percentage, manual check triggers from system tray/web dashboard, and automatic 7-day 3-rollback stability circuit breaker.
- 🛡️ **Out-of-Process Worker Crash Isolation**: Out-of-process COM UIAutomation and text extraction worker isolating C-level access violations (`0xC0000005`), combined with debounced text sync and sanitized crash diagnostics (`/api/report`).
- ⚡ **Share Discovery & High-Performance Web UI**: Multi-device mDNS auto-detection, sleep/wake recovery keep-alive, and esbuild-bundled GZip-compressed web assets.

---

## 🧪 Automated CI Release Verification

Every release undergoes automated validation:
- **Windows Server (EXE):** Verified on a Windows runner for startup, port initialization (UDP 5005, WS 5006), and log clean state.
- **Chrome Extension (ZIP):** Verified via headless Chromium on a Linux runner for zero initialization or console errors.
- **Android App (APK):** Verified on an ARM64 emulator runner for clean APK installation and launch state.

---

## 🔐 Legal & Privacy Notices

- **Privacy Policy:** Read [`PRIVACY.md`](file:///g:/programming/GyroMouse/release_repo/PRIVACY.md). GyroMouse operates entirely locally over Wi-Fi without cloud telemetry.
- **License Agreement:** Read [`LICENSE.md`](file:///g:/programming/GyroMouse/release_repo/LICENSE.md). GyroMouse distribution binaries are subject to the project EULA.
