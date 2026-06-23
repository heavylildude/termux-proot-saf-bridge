# 🏄‍♂️ Termux PRoot Storage Access File Bridge

**A lightweight, bulletproof script to perfectly sync native Android app (like Acode or Material Files) with a Termux PRoot Linux environment.**

Built for hackers running Node.js, Electron, or heavy dev environments on low-spec Android devices without melting their rigs.

---

## 🛑 The Problem: The Android File System Wipeout

If you code on an Android tablet or phone, you already know the nightmare: 
Android's Storage Access Framework (SAF) completely blocks third-party apps from seeing the hidden `EXT4` Linux filesystem where Termux and PRoot live. 

If you try to bypass this by keeping your projects in standard Android shared storage (`/sdcard` or `Documents`), you hit a brick wall. Android uses `FAT32/exFAT`, which **does not support Linux symlinks**. The exact second you run `npm install`, Node tries to build symlinks, faceplants into the Android kernel, and completely shits the bed.

## 🤙 The Solution: The Reverse Bind Mount

**Termux PRoot SAF Bridge** builds a digital wormhole. 

It carves out a workspace in Termux's native `EXT4`-like storage—where Android apps like Acode can read and write natively without SAF restrictions. Then, it generates a custom `.bashrc` alias that automatically performs a "Reverse Bind Mount", injecting your Termux workspace directly into your PRoot Ubuntu/Linux container every time you log in.

* **Zero-lag editing:** Edit UI/UX natively in Acode with zero memory bloat.
* **NPM Safe:** `node_modules` and symlinks work flawlessly without Android FAT32 errors.
* **Interactive Setup:** Automatically maps to your specific distro (`ubuntu`, `debian`, `arch`) and non-root users.

---

## 🚀 Quick Start

Drop into your standard Termux prompt (not inside your PRoot container) and run:

```bash
git clone [https://github.com/heavylildude/termux-proot-saf-bridge.git](https://github.com/heavylildude/termux-proot-saf-bridge.git)
cd /termux-proot-saf-bridge
chmod +x termux-saf-bridge.sh
./termux-saf-bridge.sh
