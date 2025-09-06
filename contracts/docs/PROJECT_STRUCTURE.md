# ⛓️ DanaVerse Smart Contracts - Solidity Enterprise Project Structure

This documentation defines the **standardized folder structure**, **file purposes**, **naming conventions**, and **architectural patterns** for the DanaVerse smart contracts using **Solidity** with **Foundry** framework and enterprise-grade security practices.

---

## 🎯 **Architecture Principles**

### **Core Design Philosophy**

- **Security First** - Security patterns and best practices throughout
- **Modular Design** - Reusable components and clear separation of concerns
- **Gas Optimization** - Efficient code for cost-effective operations
- **Upgradeability** - Proxy patterns for future improvements
- **Access Control** - Role-based permissions and multi-signature support
- **Event-Driven** - Comprehensive event logging for off-chain integration
- **Testing Coverage** - Extensive testing including fuzz and invariant testing

### **Technology Stack**

- **Solidity 0.8.19+** with latest language features
- **Foundry** for development, testing, and deployment
- **OpenZeppelin** for secure, audited contract libraries
- **Hardhat** (alternative) for additional tooling
- **Slither** for static analysis
- **Echidna** for fuzz testing
- **Mythril** for security analysis

---

## 🏗️ **Root Project Structure**

```
contracts/
├── src/                     # Source contracts
├── test/                    # Test files
├── script/                  # Deployment and utility scripts
├── lib/                     # External dependencies
├── docs/                    # Contract documentation
├── deployments/             # Deployment configurations
├── artifacts/               # Compiled contracts (generated)
├── cache/                   # Foundry cache (generated)
├── out/                     # Build output (generated)
├── foundry.toml             # Foundry configuration
├── remappings.txt           # Import remappings
├── .env.example             # Environment variables template
├── .gitignore               # Git ignore rules
└── README.md                # Project overview
```

---

## 📁 **`src/` – Source Contracts**

**Smart contract source code organized by functionality.**

### **Core Contracts**

```
src/
├── core/                    # Core business logic contracts
│   ├── Crowdfunding.sol    # Main crowdfunding contract
│   ├── ProjectFactory.sol  # Project creation factory
│   ├── FundingPool.sol     # Funding pool management
│   └── Escrow.sol          # Escrow for project funds
├── governance/              # Governance and voting
│   ├── DAO.sol             # Decentralized autonomous organization
│   ├── Voting.sol          # Voting mechanism
│   ├── Proposal.sol        # Proposal management
│   └── Treasury.sol        # Treasury management
├── token/                   # Token contracts
│   ├── DanaToken.sol       # Main utility token
│   ├── ProjectToken.sol    # Project-specific tokens
│   ├── RewardToken.sol     # Reward distribution token
│   └── StakingToken.sol    # Staking mechanism token
├── security/                # Security and access control
│   ├── AccessControl.sol   # Role-based access control
│   ├── MultiSig.sol        # Multi-signature wallet
│   ├── Pausable.sol        # Emergency pause functionality
│   └── ReentrancyGuard.sol # Reentrancy protection
├── oracle/                  # Oracle integrations
│   ├── PriceOracle.sol     # Price feed oracle
│   ├── ProjectOracle.sol   # Project verification oracle
│   └── WeatherOracle.sol   # Weather data oracle (for specific projects)
├── payment/                 # Payment processing
│   ├── PaymentProcessor.sol # Payment processing logic
│   ├── StablecoinHandler.sol # Stablecoin integration
│   └── CryptoPayment.sol   # Cryptocurrency payments
├── insurance/               # Insurance mechanisms
│   ├── ProjectInsurance.sol # Project failure insurance
│   ├── RefundInsurance.sol # Refund protection
│   └── DisputeResolution.sol # Dispute resolution mechanism
├── analytics/               # Analytics and reporting
│   ├── MetricsCollector.sol # Metrics collection
│   ├── Reporting.sol       # Reporting functionality
│   └── Analytics.sol       # Analytics aggregation
└── utils/                   # Utility contracts
    ├── Math.sol            # Mathematical utilities
    ├── Strings.sol         # String utilities
    ├── Address.sol         # Address utilities
    └── SafeMath.sol        # Safe math operations
```

### **Interface Definitions**

```
src/
├── interfaces/              # Contract interfaces
│   ├── ICrowdfunding.sol   # Crowdfunding interface
│   ├── IProject.sol        # Project interface
│   ├── IERC20Extended.sol  # Extended ERC20 interface
│   ├── IERC721Extended.sol # Extended ERC721 interface
│   ├── IOracle.sol         # Oracle interface
│   ├── IPaymentProcessor.sol # Payment processor interface
│   ├── IInsurance.sol      # Insurance interface
│   └── IAnalytics.sol      # Analytics interface
├── libraries/               # Reusable libraries
│   ├── CrowdfundingLib.sol # Crowdfunding utilities
│   ├── ProjectLib.sol      # Project management utilities
│   ├── PaymentLib.sol      # Payment processing utilities
│   ├── ValidationLib.sol   # Validation utilities
│   └── MathLib.sol         # Mathematical libraries
└── types/                   # Custom types and structs
    ├── ProjectTypes.sol    # Project-related types
    ├── PaymentTypes.sol    # Payment-related types
    ├── GovernanceTypes.sol # Governance-related types
    └── CommonTypes.sol     # Common types
```

---

## 📁 **`test/` – Test Files**

**Comprehensive testing strategy with multiple test types.**

```
test/
├── unit/                    # Unit tests
│   ├── core/               # Core contract tests
│   │   ├── Crowdfunding.t.sol
│   │   ├── ProjectFactory.t.sol
│   │   ├── FundingPool.t.sol
│   │   └── Escrow.t.sol
│   ├── governance/         # Governance tests
│   │   ├── DAO.t.sol
│   │   ├── Voting.t.sol
│   │   └── Proposal.t.sol
│   ├── token/              # Token tests
│   │   ├── DanaToken.t.sol
│   │   ├── ProjectToken.t.sol
│   │   └── RewardToken.t.sol
│   ├── security/           # Security tests
│   │   ├── AccessControl.t.sol
│   │   ├── MultiSig.t.sol
│   │   └── ReentrancyGuard.t.sol
│   ├── payment/            # Payment tests
│   │   ├── PaymentProcessor.t.sol
│   │   └── StablecoinHandler.t.sol
│   └── utils/              # Utility tests
│       ├── Math.t.sol
│       └── ValidationLib.t.sol
├── integration/            # Integration tests
│   ├── CrowdfundingFlow.t.sol # End-to-end crowdfunding flow
│   ├── PaymentFlow.t.sol   # Payment processing flow
│   ├── GovernanceFlow.t.sol # Governance decision flow
│   └── InsuranceFlow.t.sol # Insurance claim flow
├── fuzz/                   # Fuzz tests
│   ├── CrowdfundingFuzz.t.sol
│   ├── PaymentFuzz.t.sol
│   └── GovernanceFuzz.t.sol
├── invariant/              # Invariant tests
│   ├── CrowdfundingInvariant.t.sol
│   ├── PaymentInvariant.t.sol
│   └── GovernanceInvariant.t.sol
├── gas/                    # Gas optimization tests
│   ├── GasBenchmarks.t.sol
│   └── GasOptimization.t.sol
├── security/               # Security-specific tests
│   ├── ReentrancyTests.t.sol
│   ├── AccessControlTests.t.sol
│   ├── IntegerOverflowTests.t.sol
│   └── FrontRunningTests.t.sol
├── fixtures/               # Test fixtures and helpers
│   ├── TestHelpers.sol     # Common test utilities
│   ├── MockContracts.sol   # Mock contract implementations
│   ├── TestData.sol        # Test data constants
│   └── DeploymentHelpers.sol # Deployment utilities
└── utils/                  # Test utilities
    ├── Console.sol         # Console logging
    ├── TestUtils.sol       # Test utility functions
    └── Assertions.sol      # Custom assertions
```

---

## 📁 **`script/` – Deployment Scripts**

**Deployment and utility scripts for different networks.**

```
script/
├── deploy/                  # Deployment scripts
│   ├── DeployCore.s.sol    # Core contracts deployment
│   ├── DeployGovernance.s.sol # Governance contracts deployment
│   ├── DeployTokens.s.sol  # Token contracts deployment
│   ├── DeploySecurity.s.sol # Security contracts deployment
│   ├── DeployOracle.s.sol  # Oracle contracts deployment
│   └── DeployAll.s.sol     # Full deployment script
├── upgrade/                 # Upgrade scripts
│   ├── UpgradeCrowdfunding.s.sol # Crowdfunding contract upgrade
│   ├── UpgradeGovernance.s.sol # Governance contract upgrade
│   └── UpgradeTokens.s.sol # Token contract upgrades
├── maintenance/             # Maintenance scripts
│   ├── PauseContracts.s.sol # Emergency pause script
│   ├── UnpauseContracts.s.sol # Resume operations script
│   ├── UpdateOracles.s.sol # Oracle update script
│   └── EmergencyWithdraw.s.sol # Emergency withdrawal script
├── verification/            # Contract verification
│   ├── VerifyContracts.s.sol # Contract verification script
│   └── VerifyProxy.s.sol   # Proxy verification script
├── testing/                 # Testing utilities
│   ├── SeedTestData.s.sol  # Seed test data script
│   ├── SimulateAttacks.s.sol # Attack simulation script
│   └── LoadTest.s.sol      # Load testing script
└── utils/                   # Utility scripts
    ├── GetContractInfo.s.sol # Contract information retrieval
    ├── CheckBalances.s.sol  # Balance checking script
    └── GenerateABI.s.sol   # ABI generation script
```

---

## 📁 **`lib/` – External Dependencies**

**External libraries and dependencies managed by Foundry.**

```
lib/
├── forge-std/               # Foundry standard library
├── openzeppelin-contracts/  # OpenZeppelin contracts
├── solmate/                 # Solmate contracts
├── chainlink/               # Chainlink oracles
├── uniswap/                 # Uniswap contracts
├── aave/                    # Aave protocol contracts
├── compound/                # Compound protocol contracts
└── custom/                  # Custom dependencies
    ├── custom-oracle/       # Custom oracle implementation
    └── custom-token/        # Custom token implementation
```

---

## 📁 **`deployments/` – Deployment Configurations**

**Network-specific deployment configurations and artifacts.**

```
deployments/
├── mainnet/                 # Mainnet deployment
│   ├── addresses.json      # Deployed contract addresses
│   ├── abis/               # Contract ABIs
│   ├── verification/       # Verification artifacts
│   └── gas-reports/        # Gas usage reports
├── sepolia/                # Sepolia testnet deployment
│   ├── addresses.json
│   ├── abis/
│   ├── verification/
│   └── gas-reports/
├── goerli/                 # Goerli testnet deployment
│   ├── addresses.json
│   ├── abis/
│   ├── verification/
│   └── gas-reports/
├── local/                  # Local development deployment
│   ├── addresses.json
│   ├── abis/
│   └── gas-reports/
└── scripts/                # Deployment scripts
    ├── deploy-mainnet.sh   # Mainnet deployment script
    ├── deploy-sepolia.sh   # Sepolia deployment script
    └── deploy-local.sh     # Local deployment script
```

---

## 🏗️ **File Naming Conventions**

### **Contract Files (PascalCase)**

```
Crowdfunding.sol, ProjectFactory.sol, DanaToken.sol
```

### **Test Files (PascalCase with .t.sol suffix)**

```
Crowdfunding.t.sol, ProjectFactory.t.sol, DanaToken.t.sol
```

### **Script Files (PascalCase with .s.sol suffix)**

```
DeployCore.s.sol, UpgradeCrowdfunding.s.sol, VerifyContracts.s.sol
```

### **Interface Files (PascalCase with I prefix)**

```
ICrowdfunding.sol, IProject.sol, IERC20Extended.sol
```

### **Library Files (PascalCase with Lib suffix)**

```
CrowdfundingLib.sol, ProjectLib.sol, PaymentLib.sol
```

### **Type Files (PascalCase with Types suffix)**

```
ProjectTypes.sol, PaymentTypes.sol, GovernanceTypes.sol
```

---

## 🎨 **Code Organization Patterns**

### **Contract Structure**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "../interfaces/ICrowdfunding.sol";
import "../libraries/CrowdfundingLib.sol";
import "../types/ProjectTypes.sol";

/**
 * @title Crowdfunding
 * @dev Main crowdfunding contract for DanaVerse platform
 * @author DanaVerse Team
 */
contract Crowdfunding is ICrowdfunding, ReentrancyGuard, Pausable, Ownable {
    using Counters for Counters.Counter;
    using CrowdfundingLib for ProjectTypes.Project;

    // State variables
    Counters.Counter private _projectIds;
    mapping(uint256 => ProjectTypes.Project) public projects;
    
    // Events
    event ProjectCreated(uint256 indexed projectId, address indexed creator, string title);
    event ProjectFunded(uint256 indexed projectId, address indexed funder, uint256 amount);
    
    // Modifiers
    modifier onlyProjectCreator(uint256 _projectId) {
        require(projects[_projectId].creator == msg.sender, "Not the project creator");
        _;
    }
    
    modifier projectExists(uint256 _projectId) {
        require(_projectId < _projectIds.current(), "Project does not exist");
        _;
    }
    
    // Functions
    function createProject(
        string memory _title,
        string memory _description,
        uint256 _targetAmount,
        uint256 _deadline
    ) external override whenNotPaused returns (uint256) {
        // Implementation
    }
    
    function fundProject(uint256 _projectId) 
        external 
        payable 
        override 
        nonReentrant 
        whenNotPaused 
        projectExists(_projectId) 
    {
        // Implementation
    }
}
```

### **Interface Definition**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../types/ProjectTypes.sol";

/**
 * @title ICrowdfunding
 * @dev Interface for the main crowdfunding contract
 */
interface ICrowdfunding {
    // Events
    event ProjectCreated(uint256 indexed projectId, address indexed creator, string title);
    event ProjectFunded(uint256 indexed projectId, address indexed funder, uint256 amount);
    
    // Functions
    function createProject(
        string memory _title,
        string memory _description,
        uint256 _targetAmount,
        uint256 _deadline
    ) external returns (uint256);
    
    function fundProject(uint256 _projectId) external payable;
    
    function getProject(uint256 _projectId) external view returns (ProjectTypes.Project memory);
}
```

### **Library Implementation**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../types/ProjectTypes.sol";

/**
 * @title CrowdfundingLib
 * @dev Library for crowdfunding utilities
 */
library CrowdfundingLib {
    using ProjectTypes for ProjectTypes.Project;
    
    /**
     * @dev Check if project is fully funded
     */
    function isFullyFunded(ProjectTypes.Project storage project) internal view returns (bool) {
        return project.currentAmount >= project.targetAmount;
    }
    
    /**
     * @dev Calculate funding progress percentage
     */
    function getFundingProgress(ProjectTypes.Project storage project) internal view returns (uint256) {
        if (project.targetAmount == 0) return 0;
        return (project.currentAmount * 100) / project.targetAmount;
    }
}
```

---

## 🧪 **Testing Patterns**

### **Unit Test Structure**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/core/Crowdfunding.sol";
import "../test/fixtures/TestHelpers.sol";

contract CrowdfundingTest is Test {
    Crowdfunding public crowdfunding;
    TestHelpers public testHelpers;
    
    address public owner;
    address public creator;
    address public funder;
    
    event ProjectCreated(uint256 indexed projectId, address indexed creator, string title);
    
    function setUp() public {
        owner = makeAddr("owner");
        creator = makeAddr("creator");
        funder = makeAddr("funder");
        
        vm.prank(owner);
        crowdfunding = new Crowdfunding();
        
        testHelpers = new TestHelpers();
    }
    
    function testCreateProject() public {
        vm.prank(creator);
        uint256 projectId = crowdfunding.createProject(
            "Test Project",
            "A test crowdfunding project",
            10 ether,
            block.timestamp + 30 days
        );
        
        assertEq(projectId, 0);
        
        (uint256 id, address projectCreator, string memory title, , , , , , ) = crowdfunding.getProject(projectId);
        assertEq(id, 0);
        assertEq(projectCreator, creator);
        assertEq(title, "Test Project");
    }
    
    function testFundProject() public {
        // Create project first
        vm.prank(creator);
        uint256 projectId = crowdfunding.createProject(
            "Test Project",
            "A test project",
            10 ether,
            block.timestamp + 30 days
        );
        
        // Fund the project
        vm.deal(funder, 5 ether);
        vm.prank(funder);
        crowdfunding.fundProject{value: 5 ether}(projectId);
        
        (, , , , uint256 currentAmount, , , , ) = crowdfunding.getProject(projectId);
        assertEq(currentAmount, 5 ether);
    }
    
    function testFailCreateProjectWithZeroTarget() public {
        vm.prank(creator);
        crowdfunding.createProject(
            "Test Project",
            "A test project",
            0,
            block.timestamp + 30 days
        );
    }
}
```

### **Fuzz Testing**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/core/Crowdfunding.sol";

contract CrowdfundingFuzzTest is Test {
    Crowdfunding public crowdfunding;
    
    function setUp() public {
        crowdfunding = new Crowdfunding();
    }
    
    function testFuzzCreateProject(
        string memory title,
        string memory description,
        uint256 targetAmount,
        uint256 deadline
    ) public {
        vm.assume(targetAmount > 0);
        vm.assume(deadline > block.timestamp);
        vm.assume(bytes(title).length > 0);
        vm.assume(bytes(description).length > 0);
        
        uint256 projectId = crowdfunding.createProject(
            title,
            description,
            targetAmount,
            deadline
        );
        
        assertTrue(projectId >= 0);
    }
}
```

---

## 🔧 **Development Tools & Scripts**

### **Foundry Configuration (foundry.toml)**

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
solc = "0.8.19"
optimizer = true
optimizer_runs = 200
via_ir = false
verbosity = 1
fuzz = { runs = 1000 }
invariant = { runs = 256, depth = 15, fail_on_revert = false, call_override = false }

[profile.ci]
fuzz = { runs = 10000 }
invariant = { runs = 1000, depth = 20 }

[profile.lite]
fuzz = { runs = 100 }
invariant = { runs = 10, depth = 5 }
```

### **Makefile**

```makefile
.PHONY: build test deploy clean

# Build contracts
build:
	forge build

# Run tests
test:
	forge test

# Run tests with gas reporting
test-gas:
	forge test --gas-report

# Run fuzz tests
test-fuzz:
	forge test --match-contract Fuzz

# Run invariant tests
test-invariant:
	forge test --match-contract Invariant

# Deploy to local network
deploy-local:
	forge script script/deploy/DeployAll.s.sol --rpc-url http://localhost:8545 --broadcast

# Deploy to Sepolia
deploy-sepolia:
	forge script script/deploy/DeployAll.s.sol --rpc-url sepolia --broadcast --verify

# Clean build artifacts
clean:
	forge clean

# Install dependencies
install:
	forge install

# Update dependencies
update:
	forge update

# Format code
fmt:
	forge fmt

# Lint code
lint:
	forge fmt --check

# Generate documentation
docs:
	forge doc --build

# Security analysis
security:
	slither .
```

---

## 📚 **Documentation Standards**

### **Required Documentation**

- **README.md** - Project overview and setup
- **CONTRIBUTING.md** - Contribution guidelines
- **CHANGELOG.md** - Version history
- **docs/architecture.md** - Architecture documentation
- **docs/security.md** - Security considerations
- **docs/deployment.md** - Deployment instructions
- **docs/audit.md** - Audit reports and findings

### **Code Documentation**

- **NatSpec comments** for all public functions and events
- **README files** for each major contract
- **Architecture decision records (ADRs)**
- **Security analysis reports**

---

## 🔄 **Development Workflow**

### **Git Workflow**

- **Feature branches** for new development
- **Pull requests** with code review
- **Conventional commit messages**
- **Automated testing and security checks**

### **Quality Assurance**

- **Automated testing** on all changes
- **Code coverage** requirements (90%+)
- **Gas optimization** reviews
- **Security analysis** with multiple tools
- **Formal verification** for critical functions

---

## 🚀 **Getting Started for New Developers**

1. **Install Foundry** - Latest version with forge, cast, anvil
2. **Clone Repository** - Get the latest code
3. **Install Dependencies** - Run `forge install`
4. **Setup Environment** - Configure environment variables
5. **Run Tests** - Execute `forge test`
6. **Read Documentation** - Understand contract architecture
7. **Follow Conventions** - Adhere to Solidity best practices
8. **Write Tests** - Include comprehensive tests for new contracts
9. **Security Review** - Ensure security best practices

---

## 🆘 **Support & Resources**

- **Project Maintainer** - Contact for questions and guidance
- **Documentation** - Keep documentation updated
- **Code Examples** - Check existing contracts for patterns
- **Security Audits** - Regular security reviews and audits

---

_This structure follows modern Solidity best practices and is designed for security, maintainability, and team collaboration. Adapt as needed for your specific requirements._
