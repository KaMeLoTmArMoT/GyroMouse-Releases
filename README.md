<div align="center">
  <h1 align="center">GyroMouse 🎯🖱️</h1>

  <p align="center">
    <b>A next-generation smart air-mouse application with revolutionary Magnetic UI.</b><br>
    Use your Android smartphone's gyroscope to control your PC cursor with surgical precision, enhanced by virtual gravity wells that intelligently snap your cursor to clickable elements.
    <br /><br />
    <a href="https://github.com/KaMeLoTmArMoT/GyroMouse-Releases/releases/latest">⬇️ Download Latest Release</a>
    ·
    <a href="https://github.com/KaMeLoTmArMoT/GyroMouse-Releases/issues">🐛 Report Bug</a>
    ·
    <a href="https://github.com/KaMeLoTmArMoT/GyroMouse-Releases/issues">💡 Request Feature</a>
  </p>
</div>

---

## About The Project

Air mice are notoriously difficult to use for precise tasks (like clicking small buttons) due to the natural shaking of human hands.

**GyroMouse** solves this by building a real-time spatial map of your screen's UI elements and applying a virtual "gravity well" around them. When your cursor gets close to a button, link, or tab, it physically gets "pulled" towards its center. It achieves this by combining high-speed native Windows scanning (via UIAutomation), web DOM scraping (via Chrome Extension), and a heavily optimized Rust physics engine.

### 🌟 The "Magnetic UI" Experience
* **Native Windows Support:** Effortlessly snaps to File Explorer tabs, Start Menu items, Taskbar icons, and Electron apps.
* **Web Integration:** The dedicated Chrome Extension pierces through Shadow DOMs and IFrames, grabbing exact button coordinates from any website.

## Key Features

* 📱 **Pointer Mode:** Absolute spatial tracking (Point-and-click) using the phone's gyroscope.
* ⚡ **Zero-Latency Architecture:** Asynchronous UDP networking combined with O(N) SIMD Rust calculations ensures instantaneous cursor response.
* ⌨️ **Safe Sync Keyboard:** Type from your phone! The PC server streams focused text fields directly to your Android device, perfectly synchronized to avoid race conditions.
* 🔍 **Auto-Discovery:** Zero-configuration setup. The Android app automatically detects your PC server over the local Wi-Fi via mDNS/ZeroConf.

---

## 🚀 Downloading & Installation

This repository hosts the compiled binaries for GyroMouse.

1. Navigate to the [**Releases**](../../releases/latest) page.
2. Download the assets for your platform:
   * 🖥️ **`GyroMouse-vX.X.X.exe`** — The Windows Server (Run this on your PC).
   * 📱 **`gyromouse-android-vX.X.X.apk`** — The Android Client (Install this on your phone).
   * 🌐 **`gyromouse-extension-vX.X.X.zip`** — The Chrome Extension (Load unpacked in `chrome://extensions`).

*Once installed, the applications feature an **Auto-Update System** and will notify you when a new version is published here!*

---

## 🔐 Source Code & Privacy

The source code for GyroMouse is currently **private and closed-source**. This repository is maintained strictly as an official distribution channel for release assets and issue tracking.

**Privacy:** GyroMouse operates entirely locally over your home Wi-Fi. It does not collect telemetry, perform user tracking, or rely on external cloud accounts. Please review the [**PRIVACY**](PRIVACY) notice for full details.

## ⚠️ License

The software provided in these releases is proprietary. Reverse engineering, modification, and unauthorized redistribution are strictly prohibited.

Please refer to the [**LICENSE**](LICENSE) file for the full End User License Agreement (EULA).
