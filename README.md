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
- 📋 **`latest-versions.json`** — Machine-readable release metadata manifest for automated downloads and version resolution across sparse releases.

### Option C: Quick QR Code APK Download

1. Launch `GyroMouse.exe` on your PC.
2. Open Web Dashboard (`http://127.0.0.1:5000`).
3. Scan the Aztec/QR code on screen with your phone camera to open GitHub Releases directly.

---

## 🌟 Latest Release Highlights (v0.20.0)

- 🦀 **Native Win32 Subsystem in Rust**: Purged legacy Python `pyautogui`, `pywin32`, and `uiautomation` dependencies. Replaced with ultra-low-latency native Win32 keyboard/mouse injection, display bounds, and system audio/power management in `rust_core`.
- 🎯 **Native Spatial UIAutomation & Raycaster**: Custom Rust window occlusion raycasting and spatial bounding box pruning to eliminate phantom snap targets and prevent UI thread hangs.
- 📱 **Redesigned Android Touchpad UI**: Modernized Jetpack Compose touchpad surface with configurable edge scroll speed (default 0.3x) for silky-smooth continuous panning.
- 🚀 **Streamlined Releases & Zero-Waste CI**: Optimized GitHub Actions distribution targeting `GyroMouse-Releases` with minimal storage footprint and updated Copilot AI release notes.

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
