# DanaVerse - Decentralized Crowdfunding Platform

A comprehensive monorepo containing all components of the DanaVerse decentralized crowdfunding platform, built with enterprise-grade architecture and best practices.

## 🏗️ Architecture

This monorepo follows enterprise best practices with selective builds, independent deployments, and clear separation of concerns:

```
/danaverse-crowdfunding
├─ apps/
│  ├─ api/            # Go API + blockchain listener
│  ├─ web/            # Next.js web application
│  └─ mobile/         # Expo React Native app
├─ packages/
│  ├─ ui/             # Shared UI components
│  ├─ config/         # Shared configurations (ESLint, Prettier, TypeScript)
│  └─ sdk/            # API client SDK
├─ contracts/         # Solidity smart contracts
├─ infra/             # Infrastructure as Code (Terraform)
└─ .github/workflows/ # CI/CD pipelines
```

## 🚀 Quick Start

### Prerequisites

- **Node.js** >= 18.0.0 (LTS recommended)
- **PNPM** >= 9.0.0
- **Go** >= 1.22 (for API)
- **Foundry** (for smart contracts)

### 🛠️ Development Scripts

```bash
# Start all applications with separate terminals
./scripts/start-all.sh

# Start individual applications
./scripts/dev-terminals.sh web
./scripts/dev-terminals.sh mobile
./scripts/dev-terminals.sh api
./scripts/dev-terminals.sh contracts

# Reset projects (if needed)
pnpm reset:mobile
pnpm reset:web
pnpm reset:api
pnpm reset:contracts

# Check status
./scripts/start-all.sh status
```

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd danaverse-crowdfunding
   ```

2. **Install dependencies**

   ```bash
   pnpm install
   ```

3. **Set up environment variables**

   ```bash
   # Copy example files
   cp apps/api/env.example apps/api/.env
   cp apps/web/env.example apps/web/.env.local
   cp apps/mobile/env.example apps/mobile/.env

   # Edit the files with your actual values
   ```

4. **Start development servers**

   ```bash
   # Start all services
   pnpm dev

   # Or start individual services
   pnpm --filter @danaverse/web dev
   pnpm --filter @danaverse/mobile start
   cd apps/api && go run main.go
   ```

## 📦 Workspace Management

### PNPM Workspaces

This project uses PNPM workspaces for efficient dependency management:

- **Root workspace**: Contains shared dev dependencies and scripts
- **App workspaces**: Individual applications with their own dependencies
- **Package workspaces**: Shared libraries and configurations

### Turbo for Build Orchestration

Turbo is configured to optimize builds across the monorepo:

```bash
# Build all packages
pnpm build

# Build specific package
pnpm --filter @danaverse/web build

# Run linting across all packages
pnpm lint

# Run tests across all packages
pnpm test
```

## 🔧 Development

### Code Quality

- **ESLint**: Configured with TypeScript and React rules
- **Prettier**: Consistent code formatting
- **Husky**: Git hooks for pre-commit linting
- **Commitlint**: Conventional commit messages

### Conventional Commits

We use conventional commits for clear change tracking:

```
feat(api): add user authentication endpoint
fix(web): resolve mobile navigation issue
docs(readme): update installation instructions
```

**Scopes**: `api`, `web`, `mobile`, `contracts`, `ui`, `config`, `sdk`, `infra`, `deps`, `docs`

### Environment Management

Each application has its own environment configuration:

- **API**: Database, JWT, blockchain connections
- **Web**: Public API URLs, blockchain config
- **Mobile**: Expo-specific environment variables

**Never commit sensitive data** - use environment variables and secrets management.

## 🏗️ Applications

### API (`apps/api`)

Go-based REST API with blockchain integration:

- **Framework**: Gin web framework
- **Database**: PostgreSQL with migrations
- **Blockchain**: Ethereum integration
- **Authentication**: JWT-based auth

**Key endpoints**:

- `GET /health` - Health check
- `GET /api/v1/projects` - List projects
- `POST /api/v1/projects` - Create project
- `GET /api/v1/projects/:id` - Get project details

### Web Application (`apps/web`)

Next.js web application:

- **Framework**: Next.js 15 with App Router
- **Styling**: CSS Modules (Tailwind can be added)
- **State Management**: React Context/Zustand
- **Blockchain**: Web3 integration

### Mobile Application (`apps/mobile`)

Expo React Native application with native builds:

- **Framework**: Expo SDK 53 with native development builds
- **Platform**: iOS, Android (native builds), Web
- **Navigation**: Expo Router (file-based routing)
- **Styling**: NativeWind (Tailwind CSS for React Native)
- **State Management**: Zustand + React Query
- **Package**: com.danaverse
- **Development**: Native builds (not Expo Go)

### Smart Contracts (`contracts`)

Solidity smart contracts for crowdfunding:

- **Framework**: Foundry
- **Features**: Project creation, funding, withdrawals
- **Security**: ReentrancyGuard, Pausable, Ownable
- **Testing**: Comprehensive test suite

## 🚀 Deployment

### CI/CD Pipeline

GitHub Actions workflow with matrix strategy:

- **Selective builds**: Only builds changed packages
- **Parallel execution**: Multiple packages build simultaneously
- **Quality gates**: Linting, testing, security audits
- **Deployment**: Staging and production environments

### Release Strategy

Independent releases per application:

```bash
# Tag releases
git tag web-v1.2.0
git tag api-v0.5.1
git tag mobile-v0.9.0
git tag contracts-v0.3.2

# Deploy specific applications
# CI reads tag prefix to determine deployment target
```

### Staging Environment

- **Web**: `https://staging-web.danaverse.com`
- **API**: `https://staging-api.danaverse.com`
- **Mobile**: Expo development builds

### Production Environment

- **Web**: `https://danaverse.com`
- **API**: `https://api.danaverse.com`
- **Mobile**: App Store / Google Play

## 🔒 Security

### Secrets Management

- **Development**: `.env` files (not committed)
- **Staging/Production**: GitHub Secrets / AWS Secrets Manager
- **Blockchain**: Hardware wallet integration

### Code Security

- **Dependencies**: Regular security audits
- **Smart Contracts**: Formal verification planned
- **API**: Rate limiting, input validation
- **Frontend**: CSP headers, XSS protection

## 📊 Monitoring & Observability

### Logging

- **API**: Structured logging with correlation IDs
- **Web**: Error tracking with Sentry
- **Mobile**: Crash reporting with Expo

### Metrics

- **API**: Prometheus metrics
- **Web**: Web Vitals tracking
- **Blockchain**: Transaction monitoring

## 🤝 Contributing

### Development Workflow

1. **Create feature branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make changes** following conventional commits

3. **Run quality checks**

   ```bash
   pnpm lint
   pnpm test
   pnpm type-check
   ```

4. **Create pull request** with clear description

5. **Code review** and merge to main

### Code Standards

- **TypeScript**: Strict mode enabled
- **ESLint**: Zero warnings policy
- **Prettier**: Consistent formatting
- **Tests**: Minimum 80% coverage

## 📚 Documentation

### **📁 Documentation Hub**

All technical documentation is organized in the [`docs/`](docs/) directory:

- **[Documentation Index](docs/README.md)** - Complete documentation overview
- **[Architecture Overview](docs/architecture/ARCHITECTURE_OVERVIEW.md)** - System architecture
- **[Development Guides](docs/development/)** - Development workflow and tools
- **[Deployment Guide](docs/deployment/)** - CI/CD and deployment

### **📱 Application Structure**

- **[Mobile Structure](apps/mobile/docs/PROJECT_STRUCTURE.md)** - React Native project structure
- **[Web Structure](apps/web/docs/PROJECT_STRUCTURE.md)** - Next.js project structure
- **[API Structure](apps/api/docs/PROJECT_STRUCTURE.md)** - Go API project structure
- **[Contracts Structure](contracts/docs/PROJECT_STRUCTURE.md)** - Solidity contracts structure

### **🔧 Development Tools**

- **[Branch Strategy](docs/development/BRANCH_STRATEGY.md)** - Git Flow workflow
- **[Code Quality Tools](docs/development/CODE_QUALITY_TOOLS.md)** - Linting and formatting
- **[CI/CD Pipeline](docs/deployment/CI_CD_GUIDE.md)** - Deployment automation

## 🆘 Troubleshooting

### Common Issues

1. **PNPM workspace issues**

   ```bash
   pnpm install --frozen-lockfile
   ```

2. **Go module issues**

   ```bash
   cd apps/api && go mod tidy
   ```

3. **Foundry issues**

   ```bash
   cd contracts && forge install
   ```

4. **Environment variables**
   - Ensure all `.env` files are properly configured
   - Check that example files are copied correctly

### Getting Help

- **Issues**: GitHub Issues for bug reports
- **Discussions**: GitHub Discussions for questions
- **Documentation**: Check individual app READMEs

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **OpenZeppelin**: Smart contract security patterns
- **Next.js**: Web application framework
- **Expo**: Mobile development platform
- **Foundry**: Smart contract development tools

---

**Built with ❤️ for the decentralized future**
