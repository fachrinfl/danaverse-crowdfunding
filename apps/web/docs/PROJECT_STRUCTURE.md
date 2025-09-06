# 🌐 DanaVerse Web - Next.js Enterprise Project Structure

This documentation defines the **standardized folder structure**, **file purposes**, **naming conventions**, and **architectural patterns** for the DanaVerse web application using **Next.js 15** with modern React patterns and enterprise-grade architecture.

---

## 🎯 **Architecture Principles**

### **Core Design Philosophy**

- **Feature-First Organization** - Group by business domain, not technical concerns
- **Server Components First** - Leverage Next.js App Router with Server Components
- **TypeScript First** - Strong typing throughout the codebase
- **Atomic Design System** - Reusable UI components following atomic principles
- **Tailwind CSS First** - Utility-first CSS framework as primary styling
- **Performance Optimized** - Image optimization, code splitting, and caching
- **SEO Ready** - Server-side rendering and metadata optimization

### **Technology Stack**

- **Next.js 15** with **App Router**
- **React 19** with Server and Client Components
- **TypeScript** for type safety
- **Tailwind CSS** for styling
- **Zustand** for client-side state management
- **TanStack Query** for server state management
- **Storybook** for component development
- **Framer Motion** for animations

---

## 🏗️ **Root Project Structure**

```
apps/web/
├── src/                     # Source code (main application)
├── public/                  # Static assets
├── docs/                    # Project documentation
├── scripts/                 # Build and utility scripts
├── .storybook/              # Storybook configuration
├── .cursor/                 # Cursor IDE rules
├── app/                     # Next.js App Router
├── components/              # Shared components
├── lib/                     # Utility libraries
├── styles/                  # Global styles
├── types/                   # TypeScript type definitions
├── next.config.js           # Next.js configuration
├── tailwind.config.js       # Tailwind CSS configuration
├── postcss.config.js        # PostCSS configuration
├── package.json             # Dependencies and scripts
├── tsconfig.json            # TypeScript configuration
├── jest.config.js           # Jest testing configuration
├── .eslintrc.js             # ESLint configuration
├── .prettierrc.js           # Prettier configuration
├── .env.example             # Environment variables template
└── README.md                # Project overview
```

---

## 📁 **`app/` – Next.js App Router**

**File-based routing system** - Each file becomes a route automatically.

### **Structure Overview**

```
app/
├── globals.css              # Global styles
├── layout.tsx               # Root layout
├── page.tsx                 # Home page (/)
├── loading.tsx              # Global loading UI
├── error.tsx                # Global error UI
├── not-found.tsx            # 404 page
├── (auth)/                  # Authentication routes group
│   ├── layout.tsx           # Auth layout wrapper
│   ├── login/               # Login page
│   │   └── page.tsx         # /(auth)/login
│   ├── register/            # Register page
│   │   └── page.tsx         # /(auth)/register
│   ├── forgot-password/     # Forgot password page
│   │   └── page.tsx         # /(auth)/forgot-password
│   ├── reset-password/      # Reset password page
│   │   └── page.tsx         # /(auth)/reset-password
│   └── verify-email/        # Email verification page
│       └── page.tsx         # /(auth)/verify-email
├── (dashboard)/             # Main dashboard routes group
│   ├── layout.tsx           # Dashboard layout with navigation
│   ├── page.tsx             # /(dashboard)/ - Dashboard home
│   ├── projects/            # Projects feature routes
│   │   ├── page.tsx         # /(dashboard)/projects - Projects list
│   │   ├── [id]/            # Dynamic project routes
│   │   │   ├── page.tsx     # /(dashboard)/projects/[id] - Project detail
│   │   │   ├── edit/        # Edit project
│   │   │   │   └── page.tsx # /(dashboard)/projects/[id]/edit
│   │   │   └── funding/     # Project funding
│   │   │       └── page.tsx # /(dashboard)/projects/[id]/funding
│   │   ├── create/          # Create new project
│   │   │   └── page.tsx     # /(dashboard)/projects/create
│   │   └── my-projects/     # User's projects
│   │       └── page.tsx     # /(dashboard)/projects/my-projects
│   ├── wallet/              # Wallet feature routes
│   │   ├── page.tsx         # /(dashboard)/wallet - Wallet overview
│   │   ├── transactions/    # Transaction history
│   │   │   └── page.tsx     # /(dashboard)/wallet/transactions
│   │   ├── send/            # Send funds
│   │   │   └── page.tsx     # /(dashboard)/wallet/send
│   │   └── receive/         # Receive funds
│   │       └── page.tsx     # /(dashboard)/wallet/receive
│   ├── profile/             # Profile feature routes
│   │   ├── page.tsx         # /(dashboard)/profile - Profile overview
│   │   ├── edit/            # Edit profile
│   │   │   └── page.tsx     # /(dashboard)/profile/edit
│   │   ├── settings/        # User settings
│   │   │   └── page.tsx     # /(dashboard)/profile/settings
│   │   └── notifications/   # Notification settings
│   │       └── page.tsx     # /(dashboard)/profile/notifications
│   └── admin/               # Admin routes (protected)
│       ├── layout.tsx       # Admin layout
│       ├── page.tsx         # /(dashboard)/admin - Admin dashboard
│       ├── users/           # User management
│       │   └── page.tsx     # /(dashboard)/admin/users
│       ├── projects/        # Project management
│       │   └── page.tsx     # /(dashboard)/admin/projects
│       └── analytics/       # Analytics
│           └── page.tsx     # /(dashboard)/admin/analytics
├── (public)/                # Public routes (no auth required)
│   ├── layout.tsx           # Public layout
│   ├── page.tsx             # /(public)/ - Landing page
│   ├── about/               # About page
│   │   └── page.tsx         # /(public)/about
│   ├── contact/             # Contact page
│   │   └── page.tsx         # /(public)/contact
│   ├── help/                # Help center
│   │   ├── page.tsx         # /(public)/help
│   │   └── [slug]/          # Help articles
│   │       └── page.tsx     # /(public)/help/[slug]
│   └── legal/               # Legal pages
│       ├── terms/           # Terms of service
│       │   └── page.tsx     # /(public)/legal/terms
│       ├── privacy/         # Privacy policy
│       │   └── page.tsx     # /(public)/legal/privacy
│       └── cookies/         # Cookie policy
│           └── page.tsx     # /(public)/legal/cookies
├── api/                     # API routes
│   ├── auth/                # Authentication API
│   │   ├── login/           # Login endpoint
│   │   │   └── route.ts     # POST /api/auth/login
│   │   ├── register/        # Register endpoint
│   │   │   └── route.ts     # POST /api/auth/register
│   │   ├── logout/          # Logout endpoint
│   │   │   └── route.ts     # POST /api/auth/logout
│   │   └── refresh/         # Token refresh
│   │       └── route.ts     # POST /api/auth/refresh
│   ├── projects/            # Projects API
│   │   ├── route.ts         # GET, POST /api/projects
│   │   └── [id]/            # Project-specific endpoints
│   │       ├── route.ts     # GET, PUT, DELETE /api/projects/[id]
│   │       └── funding/     # Project funding
│   │           └── route.ts # POST /api/projects/[id]/funding
│   ├── wallet/              # Wallet API
│   │   ├── route.ts         # GET /api/wallet
│   │   ├── transactions/    # Transaction endpoints
│   │   │   └── route.ts     # GET, POST /api/wallet/transactions
│   │   └── send/            # Send funds
│   │       └── route.ts     # POST /api/wallet/send
│   └── webhooks/            # Webhook endpoints
│       ├── stripe/          # Stripe webhooks
│       │   └── route.ts     # POST /api/webhooks/stripe
│       └── blockchain/      # Blockchain webhooks
│           └── route.ts     # POST /api/webhooks/blockchain
└── _not-found.tsx           # Global 404 fallback
```

---

## 📁 **`src/` – Source Code Architecture**

### **`src/application/` – Global Application Layer**

**Application-wide configuration, providers, and base dependencies.**

```
src/application/
├── providers/               # React Context providers
│   ├── app-provider.tsx    # Combined root provider
│   ├── auth-provider.tsx   # Authentication context
│   ├── theme-provider.tsx  # Theme and appearance
│   ├── locale-provider.tsx # Internationalization
│   ├── analytics-provider.tsx # Analytics tracking
│   ├── error-boundary-provider.tsx # Error handling
│   └── index.ts            # Provider exports
├── config/                  # Application configuration
│   ├── env.ts              # Environment variables
│   ├── constants.ts        # App-wide constants
│   ├── theme.ts            # Theme configuration
│   ├── i18n.ts             # Internationalization setup
│   └── api-config.ts       # API configuration
├── services/                # Global services
│   ├── storage-service.ts  # Local storage wrapper
│   ├── logger-service.ts   # Logging service
│   ├── analytics-service.ts # Analytics service
│   ├── error-service.ts    # Error reporting
│   └── network-service.ts  # Network status monitoring
├── hooks/                   # Global custom hooks
│   ├── use-auth.ts         # Authentication hook
│   ├── use-theme.ts        # Theme hook
│   ├── use-locale.ts       # Locale hook
│   ├── use-analytics.ts    # Analytics hook
│   └── use-storage.ts      # Storage hook
├── store/                   # Global state management
│   ├── index.ts            # Store configuration
│   ├── auth-store.ts       # Authentication state
│   ├── app-store.ts        # Application state
│   ├── theme-store.ts      # Theme state
│   └── middleware/          # Store middleware
│       ├── persist.ts       # State persistence
│       ├── devtools.ts      # Redux DevTools integration
│       └── logger.ts        # State change logging
└── utils/                   # Global utility functions
    ├── validation.ts       # Form validation
    ├── formatting.ts       # Data formatting
    ├── date-utils.ts       # Date manipulation
    ├── currency-utils.ts   # Currency formatting
    ├── storage-utils.ts    # Storage helpers
    └── network-utils.ts    # Network utilities
```

### **`src/features/` – Feature Modules**

**Modular business logic organized by domain.**

Each feature follows this structure:

```
src/features/
├── auth/                    # Authentication feature
│   ├── components/         # Feature-specific components
│   │   ├── LoginForm.tsx
│   │   ├── RegisterForm.tsx
│   │   ├── ForgotPasswordForm.tsx
│   │   └── PasswordStrengthIndicator.tsx
│   ├── hooks/              # Feature-specific hooks
│   │   ├── useLogin.ts
│   │   ├── useRegister.ts
│   │   └── usePasswordReset.ts
│   ├── services/           # Feature services
│   │   ├── auth-service.ts
│   │   └── auth-storage.ts
│   ├── store/              # Feature state management
│   │   └── auth-store.ts
│   ├── types/              # Feature type definitions
│   │   ├── auth-types.ts
│   │   └── auth-schemas.ts
│   ├── utils/              # Feature utilities
│   │   ├── validation.ts
│   │   └── helpers.ts
│   └── __tests__/          # Feature tests
│       ├── components/
│       ├── hooks/
│       └── services/
├── projects/               # Projects feature
│   ├── components/
│   │   ├── ProjectCard.tsx
│   │   ├── ProjectForm.tsx
│   │   ├── ProjectImageGallery.tsx
│   │   ├── ProjectProgress.tsx
│   │   └── ProjectFundingForm.tsx
│   ├── hooks/
│   │   ├── useProjects.ts
│   │   ├── useProject.ts
│   │   └── useProjectMutations.ts
│   ├── services/
│   │   ├── project-service.ts
│   │   └── project-storage.ts
│   ├── store/
│   │   └── project-store.ts
│   ├── types/
│   │   ├── project-types.ts
│   │   └── project-schemas.ts
│   └── __tests__/
├── wallet/                 # Wallet feature
│   ├── components/
│   │   ├── WalletBalance.tsx
│   │   ├── TransactionItem.tsx
│   │   ├── QRCodeGenerator.tsx
│   │   └── SendReceiveForm.tsx
│   ├── hooks/
│   │   ├── useWallet.ts
│   │   └── useTransactions.ts
│   ├── services/
│   │   ├── wallet-service.ts
│   │   └── blockchain-service.ts
│   ├── store/
│   │   └── wallet-store.ts
│   ├── types/
│   │   └── wallet-types.ts
│   └── __tests__/
├── profile/                # Profile feature
│   ├── components/
│   │   ├── ProfileForm.tsx
│   │   ├── AvatarUpload.tsx
│   │   └── SettingsList.tsx
│   ├── hooks/
│   │   ├── useProfile.ts
│   │   └── useSettings.ts
│   ├── services/
│   │   ├── profile-service.ts
│   │   └── settings-service.ts
│   ├── store/
│   │   └── profile-store.ts
│   ├── types/
│   │   └── profile-types.ts
│   └── __tests__/
└── notifications/          # Notifications feature
    ├── components/
    │   ├── NotificationItem.tsx
    │   ├── NotificationBadge.tsx
    │   └── NotificationSettings.tsx
    ├── hooks/
    │   ├── useNotifications.ts
    │   └── useNotificationSettings.ts
    ├── services/
    │   ├── notification-service.ts
    │   └── push-notification-service.ts
    ├── store/
    │   └── notification-store.ts
    ├── types/
    │   └── notification-types.ts
    └── __tests__/
```

### **`src/shared/` – Shared Resources**

**Code reused across all features.**

```
src/shared/
├── components/              # Atomic design system
│   ├── ui/                 # Base UI components
│   │   ├── button.tsx      # Button component with variants
│   │   ├── input.tsx       # Input component with validation
│   │   ├── card.tsx        # Card component
│   │   ├── badge.tsx       # Badge component
│   │   ├── avatar.tsx      # Avatar component
│   │   ├── modal.tsx       # Modal component
│   │   ├── toast.tsx       # Toast notification
│   │   ├── skeleton.tsx    # Loading skeleton
│   │   └── index.ts        # Component exports
│   ├── layout/             # Layout components
│   │   ├── header.tsx      # Site header
│   │   ├── footer.tsx      # Site footer
│   │   ├── sidebar.tsx     # Dashboard sidebar
│   │   ├── navigation.tsx  # Navigation component
│   │   └── breadcrumb.tsx  # Breadcrumb navigation
│   ├── forms/              # Form components
│   │   ├── form-field.tsx  # Form field wrapper
│   │   ├── form-input.tsx  # Form input component
│   │   ├── form-select.tsx # Form select component
│   │   ├── form-textarea.tsx # Form textarea component
│   │   └── form-checkbox.tsx # Form checkbox component
│   ├── data-display/       # Data display components
│   │   ├── table.tsx       # Data table
│   │   ├── chart.tsx       # Chart component
│   │   ├── stats-card.tsx  # Statistics card
│   │   └── progress-bar.tsx # Progress bar
│   └── feedback/           # Feedback components
│       ├── loading-spinner.tsx # Loading indicator
│       ├── error-boundary.tsx # Error boundary
│       ├── empty-state.tsx # Empty state component
│       └── success-message.tsx # Success message
├── hooks/                   # Shared custom hooks
│   ├── use-debounce.ts     # Debounce hook
│   ├── use-is-mounted.ts   # Mount status hook
│   ├── use-previous.ts     # Previous value hook
│   ├── use-local-storage.ts # Local storage hook
│   ├── use-session-storage.ts # Session storage hook
│   ├── use-copy-to-clipboard.ts # Clipboard hook
│   ├── use-network-status.ts # Network status hook
│   ├── use-intersection-observer.ts # Intersection observer
│   ├── use-media-query.ts  # Media query hook
│   └── use-keyboard-shortcut.ts # Keyboard shortcut hook
├── services/                # Shared services
│   ├── api/                # API layer
│   │   ├── client.ts       # API client configuration
│   │   ├── interceptors.ts # Request/response interceptors
│   │   ├── auth.ts         # Authentication API
│   │   ├── projects.ts     # Projects API
│   │   ├── wallet.ts       # Wallet API
│   │   └── notifications.ts # Notifications API
│   ├── storage/            # Storage services
│   │   ├── local-storage.ts # LocalStorage wrapper
│   │   ├── session-storage.ts # SessionStorage wrapper
│   │   └── cookie-storage.ts # Cookie storage wrapper
│   └── third-party/        # Third-party integrations
│       ├── stripe.ts       # Stripe payment integration
│       ├── sentry.ts       # Sentry error tracking
│       ├── posthog.ts      # PostHog analytics
│       ├── intercom.ts     # Intercom support
│       └── google-analytics.ts # Google Analytics
├── utils/                   # Utility functions
│   ├── validation/         # Validation utilities
│   │   ├── schemas.ts      # Zod schemas
│   │   ├── validators.ts   # Custom validators
│   │   └── helpers.ts      # Validation helpers
│   ├── formatting/         # Formatting utilities
│   │   ├── date.ts         # Date formatting
│   │   ├── currency.ts     # Currency formatting
│   │   ├── number.ts       # Number formatting
│   │   └── text.ts         # Text formatting
│   ├── helpers/            # Helper functions
│   │   ├── array.ts        # Array utilities
│   │   ├── object.ts       # Object utilities
│   │   ├── string.ts       # String utilities
│   │   └── math.ts         # Math utilities
│   └── constants/          # Constants
│       ├── colors.ts       # Color palette
│       ├── typography.ts   # Typography scale
│       ├── spacing.ts      # Spacing scale
│       ├── breakpoints.ts  # Breakpoint values
│       └── api.ts          # API constants
├── types/                   # Global type definitions
│   ├── api.ts              # API types
│   ├── navigation.ts       # Navigation types
│   ├── common.ts           # Common types
│   ├── forms.ts            # Form types
│   └── theme.ts            # Theme types
└── config/                  # Configuration files
    ├── theme.ts             # Theme configuration
    ├── i18n.ts              # Internationalization config
    ├── api.ts               # API configuration
    └── storage.ts           # Storage configuration
```

---

## 📁 **`public/` – Static Assets**

**Organized asset management for images, fonts, and other static files.**

```
public/
├── images/                  # Image assets
│   ├── logos/              # Brand assets
│   │   ├── logo.svg        # Main logo
│   │   ├── logo-dark.svg   # Dark mode logo
│   │   ├── favicon.ico     # Favicon
│   │   └── apple-touch-icon.png # Apple touch icon
│   ├── icons/              # UI icons
│   │   ├── navigation/     # Navigation icons
│   │   │   ├── home.svg
│   │   │   ├── projects.svg
│   │   │   ├── wallet.svg
│   │   │   └── profile.svg
│   │   ├── actions/        # Action icons
│   │   │   ├── add.svg
│   │   │   ├── edit.svg
│   │   │   ├── delete.svg
│   │   │   └── share.svg
│   │   └── status/         # Status indicators
│   │       ├── success.svg
│   │       ├── error.svg
│   │       ├── warning.svg
│   │       └── info.svg
│   ├── illustrations/      # Illustration assets
│   │   ├── onboarding/     # Onboarding illustrations
│   │   │   ├── welcome.svg
│   │   │   ├── wallet-setup.svg
│   │   │   └── complete.svg
│   │   ├── empty-states/   # Empty state illustrations
│   │   │   ├── no-projects.svg
│   │   │   ├── no-data.svg
│   │   │   └── no-results.svg
│   │   └── errors/         # Error illustrations
│   │       ├── 404.svg
│   │       ├── 500.svg
│   │       └── network-error.svg
│   ├── backgrounds/        # Background images
│   │   ├── hero-bg.jpg     # Hero section background
│   │   ├── login-bg.jpg    # Login background
│   │   └── dashboard-bg.jpg # Dashboard background
│   └── placeholders/       # Placeholder images
│       ├── project-placeholder.jpg
│       ├── user-placeholder.jpg
│       └── image-placeholder.jpg
├── fonts/                   # Custom font files
│   ├── inter/              # Inter font family
│   │   ├── Inter-Regular.woff2
│   │   ├── Inter-Medium.woff2
│   │   ├── Inter-SemiBold.woff2
│   │   └── Inter-Bold.woff2
│   └── poppins/            # Poppins font family
│       ├── Poppins-Regular.woff2
│       ├── Poppins-Medium.woff2
│       └── Poppins-SemiBold.woff2
├── icons/                   # Icon sprite files
│   ├── sprite.svg          # Icon sprite
│   └── manifest.json       # Icon manifest
└── data/                    # Static data files
    ├── countries.json       # Countries list
    ├── currencies.json      # Currencies list
    └── languages.json       # Languages list
```

---

## 🧪 **Testing Structure**

**Comprehensive testing strategy with proper organization.**

```
tests/
├── unit/                    # Unit tests
│   ├── components/         # Component tests
│   │   ├── ui/            # UI component tests
│   │   ├── layout/        # Layout component tests
│   │   ├── forms/         # Form component tests
│   │   └── data-display/  # Data display component tests
│   ├── hooks/             # Hook tests
│   ├── services/          # Service tests
│   ├── utils/             # Utility function tests
│   └── store/             # Store tests
├── integration/            # Integration tests
│   ├── features/          # Feature integration tests
│   │   ├── auth-flow.test.ts
│   │   ├── project-workflow.test.ts
│   │   └── wallet-flow.test.ts
│   ├── api/               # API integration tests
│   └── pages/             # Page integration tests
├── e2e/                   # End-to-end tests
│   ├── playwright/        # Playwright E2E tests
│   │   ├── auth.spec.ts
│   │   ├── projects.spec.ts
│   │   └── wallet.spec.ts
│   └── cypress/           # Cypress E2E tests (alternative)
├── setup/                 # Test configuration
│   ├── jest.setup.ts      # Jest global setup
│   ├── test-utils.tsx     # Test utilities and helpers
│   ├── mocks/             # Mock implementations
│   │   ├── api.ts         # API mocks
│   │   ├── next-router.ts # Next.js router mocks
│   │   ├── storage.ts     # Storage mocks
│   │   └── third-party.ts # Third-party service mocks
│   └── fixtures/          # Test data fixtures
│       ├── users.ts       # User test data
│       ├── projects.ts    # Project test data
│       └── transactions.ts # Transaction test data
└── coverage/               # Test coverage reports
    ├── lcov-report/        # LCOV coverage report
    ├── html-report/        # HTML coverage report
    └── coverage.json       # Coverage data
```

---

## 🏗️ **File Naming Conventions**

### **React Components (PascalCase)**

```
Button.tsx, ProjectCard.tsx, UserList.tsx, DashboardPage.tsx
```

### **Hooks (camelCase with 'use' prefix)**

```
useAuth.ts, useProjectData.ts, useNetworkStatus.ts, useLocalStorage.ts
```

### **Services & Utils (kebab-case)**

```
auth-service.ts, project-service.ts, format-currency.ts, validate-email.ts
```

### **Types & Interfaces (PascalCase)**

```
User.ts, ProjectType.ts, ApiResponse.ts, NavigationProps.ts
```

### **Constants (UPPER_SNAKE_CASE)**

```
API_ENDPOINTS.ts, COLORS.ts, VALIDATION_RULES.ts, STORAGE_KEYS.ts
```

### **Folders (kebab-case)**

```
components/, api-endpoints/, business-logic/, feature-modules/
```

### **File Extensions**

- **`.tsx`** for files that return JSX
- **`.ts`** for logic-only modules
- **`.json`** for configuration and data files
- **`.md`** for documentation files

---

## 🎨 **Styling Strategy**

### **Priority Order**

1. **Tailwind CSS** - Primary styling method
2. **CSS Modules** - Component-specific styles
3. **Global CSS** - Only for base styles and utilities
4. **Inline styles** - Only for dynamic values

### **Styling Examples**

```typescript
// ✅ PREFERRED: Tailwind CSS classes
<div className="flex flex-col bg-white p-6 rounded-lg shadow-sm">
  <h2 className="text-xl font-bold text-gray-900 mb-4">
    Project Title
  </h2>
  <div className="flex items-center gap-3">
    <button className="bg-blue-500 hover:bg-blue-600 px-4 py-2 rounded-lg text-white">
      Fund Project
    </button>
  </div>
</div>

// ✅ ACCEPTABLE: CSS Modules for complex layouts
import styles from './ComplexLayout.module.css';

<div className={`${styles.complexLayout} ${styles.animated}`}>
  <h2 className="text-center">Complex Layout</h2>
</div>

// ✅ ACCEPTABLE: Inline styles for dynamic values
<div style={{ width: dynamicWidth, height: dynamicHeight }}>
  <h2 className="text-center">Dynamic content</h2>
</div>

// ✅ CONDITIONAL STYLING: Use template literals for variants
<div className={`p-4 rounded-lg ${
  variant === 'primary' ? 'bg-blue-500 text-white' :
  variant === 'secondary' ? 'bg-gray-500 text-white' :
  'bg-white text-gray-900'
}`}>
  <h2 className="font-bold">Button Text</h2>
</div>
```

---

## 🔧 **Development Tools & Scripts**

### **Package.json Scripts**

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "lint:fix": "next lint --fix",
    "type-check": "tsc --noEmit",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:e2e": "playwright test",
    "test:e2e:ui": "playwright test --ui",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "storybook": "storybook dev -p 6006",
    "build-storybook": "storybook build",
    "analyze": "cross-env ANALYZE=true next build",
    "clean": "rm -rf .next out dist",
    "reset:module": "rm -rf node_modules && rm -rf .next && npm install --force"
  }
}
```

---

## 📚 **Documentation Standards**

### **Required Documentation**

- **README.md** - Project overview and setup
- **CONTRIBUTING.md** - Contribution guidelines
- **CHANGELOG.md** - Version history
- **docs/structure.md** - Project structure documentation
- **docs/api.md** - API documentation
- **docs/components.md** - Component documentation
- **docs/testing.md** - Testing guidelines
- **docs/deployment.md** - Deployment instructions

### **Code Documentation**

- **JSDoc comments** for complex functions and components
- **TypeScript interfaces** for all data structures
- **Usage examples** for reusable components
- **README files** for each major directory

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
- **Performance monitoring**
- **Accessibility testing**
- **SEO optimization**

---

## 🚀 **Getting Started for New Developers**

1. **Clone Repository** - Get the latest code
2. **Install Dependencies** - Run `pnpm install`
3. **Environment Setup** - Configure environment variables
4. **Run Development Server** - Start with `pnpm dev`
5. **Read Documentation** - Understand project structure
6. **Follow Conventions** - Adhere to naming and coding standards
7. **Write Tests** - Include tests for new features
8. **Submit PR** - Follow the pull request process

---

## 🆘 **Support & Resources**

- **Project Maintainer** - Contact for questions and guidance
- **Documentation** - Keep documentation updated
- **Code Examples** - Check existing code for patterns
- **Team Knowledge Sharing** - Regular knowledge sharing sessions

---

_This structure follows modern Next.js best practices and is designed for scalability, maintainability, and team collaboration. Adapt as needed for your specific requirements._
