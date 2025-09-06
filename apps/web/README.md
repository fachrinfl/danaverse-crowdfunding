# 🌐 DanaVerse Web Application

The DanaVerse web application built with **Next.js 15** and modern React patterns.

## 🚀 Quick Start

### Development

```bash
# Start development server
pnpm dev

# Or using the monorepo script
./scripts/dev-terminals.sh web
```

Open [http://localhost:3000](http://localhost:3000) to view the application.

### Build & Deploy

```bash
# Build for production
pnpm build

# Start production server
pnpm start

# Export static files
pnpm export
```

## 🏗️ Architecture

- **Framework**: Next.js 15 with App Router
- **Styling**: CSS Modules (Tailwind CSS ready)
- **State Management**: React Context/Zustand
- **TypeScript**: Full type safety
- **Blockchain**: Web3 integration

## 📚 Documentation

- **[Project Structure](docs/PROJECT_STRUCTURE.md)** - Complete project structure guide
- **[Architecture Overview](../../docs/ARCHITECTURE_OVERVIEW.md)** - System architecture
- **[Development Guide](../../SCRIPTS_GUIDE.md)** - Development scripts and automation

## 🔧 Development

### Prerequisites

- Node.js 18+
- PNPM 9+

### Scripts

```bash
pnpm dev          # Start development server
pnpm build        # Build for production
pnpm start        # Start production server
pnpm lint         # Run ESLint
pnpm type-check   # Run TypeScript checks
```

## 🚀 Deployment

The application is configured for deployment on:

- **Vercel** (recommended for Next.js)
- **AWS** (via Infrastructure as Code)
- **Docker** (containerized deployment)

See the main [README](../../README.md) for complete deployment instructions.
