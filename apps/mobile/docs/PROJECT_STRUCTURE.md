# 🚀 React Native Enterprise Project Structure (Expo + Modern Architecture)

This documentation defines the **standardized folder structure**, **file purposes**, **naming conventions**, and **architectural patterns** for enterprise-scale React Native projects using **Expo Router** with modern functional components and modular architecture.

---

## 🎯 **Architecture Principles**

### **Core Design Philosophy**

- **Feature-First Organization** - Group by business domain, not technical concerns
- **Functional Components Only** - Modern React with hooks, no class components
- **TypeScript First** - Strong typing throughout the codebase
- **Atomic Design System** - Reusable UI components following atomic principles
- **NativeWind First** - Tailwind CSS as primary styling, StyleSheet as fallback
- **Performance Optimized** - React.memo, useMemo, useCallback where appropriate
- **Testing Ready** - Structure supports unit, integration, and E2E testing

### **Technology Stack**

- **React Native** with **Expo SDK 53+**
- **Expo Router** for file-based routing
- **TypeScript** for type safety
- **NativeWind** for styling (Tailwind CSS)
- **Zustand** for global state management
- **React Query/TanStack Query** for data fetching
- **Storybook** for component development

---

## 🏗️ **Root Project Structure**

```
apps/mobile/
├── app/                     # Expo Router file-based routing
├── src/                     # Source code (main application)
├── assets/                  # Static assets
├── docs/                    # Project documentation
├── scripts/                 # Build and utility scripts
├── .storybook/              # Storybook configuration
├── .cursor/                 # Cursor IDE rules
├── app.config.ts            # Expo configuration
├── app.tsx                  # Main entry point
├── index.js                 # React Native bootstrap
├── package.json             # Dependencies and scripts
├── tsconfig.json            # TypeScript configuration
├── tailwind.config.js       # NativeWind configuration
├── metro.config.js          # Metro bundler configuration
├── babel.config.js          # Babel configuration
├── jest.config.js           # Jest testing configuration
├── .eslintrc.js             # ESLint configuration
├── .prettierrc.js           # Prettier configuration
├── .husky/                  # Git hooks
├── .github/                 # GitHub workflows and templates
├── .env.example             # Environment variables template
├── README.md                # Project overview
├── CONTRIBUTING.md          # Contribution guidelines
├── CHANGELOG.md             # Version history
└── LICENSE                  # Project license
```

---

## 📁 **`app/` – Expo Router Layer**

**File-based routing system** - Each file becomes a route automatically.

### **Structure Overview**

```
app/
├── _layout.tsx              # Root layout with providers
├── index.tsx                # '/' - Main entry point
├── (auth)/                  # Authentication routes group
│   ├── _layout.tsx          # Auth layout wrapper
│   ├── login.tsx            # /(auth)/login
│   ├── register.tsx         # /(auth)/register
│   ├── forgot-password.tsx  # /(auth)/forgot-password
│   ├── reset-password.tsx   # /(auth)/reset-password
│   └── verify-email.tsx     # /(auth)/verify-email
├── (app)/                   # Main app routes group
│   ├── _layout.tsx          # App layout with navigation
│   ├── (tabs)/              # Bottom tab navigation
│   │   ├── _layout.tsx      # Tab navigator layout
│   │   ├── index.tsx        # /(app)/(tabs)/ - Home tab
│   │   ├── dashboard.tsx    # /(app)/(tabs)/dashboard
│   │   ├── projects.tsx     # /(app)/(tabs)/projects
│   │   ├── profile.tsx      # /(app)/(tabs)/profile
│   │   └── settings.tsx     # /(app)/(tabs)/settings
│   ├── projects/            # Project feature routes
│   │   ├── [id].tsx         # /(app)/projects/[id] - Project detail
│   │   ├── create.tsx       # /(app)/projects/create
│   │   └── edit/[id].tsx    # /(app)/projects/edit/[id]
│   ├── profile/             # Profile feature routes
│   │   ├── edit.tsx         # /(app)/profile/edit
│   │   └── settings.tsx     # /(app)/profile/settings
│   ├── modals/              # Modal routes
│   │   ├── project-preview.tsx # /(app)/modals/project-preview
│   │   ├── image-gallery.tsx   # /(app)/modals/image-gallery
│   │   └── share.tsx            # /(app)/modals/share
│   └── [dynamic]/           # Dynamic catch-all routes
│       └── [...route].tsx   # Catch-all for dynamic routes
├── (onboarding)/            # Onboarding flow routes
│   ├── _layout.tsx          # Onboarding layout
│   ├── welcome.tsx          # /(onboarding)/welcome
│   ├── setup.tsx            # /(onboarding)/setup
│   └── complete.tsx         # /(onboarding)/complete
├── (error)/                 # Error handling routes
│   ├── _layout.tsx          # Error layout
│   ├── 404.tsx              # /(error)/404 - Not found
│   ├── 500.tsx              # /(error)/500 - Server error
│   └── network-error.tsx    # /(error)/network-error
└── _not-found.tsx           # Global 404 fallback
```

### **Route Organization Rules**

- **Group related routes** with parentheses: `(auth)`, `(app)`, `(onboarding)`
- **Use dynamic routes** with brackets: `[id]`, `[slug]`, `[...route]`
- **Modal routes** should be grouped under `modals/` for consistency
- **Layout files** (`_layout.tsx`) define navigation structure and providers
- **Index files** (`index.tsx`) are the default route for each group
- **Error boundaries** should be implemented at appropriate levels

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
├── navigation/              # Navigation configuration
│   ├── linking-config.ts   # Deep linking configuration
│   ├── navigation-types.ts # Navigation type definitions
│   └── navigation-utils.ts # Navigation helper functions
├── config/                  # Application configuration
│   ├── env.ts              # Environment variables
│   ├── constants.ts        # App-wide constants
│   ├── theme.ts            # Theme configuration
│   ├── i18n.ts             # Internationalization setup
│   └── api-config.ts       # API configuration
├── services/                # Global services
│   ├── storage-service.ts  # Local storage wrapper
│   ├── logger-service.ts   # Logging service
│   ├── notification-service.ts # Push notifications
│   ├── analytics-service.ts # Analytics service
│   ├── error-service.ts    # Error reporting
│   └── network-service.ts  # Network status monitoring
├── hooks/                   # Global custom hooks
│   ├── use-auth.ts         # Authentication hook
│   ├── use-theme.ts        # Theme hook
│   ├── use-locale.ts       # Locale hook
│   ├── use-analytics.ts    # Analytics hook
│   ├── use-network.ts      # Network status hook
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
│   ├── screens/            # Feature screens
│   │   ├── LoginScreen.tsx
│   │   ├── RegisterScreen.tsx
│   │   ├── ForgotPasswordScreen.tsx
│   │   └── ResetPasswordScreen.tsx
│   ├── components/         # Feature-specific components
│   │   ├── LoginForm.tsx
│   │   ├── RegisterForm.tsx
│   │   └── PasswordStrengthIndicator.tsx
│   ├── hooks/              # Feature-specific hooks
│   │   ├── useLogin.ts
│   │   ├── useRegister.ts
│   │   └── usePasswordReset.ts
│   ├── services/           # Feature services
│   │   ├── auth-service.ts
│   │   ├── auth-socket.ts  # Real-time auth updates
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
│   ├── screens/
│   │   ├── ProjectListScreen.tsx
│   │   ├── ProjectDetailScreen.tsx
│   │   ├── ProjectCreateScreen.tsx
│   │   └── ProjectEditScreen.tsx
│   ├── components/
│   │   ├── ProjectCard.tsx
│   │   ├── ProjectForm.tsx
│   │   ├── ProjectImageGallery.tsx
│   │   └── ProjectStatus.tsx
│   ├── hooks/
│   │   ├── useProjects.ts
│   │   ├── useProject.ts
│   │   └── useProjectMutations.ts
│   ├── services/
│   │   ├── project-service.ts
│   │   ├── project-socket.ts
│   │   └── project-storage.ts
│   ├── store/
│   │   └── project-store.ts
│   ├── types/
│   │   ├── project-types.ts
│   │   └── project-schemas.ts
│   └── __tests__/
├── profile/                # Profile feature
│   ├── screens/
│   │   ├── ProfileScreen.tsx
│   │   ├── EditProfileScreen.tsx
│   │   └── ProfileSettingsScreen.tsx
│   ├── components/
│   │   ├── ProfileForm.tsx
│   │   ├── AvatarUpload.tsx
│   │   └── ProfileStats.tsx
│   ├── hooks/
│   │   ├── useProfile.ts
│   │   └── useProfileMutations.ts
│   ├── services/
│   │   ├── profile-service.ts
│   │   └── profile-storage.ts
│   ├── store/
│   │   └── profile-store.ts
│   ├── types/
│   │   └── profile-types.ts
│   └── __tests__/
└── settings/               # Settings feature
    ├── screens/
    │   ├── SettingsScreen.tsx
    │   ├── NotificationSettings.tsx
    │   ├── PrivacySettings.tsx
    │   └── AboutScreen.tsx
    ├── components/
    │   ├── SettingsItem.tsx
    │   ├── ToggleSwitch.tsx
    │   └── SettingsGroup.tsx
    ├── hooks/
    │   ├── useSettings.ts
    │   └── useNotificationSettings.ts
    ├── services/
    │   ├── settings-service.ts
    │   └── settings-storage.ts
    ├── store/
    │   └── settings-store.ts
    ├── types/
    │   └── settings-types.ts
    └── __tests__/
```

### **`src/shared/` – Shared Resources**

**Code reused across all features.**

```
src/shared/
├── components/              # Atomic design system
│   ├── atoms/              # Basic UI elements
│   │   ├── Button.tsx      # Button component with variants
│   │   ├── Text.tsx        # Text component with typography
│   │   ├── Input.tsx       # Input component with validation
│   │   ├── Icon.tsx        # Icon component
│   │   ├── Avatar.tsx      # Avatar component
│   │   └── Badge.tsx       # Badge component
│   ├── molecules/           # Groups of atoms
│   │   ├── FormField.tsx   # Form field wrapper
│   │   ├── SearchBar.tsx   # Search input with actions
│   │   ├── HeaderBar.tsx   # Screen header
│   │   ├── LoadingSpinner.tsx # Loading indicator
│   │   ├── ErrorBoundary.tsx # Error boundary component
│   │   └── EmptyState.tsx  # Empty state component
│   ├── organisms/           # Complex components
│   │   ├── ProjectCard.tsx # Project display card
│   │   ├── UserList.tsx    # User list component
│   │   ├── DataTable.tsx   # Data table component
│   │   ├── Chart.tsx       # Chart component
│   │   └── Modal.tsx       # Modal component
│   ├── templates/           # Page layouts
│   │   ├── ScreenTemplate.tsx # Base screen template
│   │   ├── ListTemplate.tsx # List screen template
│   │   └── FormTemplate.tsx # Form screen template
│   └── pages/              # Complete screens
│       ├── LoadingPage.tsx # Loading page
│       ├── ErrorPage.tsx   # Error page
│       └── NotFoundPage.tsx # 404 page
├── hooks/                   # Shared custom hooks
│   ├── use-debounce.ts     # Debounce hook
│   ├── use-is-mounted.ts   # Mount status hook
│   ├── use-previous.ts     # Previous value hook
│   ├── use-local-storage.ts # Local storage hook
│   ├── use-session-storage.ts # Session storage hook
│   ├── use-copy-to-clipboard.ts # Clipboard hook
│   ├── use-network-status.ts # Network status hook
│   ├── use-permissions.ts  # Permissions hook
│   ├── use-location.ts     # Location hook
│   ├── use-camera.ts       # Camera hook
│   └── use-media-library.ts # Media library hook
├── services/                # Shared services
│   ├── api/                # API layer
│   │   ├── client.ts       # API client configuration
│   │   ├── interceptors.ts # Request/response interceptors
│   │   ├── auth.ts         # Authentication API
│   │   ├── projects.ts     # Projects API
│   │   ├── users.ts        # Users API
│   │   └── analytics.ts    # Analytics API
│   ├── storage/            # Storage services
│   │   ├── async-storage.ts # AsyncStorage wrapper
│   │   ├── secure-storage.ts # Secure storage wrapper
│   │   └── cache-storage.ts # Cache storage wrapper
│   ├── websocket/          # WebSocket services
│   │   ├── client.ts       # WebSocket client
│   │   ├── manager.ts      # Connection manager
│   │   └── handlers.ts     # Message handlers
│   └── third-party/        # Third-party integrations
│       ├── firebase.ts     # Firebase configuration
│       ├── sentry.ts       # Sentry error tracking
│       ├── posthog.ts      # PostHog analytics
│       └── intercom.ts     # Intercom support
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

## 📁 **`assets/` – Static Assets**

**Organized asset management for images, fonts, and other static files.**

```
assets/
├── fonts/                   # Custom font files
│   ├── Inter/              # Inter font family
│   │   ├── Inter-Regular.ttf
│   │   ├── Inter-Medium.ttf
│   │   ├── Inter-SemiBold.ttf
│   │   ├── Inter-Bold.ttf
│   │   └── Inter-ExtraBold.ttf
│   ├── Poppins/            # Poppins font family
│   │   ├── Poppins-Regular.ttf
│   │   ├── Poppins-Medium.ttf
│   │   ├── Poppins-SemiBold.ttf
│   │   ├── Poppins-Bold.ttf
│   │   └── Poppins-ExtraBold.ttf
│   └── icons/              # Icon fonts
│       ├── MaterialIcons.ttf
│       ├── Feather.ttf
│       └── Ionicons.ttf
├── images/                  # Image assets
│   ├── logos/              # Brand assets
│   │   ├── app-logo.png    # Main app logo
│   │   ├── app-logo-dark.png # Dark mode logo
│   │   ├── brand-icon.png  # Brand icon
│   │   └── favicon.ico     # Favicon
│   ├── icons/              # UI icons
│   │   ├── navigation/     # Navigation icons
│   │   │   ├── home.png
│   │   │   ├── projects.png
│   │   │   ├── profile.png
│   │   │   └── settings.png
│   │   ├── actions/        # Action icons
│   │   │   ├── add.png
│   │   │   ├── edit.png
│   │   │   ├── delete.png
│   │   │   ├── share.png
│   │   │   └── download.png
│   │   ├── status/         # Status indicators
│   │   │   ├── success.png
│   │   │   ├── error.png
│   │   │   ├── warning.png
│   │   │   └── info.png
│   │   └── common/         # Common icons
│   │       ├── arrow-left.png
│   │       ├── arrow-right.png
│   │       ├── chevron-down.png
│   │       └── menu.png
│   ├── illustrations/      # Illustration assets
│   │   ├── onboarding/     # Onboarding illustrations
│   │   │   ├── welcome.svg
│   │   │   ├── setup.svg
│   │   │   └── complete.svg
│   │   ├── empty-states/   # Empty state illustrations
│   │   │   ├── no-projects.svg
│   │   │   ├── no-data.svg
│   │   │   └── no-results.svg
│   │   ├── errors/         # Error illustrations
│   │   │   ├── 404.svg
│   │   │   ├── 500.svg
│   │   │   └── network-error.svg
│   │   └── success/        # Success illustrations
│   │       ├── success.svg
│   │       └── celebration.svg
│   ├── backgrounds/        # Background images
│   │   ├── splash.png      # Splash screen background
│   │   ├── login-bg.png    # Login background
│   │   └── dashboard-bg.png # Dashboard background
│   ├── placeholders/       # Placeholder images
│   │   ├── project-placeholder.png
│   │   ├── user-placeholder.png
│   │   └── image-placeholder.png
│   └── patterns/           # Pattern and texture images
│       ├── dots.png
│       ├── lines.png
│       └── grid.png
├── animations/              # Animation files
│   ├── lottie/             # Lottie animations
│   │   ├── loading.json    # Loading animation
│   │   ├── success.json    # Success animation
│   │   ├── error.json      # Error animation
│   │   └── celebration.json # Celebration animation
│   └── gifs/               # GIF animations
│       ├── loading.gif
│       └── processing.gif
└── data/                    # Static data files
    ├── countries.json       # Countries list
    ├── currencies.json      # Currencies list
    ├── timezones.json       # Timezones list
    └── languages.json       # Languages list
```

---

## 🧪 **Testing Structure**

**Comprehensive testing strategy with proper organization.**

```
tests/
├── unit/                    # Unit tests
│   ├── components/         # Component tests
│   │   ├── atoms/         # Atom component tests
│   │   ├── molecules/     # Molecule component tests
│   │   └── organisms/     # Organism component tests
│   ├── hooks/             # Hook tests
│   ├── services/          # Service tests
│   ├── utils/             # Utility function tests
│   └── store/             # Store tests
├── integration/            # Integration tests
│   ├── features/          # Feature integration tests
│   │   ├── auth-flow.test.ts
│   │   ├── project-workflow.test.ts
│   │   └── profile-flow.test.ts
│   ├── api/               # API integration tests
│   └── navigation/        # Navigation integration tests
├── e2e/                   # End-to-end tests
│   ├── maestro/           # Maestro YAML flows
│   │   ├── auth-flow.yaml
│   │   ├── project-flow.yaml
│   │   └── profile-flow.yaml
│   ├── detox/             # Detox native tests
│   │   ├── auth.spec.ts
│   │   ├── projects.spec.ts
│   │   └── profile.spec.ts
│   └── playwright/        # Web E2E tests (if applicable)
├── setup/                 # Test configuration
│   ├── jest.setup.ts      # Jest global setup
│   ├── test-utils.tsx     # Test utilities and helpers
│   ├── mocks/             # Mock implementations
│   │   ├── api.ts         # API mocks
│   │   ├── navigation.ts  # Navigation mocks
│   │   ├── storage.ts     # Storage mocks
│   │   └── third-party.ts # Third-party service mocks
│   └── fixtures/          # Test data fixtures
│       ├── users.ts       # User test data
│       ├── projects.ts    # Project test data
│       └── profile.ts     # Profile test data
└── coverage/               # Test coverage reports
    ├── lcov-report/        # LCOV coverage report
    ├── html-report/        # HTML coverage report
    └── coverage.json       # Coverage data
```

---

## 🏗️ **File Naming Conventions**

### **React Components (PascalCase)**

```
Button.tsx, ProjectCard.tsx, UserList.tsx, DashboardScreen.tsx
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

1. **NativeWind/Tailwind CSS** - Primary styling method
2. **React Native StyleSheet** - Fallback for unavailable utilities
3. **Inline styles** - Only for dynamic values

### **Styling Examples**

```typescript
// ✅ PREFERRED: NativeWind classes
<View className="flex-1 bg-white p-4 rounded-lg shadow-sm">
  <Text className="text-lg font-bold text-gray-900 mb-2">
    Title
  </Text>
  <View className="flex-row items-center gap-3">
    <Button className="bg-blue-500 hover:bg-blue-600 px-4 py-2 rounded-lg" />
  </View>
</View>

// ✅ ACCEPTABLE: StyleSheet fallback for complex layouts
const styles = StyleSheet.create({
  complexLayout: {
    transform: [{ rotate: '45deg' }, { scale: 1.2 }],
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 8,
  },
});

// ✅ ACCEPTABLE: Inline styles for dynamic values
<View style={{ width: dynamicWidth, height: dynamicHeight }}>
  <Text className="text-center">Dynamic content</Text>
</View>

// ✅ CONDITIONAL STYLING: Use template literals for variants
<View className={`p-4 rounded-lg ${
  variant === 'primary' ? 'bg-blue-500' :
  variant === 'secondary' ? 'bg-gray-500' :
  'bg-white'
}`}>
  <Text className={`font-bold ${
    variant === 'primary' ? 'text-white' :
    variant === 'secondary' ? 'text-white' :
    'text-gray-900'
  }`}>
    Button Text
  </Text>
</View>
```

---

## 🔧 **Development Tools & Scripts**

### **Package.json Scripts**

```json
{
  "scripts": {
    "start": "expo start",
    "android": "expo start --android",
    "ios": "expo start --ios",
    "web": "expo start --web",
    "storybook": "cross-env STORYBOOK_ENABLED=true expo start",
    "storybook:android": "cross-env STORYBOOK_ENABLED=true expo start --android",
    "storybook:ios": "cross-env STORYBOOK_ENABLED=true expo start --ios",
    "build:android": "eas build --platform android",
    "build:ios": "eas build --platform ios",
    "build:web": "expo export --platform web",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:e2e": "detox test -c ios.sim.debug",
    "lint": "eslint . --ext .ts,.tsx",
    "lint:fix": "eslint . --ext .ts,.tsx --fix",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "type-check": "tsc --noEmit",
    "clean": "expo r -c",
    "reset:module": "rm -rf node_modules && rm -rf .expo && npm install --force",
    "reset:module:ios": "cd ios && rm -rf Pods && rm -rf build && cd .. && npx pod-install",
    "reset:module:android": "cd android && ./gradlew clean && cd ..",
    "prebuild:clean": "rm -rf .expo && rm -rf ios/build && rm -rf android/build"
  }
}
```

### **Development Tools**

- **ESLint** - Code quality and consistency
- **Prettier** - Code formatting
- **TypeScript** - Type safety
- **Husky** - Git hooks
- **lint-staged** - Pre-commit linting
- **Storybook** - Component development
- **Jest** - Testing framework
- **Detox** - E2E testing
- **Maestro** - Mobile testing flows

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
- **Cross-platform testing**

---

## 🚀 **Getting Started for New Developers**

1. **Clone Repository** - Get the latest code
2. **Install Dependencies** - Run `npm install`
3. **Environment Setup** - Configure environment variables
4. **Run Development Server** - Start with `npm start`
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

_This structure follows modern React Native best practices and is designed for scalability, maintainability, and team collaboration. Adapt as needed for your specific requirements._
