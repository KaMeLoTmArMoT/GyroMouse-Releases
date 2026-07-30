# GyroMouse Release Distribution Repository 🎯🖱️

Official release distribution channel for GyroMouse binaries, installers, and release verification workflows.

---

## ⬇️ Download & Installation

### Option A: PowerShell Automatic Installer (Windows Recommended)

Run the one-liner installer in PowerShell to auto-download and install GyroMouse:

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

## 🌟 Latest Release Highlights (v0.17.0)

- 🎮 **2-Player Co-Op & Solo Tilt Modes**: Play together in 2-Player Co-Op or Solo tilt control modes with smooth role switching.
- 🔄 **Reliable Auto-Updates**: Seamless background updates that automatically close old instances and replace files safely.
- 🛡️ **Enhanced Crash Protection**: Solidified Windows UI element scanning to prevent unexpected crashes during video playback or dynamic app usage.
- 🚀 **Smooth Windows Autostart**: Clean startup handling when launching automatically with Windows.

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
