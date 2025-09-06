# 🛠️ DanaVerse Development Scripts Guide

## 🚀 **Quick Reference**

### **Development Terminals (Recommended)**

```bash
# Start all applications with separate terminals
./scripts/start-all.sh

# Start individual applications in separate terminals
./scripts/dev-terminals.sh web        # Web app terminal
./scripts/dev-terminals.sh mobile     # Mobile app terminal (with platform selection)
./scripts/dev-terminals.sh android    # Android terminal only
./scripts/dev-terminals.sh ios        # iOS terminal only
./scripts/dev-terminals.sh api        # API terminal
./scripts/dev-terminals.sh contracts  # Contracts terminal
./scripts/dev-terminals.sh all        # All terminals
```

### **Project Management**

```bash
# Reset projects (if needed)
pnpm reset:mobile     # Reset mobile project
pnpm reset:web        # Reset web project
pnpm reset:api        # Reset API project
pnpm reset:contracts  # Reset contracts project
pnpm reset:all        # Reset all projects (with confirmation)

# Check status
./scripts/start-all.sh status     # Show current status
./scripts/start-all.sh stop       # Stop all and close terminals
```

---

## 📱 **Mobile Development Script**

### **Usage**

```bash
./scripts/start-mobile.sh [platform]
```

### **Platforms**

- `ios` - Start iOS simulator + Expo
- `android` - Start Android emulator + Expo
- `web` - Start Expo for web only
- `all` - Start all platforms (default)
- `check` - Check current status
- `help` - Show help message

### **Examples**

```bash
# Start all platforms
./scripts/start-mobile.sh

# Start iOS only
./scripts/start-mobile.sh ios

# Check status
./scripts/start-mobile.sh check
```

### **Features**

- ✅ Automatic emulator detection
- ✅ Auto-start emulators if not running
- ✅ Port conflict checking
- ✅ Error handling
- ✅ Status monitoring

---

## 🌐 **Full Stack Development Script**

### **Usage**

```bash
./scripts/start-all.sh [command] [app]
```

### **Commands**

- `start` - Start all applications (default)
- `stop` - Stop all applications
- `restart` - Restart all applications
- `status` - Show current status
- `logs [app]` - Show logs for specific app
- `web` - Start web app only
- `mobile` - Start mobile app only
- `api` - Start API only
- `contracts` - Start contracts only
- `help` - Show help message

### **Apps for Logs**

- `web` - Web application logs
- `mobile` - Mobile application logs
- `api` - API application logs
- `contracts` - Smart contracts logs

### **Examples**

```bash
# Start all applications
./scripts/start-all.sh

# Start web app only
./scripts/start-all.sh web

# Check status
./scripts/start-all.sh status

# Show web app logs
./scripts/start-all.sh logs web

# Stop all applications
./scripts/start-all.sh stop
```

### **Features**

- ✅ Background process management
- ✅ Log file generation
- ✅ Port conflict checking
- ✅ Process monitoring
- ✅ Graceful shutdown

---

## 📊 **Application Ports**

| Application    | Port | Status         | URL                          |
| -------------- | ---- | -------------- | ---------------------------- |
| **Web App**    | 3000 | ⚠️ Not running | http://localhost:3000        |
| **Mobile App** | 8081 | ⚠️ Not running | http://localhost:8081        |
| **API**        | 8080 | ⚠️ Not running | http://localhost:8080        |
| **API Health** | 8080 | ⚠️ Not running | http://localhost:8080/health |

---

## 🔧 **Troubleshooting**

### **Common Issues**

#### **Script Permission Denied**

```bash
# Make scripts executable
chmod +x scripts/start-mobile.sh
chmod +x scripts/start-all.sh
```

#### **Port Already in Use**

```bash
# Check what's using the port
lsof -i :3000  # Web app
lsof -i :8081  # Mobile app
lsof -i :8080  # API

# Kill process using port
kill -9 <PID>
```

#### **Emulator Not Starting**

```bash
# Check emulator status
./scripts/start-mobile.sh check

# Manual emulator start
# iOS: xcrun simctl boot "iPhone 16 Pro"
# Android: $ANDROID_HOME/emulator/emulator -avd Pixel_9
```

#### **Process Not Stopping**

```bash
# Force stop all applications
./scripts/start-all.sh stop

# Manual cleanup
pkill -f "expo.*start"
pkill -f "next.*dev"
pkill -f "go.*run"
```

---

## 📝 **Log Files**

### **Location**

```
/logs/
├── web.log        # Web application logs
├── mobile.log     # Mobile application logs
├── api.log        # API application logs
├── contracts.log  # Smart contracts logs
├── web.pid        # Web app process ID
├── mobile.pid     # Mobile app process ID
├── api.pid        # API process ID
└── contracts.pid  # Contracts process ID
```

### **View Logs**

```bash
# View specific app logs
./scripts/start-all.sh logs web
./scripts/start-all.sh logs mobile
./scripts/start-all.sh logs api

# View logs manually
tail -f logs/web.log
tail -f logs/mobile.log
tail -f logs/api.log
```

---

## 🎯 **Best Practices**

### **Development Workflow**

1. **Start emulators first** (iOS/Android)
2. **Use scripts for convenience**
3. **Check status regularly**
4. **Monitor logs for issues**
5. **Stop applications when done**

### **Script Usage Tips**

- Use `check` command to verify status
- Use `logs` command to debug issues
- Use `stop` command to clean up
- Use `restart` command for fresh start

### **Performance Tips**

- Close unused emulators
- Use `web` mode for quick testing
- Monitor system resources
- Clean up logs regularly

---

## 🚀 **Quick Commands Summary**

```bash
# Mobile Development
./scripts/start-mobile.sh          # Start all mobile platforms
./scripts/start-mobile.sh ios      # iOS only
./scripts/start-mobile.sh android  # Android only
./scripts/start-mobile.sh check    # Check status

# Full Stack Development
./scripts/start-all.sh             # Start all apps
./scripts/start-all.sh status      # Check status
./scripts/start-all.sh stop        # Stop all apps
./scripts/start-all.sh logs web    # View web logs

# Manual Commands
cd apps/mobile && pnpm start       # Start mobile manually
cd apps/web && pnpm dev            # Start web manually
cd apps/api && go run main.go      # Start API manually
```

---

**Happy coding! 🚀**

The DanaVerse development scripts make it easy to start and manage all applications in the monorepo!
