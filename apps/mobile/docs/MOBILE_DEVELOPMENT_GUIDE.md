# 📱 DanaVerse Mobile Development Guide

## 🚀 **Quick Start Commands**

### **Native Development Builds (Recommended)**

```bash
# Start all applications with separate terminals
./scripts/start-all.sh

# Start mobile with platform selection
./scripts/dev-terminals.sh mobile

# Start specific platforms
./scripts/dev-terminals.sh android    # Android native build
./scripts/dev-terminals.sh ios        # iOS native build

# Start all applications
./scripts/dev-terminals.sh all
```

### **Native Build Commands**

```bash
# Android native build
cd apps/mobile && npx expo run:android

# iOS native build
cd apps/mobile && npx expo run:ios

# Clean and rebuild
cd apps/mobile && pnpm prebuild:clean
```

### **Development Features**

- **Package Name**: `com.danaverse`
- **Bundle Identifier**: `com.danaverse`
- **Native Builds**: Direct APK/IPA installation (not Expo Go)
- **Metro Bundler**: Hot reload enabled
- **Terminal Integration**: Separate terminals for each platform

---

## 🛠️ **Development Scripts**

### **Mobile Development Script**

```bash
# Basic usage
./scripts/start-mobile.sh

# Platform-specific
./scripts/start-mobile.sh ios      # Start iOS simulator + Expo
./scripts/start-mobile.sh android  # Start Android emulator + Expo
./scripts/start-mobile.sh web      # Start Expo for web only
./scripts/start-mobile.sh check    # Check current status
./scripts/start-mobile.sh help     # Show help
```

### **Full Stack Development Script**

```bash
# Start all applications
./scripts/start-all.sh

# Individual applications
./scripts/start-all.sh web        # Start web app only
./scripts/start-all.sh mobile     # Start mobile app only
./scripts/start-all.sh api        # Start API only
./scripts/start-all.sh contracts  # Start contracts only

# Management commands
./scripts/start-all.sh stop       # Stop all applications
./scripts/start-all.sh restart    # Restart all applications
./scripts/start-all.sh status     # Show status
./scripts/start-all.sh logs web   # Show web app logs
```

### **Script Features**

- ✅ **Automatic emulator detection**
- ✅ **Port conflict checking**
- ✅ **Background process management**
- ✅ **Log file generation**
- ✅ **Status monitoring**
- ✅ **Error handling**

---

## 📋 **Prerequisites**

### **Required Tools**

- ✅ **Node.js** (v18+)
- ✅ **PNPM** (package manager)
- ✅ **Expo CLI** (installed globally or via npx)

### **iOS Development**

- ✅ **Xcode** (for iOS Simulator)
- ✅ **iOS Simulator** (iPhone 16 Pro ready)

### **Android Development**

- ✅ **Android Studio** (for Android Emulator)
- ✅ **Android SDK** (with emulator)
- ✅ **Android Emulator** (Pixel 9 ready)

---

## 🛠️ **Setup Scripts**

### **1. Install Dependencies**

```bash
# Install all dependencies
pnpm install

# Install mobile dependencies specifically
cd apps/mobile && pnpm install
```

### **2. Start Emulators**

#### **iOS Simulator**

```bash
# List available simulators
xcrun simctl list devices

# Boot specific simulator
xcrun simctl boot "iPhone 16 Pro"

# Open Simulator app
open -a Simulator
```

#### **Android Emulator**

```bash
# List available AVDs
$ANDROID_HOME/emulator/emulator -list-avds

# Start specific emulator
$ANDROID_HOME/emulator/emulator -avd Pixel_9

# Check if emulator is running
adb devices
```

---

## 🎯 **Development Workflow**

### **Daily Development**

```bash
# 1. Start emulators (if not running)
# iOS: xcrun simctl boot "iPhone 16 Pro" && open -a Simulator
# Android: $ANDROID_HOME/emulator/emulator -avd Pixel_9

# 2. Start Expo development server
cd apps/mobile && pnpm start

# 3. Deploy to platforms
# Press 'i' for iOS
# Press 'a' for Android
# Press 'w' for web
```

### **Testing on Multiple Platforms**

```bash
# Start all platforms simultaneously
cd apps/mobile && pnpm start

# In Expo CLI:
# - Press 'i' → iOS Simulator opens
# - Press 'a' → Android Emulator opens
# - Press 'w' → Web browser opens
```

---

## 📱 **Platform-Specific Commands**

### **iOS Development**

```bash
# Start iOS simulator
cd apps/mobile && pnpm ios

# Open iOS simulator manually
xcrun simctl boot "iPhone 16 Pro"
open -a Simulator

# Check iOS simulator status
xcrun simctl list devices | grep "Booted"

# Reset iOS simulator
xcrun simctl erase "iPhone 16 Pro"
```

### **Android Development**

```bash
# Start Android emulator
cd apps/mobile && pnpm android

# Open Android emulator manually
$ANDROID_HOME/emulator/emulator -avd Pixel_9

# Check Android emulator status
adb devices

# Reset Android emulator
adb -s emulator-5554 emu kill
$ANDROID_HOME/emulator/emulator -avd Pixel_9
```

### **Web Development**

```bash
# Start web version
cd apps/mobile && pnpm web

# Open in browser
open http://localhost:8081
```

---

## 🔧 **Troubleshooting**

### **Common Issues & Solutions**

#### **1. Expo Server Won't Start**

```bash
# Kill all Expo processes
pkill -f "expo.*start"

# Clear Expo cache
npx expo start --clear

# Restart with clean cache
cd apps/mobile && pnpm start -- --clear
```

#### **2. iOS Simulator Issues**

```bash
# If simulator won't boot
xcrun simctl shutdown all
xcrun simctl boot "iPhone 16 Pro"

# If simulator is slow
xcrun simctl erase "iPhone 16 Pro"
```

#### **3. Android Emulator Issues**

```bash
# If emulator won't start
adb kill-server
adb start-server
$ANDROID_HOME/emulator/emulator -avd Pixel_9

# If emulator is slow
adb -s emulator-5554 emu kill
$ANDROID_HOME/emulator/emulator -avd Pixel_9 -no-snapshot-load
```

#### **4. Module Resolution Errors**

```bash
# If you get "Unable to resolve module" errors
# Check package.json main field
cat apps/mobile/package.json | grep '"main"'

# Should be: "main": "index.js"
# If not, fix it:
# "main": "index.js"
```

---

## 📊 **Development Status**

### **Current Setup Status**

| Component            | Status       | Port | Notes                |
| -------------------- | ------------ | ---- | -------------------- |
| **iOS Simulator**    | ✅ **READY** | -    | iPhone 16 Pro booted |
| **Android Emulator** | ✅ **READY** | -    | Pixel 9 running      |
| **Expo Server**      | ✅ **READY** | 8081 | Metro bundler active |
| **Web Browser**      | ✅ **READY** | 8081 | React Native Web     |

### **Available Commands**

```bash
# Package.json scripts
pnpm start     # Start Expo development server
pnpm ios       # Start iOS simulator
pnpm android   # Start Android emulator
pnpm web       # Start web browser
pnpm lint      # Run ESLint
pnpm test      # Run tests
pnpm clean     # Clean build artifacts
```

---

## 🎮 **Expo CLI Commands**

### **Interactive Commands (when Expo is running)**

```
› Press s │ switch to development build
› Press a │ open Android
› Press i │ open iOS simulator
› Press w │ open web
› Press j │ open debugger
› Press r │ reload app
› Press m │ toggle menu
› shift+m │ more tools
› Press o │ open project code in your editor
› Press ? │ show all commands
```

### **Direct Commands**

```bash
# Start with specific options
npx expo start --ios          # iOS only
npx expo start --android      # Android only
npx expo start --web          # Web only
npx expo start --tunnel       # Use tunnel mode
npx expo start --clear        # Clear cache
npx expo start --no-dev       # Production mode
```

---

## 🚀 **Production Builds**

### **Build for iOS**

```bash
# Build for iOS (requires EAS CLI)
npx eas build --platform ios

# Build locally (requires Xcode)
npx expo run:ios
```

### **Build for Android**

```bash
# Build for Android (requires EAS CLI)
npx eas build --platform android

# Build locally (requires Android Studio)
npx expo run:android
```

---

## 📝 **Quick Reference**

### **Most Used Commands**

```bash
# Start development
cd apps/mobile && pnpm start

# Deploy to iOS
# Press 'i' in Expo CLI

# Deploy to Android
# Press 'a' in Expo CLI

# Open web version
# Press 'w' in Expo CLI

# Reload app
# Press 'r' in Expo CLI

# Open debugger
# Press 'j' in Expo CLI
```

### **Emergency Reset**

```bash
# Kill all processes
pkill -f "expo.*start"
pkill -f "Metro"

# Reset emulators
xcrun simctl shutdown all
adb -s emulator-5554 emu kill

# Clear cache and restart
cd apps/mobile && pnpm start -- --clear
```

---

## 🎯 **Development Tips**

### **Best Practices**

1. **Always start emulators first** before running Expo
2. **Use hot reloading** for rapid development
3. **Test on both platforms** regularly
4. **Use Expo CLI commands** for quick actions
5. **Keep emulators running** during development

### **Performance Tips**

1. **Close unused emulators** to save resources
2. **Use web version** for quick UI testing
3. **Clear cache** if experiencing issues
4. **Restart emulators** if they become slow

---

## 📚 **Additional Resources**

### **Documentation**

- [Expo Documentation](https://docs.expo.dev/)
- [React Native Documentation](https://reactnative.dev/)
- [Expo CLI Reference](https://docs.expo.dev/workflow/expo-cli/)

### **Useful Commands**

```bash
# Check Expo version
npx expo --version

# Check React Native version
npx react-native --version

# Check Node version
node --version

# Check PNPM version
pnpm --version
```

---

**Happy coding! 🚀**

The DanaVerse mobile development environment is fully set up and ready for cross-platform development!
