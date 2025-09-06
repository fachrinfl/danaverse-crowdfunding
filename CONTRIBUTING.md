# 🤝 Contributing to DanaVerse

Thank you for your interest in contributing to DanaVerse! This document provides guidelines and information for contributors.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Contributing Process](#contributing-process)
- [Code Standards](#code-standards)
- [Testing](#testing)
- [Documentation](#documentation)
- [Release Process](#release-process)

## 📜 Code of Conduct

This project adheres to a code of conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

## 🚀 Getting Started

### Prerequisites

- **Node.js** >= 18.0.0 (LTS recommended)
- **PNPM** >= 9.0.0
- **Go** >= 1.22 (for API development)
- **Foundry** (for smart contract development)
- **Git** >= 2.30

### Development Setup

1. **Fork the repository**
2. **Clone your fork**

   ```bash
   git clone https://github.com/your-username/danaverse-crowdfunding.git
   cd danaverse-crowdfunding
   ```

3. **Install dependencies**

   ```bash
   pnpm install
   ```

4. **Set up environment variables**

   ```bash
   # Copy example files
   cp apps/api/env.example apps/api/.env
   cp apps/web/env.example apps/web/.env.local
   cp apps/mobile/env.example apps/mobile/.env
   ```

5. **Start development servers**

   ```bash
   # Start all applications
   ./scripts/start-all.sh

   # Or start individual applications
   ./scripts/dev-terminals.sh web
   ./scripts/dev-terminals.sh mobile
   ./scripts/dev-terminals.sh api
   ```

## 🔄 Contributing Process

### 1. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
# or
git checkout -b docs/your-documentation-update
```

### 2. Make Your Changes

- Follow the [Code Standards](#code-standards)
- Write tests for new functionality
- Update documentation as needed
- Ensure all tests pass

### 3. Commit Your Changes

We use [Conventional Commits](https://www.conventionalcommits.org/):

```bash
# Format: type(scope): description
git commit -m "feat(api): add user authentication endpoint"
git commit -m "fix(web): resolve mobile navigation issue"
git commit -m "docs(readme): update installation instructions"
```

**Commit Types:**

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Scopes:**

- `api`: Backend API changes
- `web`: Web application changes
- `mobile`: Mobile application changes
- `contracts`: Smart contract changes
- `ui`: Shared UI components
- `config`: Configuration changes
- `sdk`: SDK changes
- `infra`: Infrastructure changes
- `deps`: Dependency updates
- `docs`: Documentation

### 4. Push and Create Pull Request

```bash
git push origin feature/your-feature-name
```

Then create a pull request using the provided template.

## 📏 Code Standards

### General Guidelines

- **TypeScript**: Use strict mode and proper typing
- **ESLint**: Follow the configured rules (zero warnings policy)
- **Prettier**: Consistent code formatting
- **Naming**: Use descriptive, self-documenting names
- **Comments**: Document complex logic and business rules

### Language-Specific Standards

#### TypeScript/JavaScript

```typescript
// ✅ Good
interface User {
  id: string;
  email: string;
  createdAt: Date;
}

const getUserById = async (id: string): Promise<User | null> => {
  // Implementation
};

// ❌ Bad
const getUser = async (id) => {
  // Implementation
};
```

#### Go

```go
// ✅ Good
type User struct {
    ID        string    `json:"id"`
    Email     string    `json:"email"`
    CreatedAt time.Time `json:"created_at"`
}

func GetUserByID(id string) (*User, error) {
    // Implementation
}

// ❌ Bad
func getUser(id string) interface{} {
    // Implementation
}
```

#### Solidity

```solidity
// ✅ Good
contract Crowdfunding {
    struct Project {
        uint256 id;
        address creator;
        uint256 goal;
        uint256 raised;
        bool isActive;
    }

    mapping(uint256 => Project) public projects;

    function createProject(uint256 _goal) external returns (uint256) {
        // Implementation
    }
}

// ❌ Bad
contract crowdfunding {
    function createproject(uint goal) external {
        // Implementation
    }
}
```

## 🧪 Testing

### Test Requirements

- **Unit Tests**: Minimum 80% coverage
- **Integration Tests**: For API endpoints and database operations
- **E2E Tests**: For critical user flows
- **Smart Contract Tests**: Comprehensive test coverage

### Running Tests

```bash
# Run all tests
pnpm test

# Run tests for specific app
pnpm --filter @danaverse/web test
pnpm --filter @danaverse/mobile test

# Run API tests
cd apps/api && go test ./...

# Run smart contract tests
cd contracts && forge test
```

### Test Guidelines

- Write tests before implementing features (TDD)
- Use descriptive test names
- Test both success and failure cases
- Mock external dependencies
- Keep tests independent and isolated

## 📚 Documentation

### Documentation Standards

- **README files**: Clear setup and usage instructions
- **Code comments**: Explain complex logic and business rules
- **API documentation**: OpenAPI/Swagger specs
- **Architecture docs**: System design and decisions

### Updating Documentation

- Update relevant documentation with your changes
- Use clear, concise language
- Include code examples where helpful
- Keep documentation up-to-date

## 🚀 Release Process

### Versioning

We use [Semantic Versioning](https://semver.org/):

- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Workflow

1. **Create release branch**

   ```bash
   git checkout -b release/v1.2.0
   ```

2. **Update version numbers**
   - Update `package.json` files
   - Update `CHANGELOG.md`
   - Update documentation

3. **Create pull request**
   - Use the release template
   - Include all changes in the description

4. **Merge and tag**
   ```bash
   git tag v1.2.0
   git push origin v1.2.0
   ```

## 🏷️ Labels and Milestones

### Issue Labels

- `bug`: Something isn't working
- `enhancement`: New feature or request
- `documentation`: Improvements or additions to documentation
- `good first issue`: Good for newcomers
- `help wanted`: Extra attention is needed
- `priority: high`: High priority
- `priority: medium`: Medium priority
- `priority: low`: Low priority

### Pull Request Labels

- `ready for review`: Ready for code review
- `needs testing`: Requires additional testing
- `breaking change`: Breaking change
- `dependencies`: Dependency updates

## 🆘 Getting Help

- **GitHub Issues**: For bug reports and feature requests
- **GitHub Discussions**: For questions and general discussion
- **Documentation**: Check the project documentation
- **Code Review**: Ask questions in pull request comments

## 📋 Checklist for Contributors

Before submitting a pull request, ensure:

- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Tests added/updated and passing
- [ ] Documentation updated
- [ ] No console.log statements in production code
- [ ] TypeScript types properly defined
- [ ] ESLint passes without warnings
- [ ] Prettier formatting applied
- [ ] Conventional commit message used
- [ ] Pull request template completed

## 🙏 Recognition

Contributors will be recognized in:

- `CONTRIBUTORS.md` file
- Release notes
- Project documentation

Thank you for contributing to DanaVerse! 🚀
