# 🔧 DanaVerse API - Go Enterprise Project Structure

This documentation defines the **standardized folder structure**, **file purposes**, **naming conventions**, and **architectural patterns** for the DanaVerse API using **Go** with modern enterprise-grade architecture and best practices.

---

## 🎯 **Architecture Principles**

### **Core Design Philosophy**

- **Domain-Driven Design (DDD)** - Organize code by business domains
- **Clean Architecture** - Separation of concerns with clear boundaries
- **Microservices Ready** - Modular design for future scalability
- **Type Safety** - Strong typing with Go generics where appropriate
- **Performance First** - Optimized for high throughput and low latency
- **Security by Design** - Built-in security patterns and practices
- **Observability** - Comprehensive logging, metrics, and tracing

### **Technology Stack**

- **Go 1.22+** with modern language features
- **Gin** web framework for HTTP routing
- **GORM** for database ORM
- **PostgreSQL** as primary database
- **Redis** for caching and sessions
- **Docker** for containerization
- **Prometheus** for metrics
- **Jaeger** for distributed tracing

---

## 🏗️ **Root Project Structure**

```
apps/api/
├── cmd/                     # Application entry points
├── internal/                # Private application code
├── pkg/                     # Public library code
├── api/                     # API definitions and contracts
├── configs/                 # Configuration files
├── deployments/             # Deployment configurations
├── scripts/                 # Build and utility scripts
├── docs/                    # API documentation
├── migrations/              # Database migrations
├── tests/                   # Test files
├── .env.example             # Environment variables template
├── go.mod                   # Go module definition
├── go.sum                   # Go module checksums
├── Dockerfile               # Docker configuration
├── docker-compose.yml       # Local development setup
├── Makefile                 # Build automation
└── README.md                # Project overview
```

---

## 📁 **`cmd/` – Application Entry Points**

**Main application entry points and server initialization.**

```
cmd/
├── server/                  # Main API server
│   ├── main.go             # Server entry point
│   ├── server.go           # Server configuration
│   └── config.go           # Server-specific config
├── migrate/                 # Database migration tool
│   ├── main.go             # Migration entry point
│   └── migrate.go          # Migration logic
├── seed/                    # Database seeding tool
│   ├── main.go             # Seeding entry point
│   └── seed.go             # Seeding logic
└── worker/                  # Background worker
    ├── main.go             # Worker entry point
    └── worker.go           # Worker configuration
```

---

## 📁 **`internal/` – Private Application Code**

**Application-specific code that should not be imported by other applications.**

### **`internal/app/` – Application Core**

```
internal/app/
├── server/                  # HTTP server setup
│   ├── server.go           # Server initialization
│   ├── middleware.go       # HTTP middleware
│   ├── routes.go           # Route definitions
│   └── handlers.go         # HTTP handlers
├── config/                  # Configuration management
│   ├── config.go           # Configuration struct
│   ├── env.go              # Environment variable loading
│   └── validation.go       # Config validation
├── database/                # Database layer
│   ├── connection.go       # Database connection
│   ├── migrations.go       # Migration runner
│   └── seeds.go            # Database seeding
├── cache/                   # Caching layer
│   ├── redis.go            # Redis client
│   ├── memory.go           # In-memory cache
│   └── interface.go        # Cache interface
└── logger/                  # Logging setup
    ├── logger.go           # Logger configuration
    ├── middleware.go       # Logging middleware
    └── fields.go           # Log fields
```

### **`internal/domain/` – Business Logic**

**Domain-driven design with business entities and rules.**

```
internal/domain/
├── user/                    # User domain
│   ├── entity.go           # User entity
│   ├── repository.go       # Repository interface
│   ├── service.go          # Business logic
│   ├── validator.go        # Business validation
│   └── events.go           # Domain events
├── project/                 # Project domain
│   ├── entity.go           # Project entity
│   ├── repository.go       # Repository interface
│   ├── service.go          # Business logic
│   ├── validator.go        # Business validation
│   └── events.go           # Domain events
├── wallet/                  # Wallet domain
│   ├── entity.go           # Wallet entity
│   ├── repository.go       # Repository interface
│   ├── service.go          # Business logic
│   ├── validator.go        # Business validation
│   └── events.go           # Domain events
├── transaction/             # Transaction domain
│   ├── entity.go           # Transaction entity
│   ├── repository.go       # Repository interface
│   ├── service.go          # Business logic
│   ├── validator.go        # Business validation
│   └── events.go           # Domain events
├── notification/            # Notification domain
│   ├── entity.go           # Notification entity
│   ├── repository.go       # Repository interface
│   ├── service.go          # Business logic
│   ├── validator.go        # Business validation
│   └── events.go           # Domain events
└── common/                  # Shared domain concepts
    ├── value_objects.go    # Value objects
    ├── events.go           # Common events
    └── errors.go           # Domain errors
```

### **`internal/infrastructure/` – External Dependencies**

**Infrastructure concerns and external service integrations.**

```
internal/infrastructure/
├── database/                # Database implementations
│   ├── postgres/           # PostgreSQL implementation
│   │   ├── connection.go   # Database connection
│   │   ├── migrations/     # Migration files
│   │   └── repositories/   # Repository implementations
│   │       ├── user_repository.go
│   │       ├── project_repository.go
│   │       ├── wallet_repository.go
│   │       └── transaction_repository.go
│   └── redis/              # Redis implementation
│       ├── connection.go   # Redis connection
│       └── cache.go        # Cache implementation
├── external/                # External service integrations
│   ├── blockchain/         # Blockchain services
│   │   ├── ethereum.go     # Ethereum integration
│   │   ├── web3.go         # Web3 client
│   │   └── contracts.go    # Smart contract interactions
│   ├── payment/            # Payment processing
│   │   ├── stripe.go       # Stripe integration
│   │   ├── paypal.go       # PayPal integration
│   │   └── crypto.go       # Cryptocurrency payments
│   ├── email/              # Email services
│   │   ├── sendgrid.go     # SendGrid integration
│   │   ├── ses.go          # AWS SES integration
│   │   └── smtp.go         # SMTP integration
│   ├── storage/            # File storage
│   │   ├── s3.go           # AWS S3 integration
│   │   ├── gcs.go          # Google Cloud Storage
│   │   └── local.go        # Local file storage
│   └── analytics/          # Analytics services
│       ├── mixpanel.go     # Mixpanel integration
│       ├── amplitude.go    # Amplitude integration
│       └── posthog.go      # PostHog integration
├── messaging/               # Message queue and events
│   ├── rabbitmq.go         # RabbitMQ integration
│   ├── kafka.go            # Apache Kafka integration
│   └── events.go           # Event publishing
└── monitoring/              # Monitoring and observability
    ├── metrics.go          # Prometheus metrics
    ├── tracing.go          # Jaeger tracing
    └── health.go           # Health checks
```

### **`internal/application/` – Application Services**

**Application services that orchestrate domain logic.**

```
internal/application/
├── handlers/                # HTTP handlers
│   ├── auth/               # Authentication handlers
│   │   ├── login.go        # Login handler
│   │   ├── register.go     # Registration handler
│   │   ├── refresh.go      # Token refresh handler
│   │   └── logout.go       # Logout handler
│   ├── user/               # User handlers
│   │   ├── profile.go      # User profile handler
│   │   ├── settings.go     # User settings handler
│   │   └── preferences.go  # User preferences handler
│   ├── project/            # Project handlers
│   │   ├── create.go       # Create project handler
│   │   ├── list.go         # List projects handler
│   │   ├── detail.go       # Project detail handler
│   │   ├── update.go       # Update project handler
│   │   └── delete.go       # Delete project handler
│   ├── wallet/             # Wallet handlers
│   │   ├── balance.go      # Wallet balance handler
│   │   ├── transactions.go # Transaction history handler
│   │   ├── send.go         # Send funds handler
│   │   └── receive.go      # Receive funds handler
│   └── admin/              # Admin handlers
│       ├── users.go        # User management handler
│       ├── projects.go     # Project management handler
│       └── analytics.go    # Analytics handler
├── services/                # Application services
│   ├── auth_service.go     # Authentication service
│   ├── user_service.go     # User management service
│   ├── project_service.go  # Project management service
│   ├── wallet_service.go   # Wallet management service
│   ├── notification_service.go # Notification service
│   └── admin_service.go    # Admin service
├── dto/                     # Data Transfer Objects
│   ├── auth.go             # Authentication DTOs
│   ├── user.go             # User DTOs
│   ├── project.go          # Project DTOs
│   ├── wallet.go           # Wallet DTOs
│   └── common.go           # Common DTOs
├── middleware/              # HTTP middleware
│   ├── auth.go             # Authentication middleware
│   ├── cors.go             # CORS middleware
│   ├── rate_limit.go       # Rate limiting middleware
│   ├── logging.go          # Logging middleware
│   ├── recovery.go         # Panic recovery middleware
│   └── validation.go       # Request validation middleware
└── workers/                 # Background workers
    ├── email_worker.go     # Email processing worker
    ├── notification_worker.go # Notification worker
    └── blockchain_worker.go # Blockchain processing worker
```

---

## 📁 **`pkg/` – Public Library Code**

**Reusable code that can be imported by other applications.**

```
pkg/
├── auth/                    # Authentication utilities
│   ├── jwt.go              # JWT token handling
│   ├── password.go         # Password hashing
│   ├── session.go          # Session management
│   └── permissions.go      # Permission checking
├── database/                # Database utilities
│   ├── connection.go       # Database connection helpers
│   ├── migrations.go       # Migration utilities
│   └── seeds.go            # Seeding utilities
├── cache/                   # Caching utilities
│   ├── redis.go            # Redis helpers
│   ├── memory.go           # Memory cache helpers
│   └── interface.go        # Cache interface
├── validation/              # Validation utilities
│   ├── email.go            # Email validation
│   ├── password.go         # Password validation
│   ├── uuid.go             # UUID validation
│   └── custom.go           # Custom validators
├── crypto/                  # Cryptographic utilities
│   ├── hash.go             # Hashing functions
│   ├── encryption.go       # Encryption/decryption
│   └── signing.go          # Digital signing
├── http/                    # HTTP utilities
│   ├── response.go         # HTTP response helpers
│   ├── request.go          # HTTP request helpers
│   ├── middleware.go       # Common middleware
│   └── errors.go           # HTTP error handling
├── logger/                  # Logging utilities
│   ├── logger.go           # Logger interface
│   ├── fields.go           # Log fields
│   └── formatters.go       # Log formatters
├── metrics/                 # Metrics utilities
│   ├── prometheus.go       # Prometheus helpers
│   ├── counters.go         # Counter metrics
│   └── histograms.go       # Histogram metrics
└── utils/                   # General utilities
    ├── time.go             # Time utilities
    ├── string.go           # String utilities
    ├── slice.go            # Slice utilities
    └── map.go              # Map utilities
```

---

## 📁 **`api/` – API Definitions**

**API contracts, schemas, and documentation.**

```
api/
├── openapi/                 # OpenAPI specifications
│   ├── v1/                 # API version 1
│   │   ├── auth.yaml       # Authentication endpoints
│   │   ├── users.yaml      # User endpoints
│   │   ├── projects.yaml   # Project endpoints
│   │   ├── wallet.yaml     # Wallet endpoints
│   │   └── admin.yaml      # Admin endpoints
│   └── common/             # Common schemas
│       ├── errors.yaml     # Error schemas
│       ├── pagination.yaml # Pagination schemas
│       └── metadata.yaml   # Metadata schemas
├── proto/                   # Protocol Buffers (if used)
│   ├── auth.proto          # Authentication proto
│   ├── user.proto          # User proto
│   ├── project.proto       # Project proto
│   └── wallet.proto        # Wallet proto
├── schemas/                 # JSON schemas
│   ├── request/            # Request schemas
│   │   ├── auth.json       # Auth request schemas
│   │   ├── user.json       # User request schemas
│   │   └── project.json    # Project request schemas
│   └── response/           # Response schemas
│       ├── auth.json       # Auth response schemas
│       ├── user.json       # User response schemas
│       └── project.json    # Project response schemas
└── docs/                    # API documentation
    ├── README.md           # API overview
    ├── authentication.md   # Auth documentation
    ├── endpoints.md        # Endpoint documentation
    └── examples.md         # Usage examples
```

---

## 📁 **`configs/` – Configuration Files**

**Configuration files for different environments.**

```
configs/
├── development.yaml         # Development configuration
├── staging.yaml            # Staging configuration
├── production.yaml         # Production configuration
├── testing.yaml            # Testing configuration
├── docker.yaml             # Docker configuration
└── local.yaml              # Local development configuration
```

---

## 📁 **`deployments/` – Deployment Configurations**

**Deployment and infrastructure configurations.**

```
deployments/
├── docker/                  # Docker configurations
│   ├── Dockerfile          # Main Dockerfile
│   ├── Dockerfile.dev      # Development Dockerfile
│   ├── docker-compose.yml  # Local development
│   └── docker-compose.prod.yml # Production setup
├── kubernetes/              # Kubernetes configurations
│   ├── namespace.yaml      # Namespace definition
│   ├── configmap.yaml      # Configuration map
│   ├── secret.yaml         # Secrets
│   ├── deployment.yaml     # Deployment
│   ├── service.yaml        # Service
│   └── ingress.yaml        # Ingress
├── terraform/               # Terraform configurations
│   ├── main.tf             # Main Terraform file
│   ├── variables.tf        # Variables
│   ├── outputs.tf          # Outputs
│   └── modules/            # Terraform modules
└── scripts/                 # Deployment scripts
    ├── deploy.sh           # Deployment script
    ├── rollback.sh         # Rollback script
    └── health-check.sh     # Health check script
```

---

## 📁 **`migrations/` – Database Migrations**

**Database schema migrations and versioning.**

```
migrations/
├── 001_initial_schema.sql   # Initial database schema
├── 002_add_users_table.sql # Add users table
├── 003_add_projects_table.sql # Add projects table
├── 004_add_wallets_table.sql # Add wallets table
├── 005_add_transactions_table.sql # Add transactions table
├── 006_add_notifications_table.sql # Add notifications table
├── 007_add_indexes.sql     # Add database indexes
├── 008_add_constraints.sql # Add foreign key constraints
└── rollback/               # Rollback migrations
    ├── 001_rollback_initial.sql
    ├── 002_rollback_users.sql
    └── 003_rollback_projects.sql
```

---

## 🧪 **Testing Structure**

**Comprehensive testing strategy with proper organization.**

```
tests/
├── unit/                    # Unit tests
│   ├── domain/             # Domain logic tests
│   │   ├── user_test.go
│   │   ├── project_test.go
│   │   └── wallet_test.go
│   ├── application/        # Application service tests
│   │   ├── auth_service_test.go
│   │   ├── user_service_test.go
│   │   └── project_service_test.go
│   ├── infrastructure/     # Infrastructure tests
│   │   ├── database_test.go
│   │   ├── cache_test.go
│   │   └── external_test.go
│   └── pkg/                # Package tests
│       ├── auth_test.go
│       ├── validation_test.go
│       └── utils_test.go
├── integration/            # Integration tests
│   ├── api/                # API integration tests
│   │   ├── auth_test.go
│   │   ├── user_test.go
│   │   └── project_test.go
│   ├── database/           # Database integration tests
│   │   ├── user_repository_test.go
│   │   ├── project_repository_test.go
│   │   └── wallet_repository_test.go
│   └── external/           # External service tests
│       ├── blockchain_test.go
│       ├── payment_test.go
│       └── email_test.go
├── e2e/                    # End-to-end tests
│   ├── auth_flow_test.go   # Authentication flow
│   ├── project_flow_test.go # Project creation flow
│   └── wallet_flow_test.go # Wallet operations flow
├── fixtures/               # Test data fixtures
│   ├── users.json          # User test data
│   ├── projects.json       # Project test data
│   └── transactions.json   # Transaction test data
├── mocks/                  # Mock implementations
│   ├── database_mock.go    # Database mocks
│   ├── cache_mock.go       # Cache mocks
│   └── external_mock.go    # External service mocks
└── helpers/                # Test helpers
    ├── setup.go            # Test setup
    ├── teardown.go         # Test teardown
    └── assertions.go       # Custom assertions
```

---

## 🏗️ **File Naming Conventions**

### **Go Files (snake_case)**

```
user_service.go, project_repository.go, auth_middleware.go
```

### **Test Files (snake_case with _test suffix)**

```
user_service_test.go, project_repository_test.go, auth_middleware_test.go
```

### **Package Names (lowercase, single word)**

```
auth, user, project, wallet, transaction
```

### **Struct Names (PascalCase)**

```
User, Project, Wallet, Transaction, AuthService
```

### **Interface Names (PascalCase with -er suffix)**

```
UserRepository, ProjectService, WalletManager
```

### **Constants (UPPER_SNAKE_CASE)**

```
API_VERSION, MAX_RETRY_COUNT, DEFAULT_TIMEOUT
```

### **Variables (camelCase)**

```
userID, projectName, walletBalance
```

---

## 🎨 **Code Organization Patterns**

### **Domain-Driven Design Structure**

```go
// Domain Entity
type User struct {
    ID        uuid.UUID `json:"id" gorm:"type:uuid;primary_key"`
    Email     string    `json:"email" gorm:"uniqueIndex;not null"`
    Username  string    `json:"username" gorm:"uniqueIndex;not null"`
    CreatedAt time.Time `json:"created_at"`
    UpdatedAt time.Time `json:"updated_at"`
}

// Repository Interface
type UserRepository interface {
    Create(ctx context.Context, user *User) error
    GetByID(ctx context.Context, id uuid.UUID) (*User, error)
    GetByEmail(ctx context.Context, email string) (*User, error)
    Update(ctx context.Context, user *User) error
    Delete(ctx context.Context, id uuid.UUID) error
}

// Service Interface
type UserService interface {
    CreateUser(ctx context.Context, req *CreateUserRequest) (*User, error)
    GetUser(ctx context.Context, id uuid.UUID) (*User, error)
    UpdateUser(ctx context.Context, id uuid.UUID, req *UpdateUserRequest) (*User, error)
    DeleteUser(ctx context.Context, id uuid.UUID) error
}
```

### **Clean Architecture Layers**

```go
// Handler Layer (HTTP)
func (h *UserHandler) CreateUser(c *gin.Context) {
    var req CreateUserRequest
    if err := c.ShouldBindJSON(&req); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
        return
    }
    
    user, err := h.userService.CreateUser(c.Request.Context(), &req)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }
    
    c.JSON(http.StatusCreated, user)
}

// Service Layer (Business Logic)
func (s *userService) CreateUser(ctx context.Context, req *CreateUserRequest) (*User, error) {
    // Business validation
    if err := s.validateCreateUserRequest(req); err != nil {
        return nil, err
    }
    
    // Create domain entity
    user := &User{
        ID:       uuid.New(),
        Email:    req.Email,
        Username: req.Username,
    }
    
    // Save to repository
    if err := s.userRepo.Create(ctx, user); err != nil {
        return nil, err
    }
    
    return user, nil
}

// Repository Layer (Data Access)
func (r *userRepository) Create(ctx context.Context, user *User) error {
    return r.db.WithContext(ctx).Create(user).Error
}
```

---

## 🔧 **Development Tools & Scripts**

### **Makefile**

```makefile
.PHONY: build run test lint clean docker

# Build the application
build:
	go build -o bin/server cmd/server/main.go

# Run the application
run:
	go run cmd/server/main.go

# Run tests
test:
	go test -v ./...

# Run tests with coverage
test-coverage:
	go test -v -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out

# Run linting
lint:
	golangci-lint run

# Format code
fmt:
	go fmt ./...

# Clean build artifacts
clean:
	rm -rf bin/
	rm -f coverage.out

# Build Docker image
docker:
	docker build -t danaverse-api .

# Run with Docker Compose
docker-up:
	docker-compose up -d

# Stop Docker Compose
docker-down:
	docker-compose down

# Run database migrations
migrate:
	go run cmd/migrate/main.go

# Seed database
seed:
	go run cmd/seed/main.go
```

### **Development Scripts**

```bash
#!/bin/bash
# scripts/dev.sh - Development setup script

set -e

echo "🚀 Setting up DanaVerse API development environment..."

# Check Go version
go version

# Install dependencies
go mod download

# Install development tools
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/swaggo/swag/cmd/swag@latest

# Run linting
golangci-lint run

# Run tests
go test -v ./...

# Generate API documentation
swag init -g cmd/server/main.go

echo "✅ Development environment ready!"
```

---

## 📚 **Documentation Standards**

### **Required Documentation**

- **README.md** - Project overview and setup
- **CONTRIBUTING.md** - Contribution guidelines
- **CHANGELOG.md** - Version history
- **docs/architecture.md** - Architecture documentation
- **docs/api.md** - API documentation
- **docs/deployment.md** - Deployment instructions
- **docs/development.md** - Development guidelines

### **Code Documentation**

- **GoDoc comments** for all public functions and types
- **README files** for each major package
- **API documentation** generated from code comments
- **Architecture decision records (ADRs)**

---

## 🔄 **Development Workflow**

### **Git Workflow**

- **Feature branches** for new development
- **Pull requests** with code review
- **Conventional commit messages**
- **Automated quality checks**

### **Quality Assurance**

- **Automated testing** on all changes
- **Code coverage** requirements (80%+)
- **Performance benchmarking**
- **Security scanning**
- **Dependency vulnerability checks**

---

## 🚀 **Getting Started for New Developers**

1. **Install Go** - Version 1.22 or higher
2. **Clone Repository** - Get the latest code
3. **Install Dependencies** - Run `go mod download`
4. **Setup Environment** - Configure environment variables
5. **Run Database** - Start PostgreSQL and Redis
6. **Run Migrations** - Execute database migrations
7. **Start Server** - Run `make run`
8. **Read Documentation** - Understand project structure
9. **Follow Conventions** - Adhere to Go best practices
10. **Write Tests** - Include tests for new features

---

## 🆘 **Support & Resources**

- **Project Maintainer** - Contact for questions and guidance
- **Documentation** - Keep documentation updated
- **Code Examples** - Check existing code for patterns
- **Team Knowledge Sharing** - Regular knowledge sharing sessions

---

_This structure follows modern Go best practices and is designed for scalability, maintainability, and team collaboration. Adapt as needed for your specific requirements._
