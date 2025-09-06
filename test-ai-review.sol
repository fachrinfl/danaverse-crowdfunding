// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Test file for AI Code Review - Solidity FIXED VERSION
// This file demonstrates proper Solidity patterns following DanaVerse standards

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

// ✅ Fixed: Using OpenZeppelin security patterns
contract TestContract is ReentrancyGuard, Ownable, Pausable {
    using SafeERC20 for IERC20;
    
    // ✅ Fixed: Proper state variable declarations
    uint256 public value;
    uint256 public maxSupply;
    mapping(address => uint256) public balances;
    
    // ✅ Fixed: Events for important state changes
    event ValueUpdated(uint256 indexed oldValue, uint256 indexed newValue);
    event FundsDeposited(address indexed user, uint256 amount);
    event FundsWithdrawn(address indexed user, uint256 amount);
    event TokensTransferred(address indexed token, address indexed to, uint256 amount);
    
    // ✅ Fixed: Constructor with proper initialization
    constructor(uint256 _maxSupply) {
        maxSupply = _maxSupply;
        value = 0;
    }
    
    // ✅ Fixed: Proper access control with onlyOwner modifier
    function withdrawFunds() external onlyOwner nonReentrant {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");
        
        (bool success, ) = payable(owner()).call{value: balance}("");
        require(success, "Transfer failed");
        
        emit FundsWithdrawn(owner(), balance);
    }
    
    // ✅ Fixed: External payable function with reentrancy protection
    function deposit() external payable whenNotPaused nonReentrant {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        
        balances[msg.sender] += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }
    
    // ✅ Fixed: Using memory for temporary variables (gas optimization)
    function processData(uint256[] memory data) external pure returns (uint256[] memory) {
        uint256[] memory result = new uint256[](data.length);
        
        for (uint256 i = 0; i < data.length; i++) {
            result[i] = data[i] * 2;
        }
        
        return result;
    }
    
    // ✅ Fixed: Emitting events for important state changes
    function updateValue(uint256 newValue) external onlyOwner {
        uint256 oldValue = value;
        value = newValue;
        
        emit ValueUpdated(oldValue, newValue);
    }
    
    // ✅ Fixed: Input validation
    function setValue(uint256 _value) external onlyOwner {
        require(_value <= maxSupply, "Value exceeds maximum supply");
        require(_value != value, "Value is the same as current value");
        
        uint256 oldValue = value;
        value = _value;
        
        emit ValueUpdated(oldValue, _value);
    }
    
    // ✅ Fixed: Using proper randomness (in production, use Chainlink VRF)
    function generateRandomNumber() external view returns (uint256) {
        // Note: This is still not truly random, but better than block.timestamp
        // In production, use Chainlink VRF for true randomness
        return uint256(keccak256(abi.encodePacked(
            block.difficulty,
            block.timestamp,
            msg.sender,
            block.number
        )));
    }
    
    // ✅ Fixed: Proper error handling with SafeERC20
    function transferTokens(address token, address to, uint256 amount) external onlyOwner {
        require(token != address(0), "Invalid token address");
        require(to != address(0), "Invalid recipient address");
        require(amount > 0, "Amount must be greater than 0");
        
        IERC20(token).safeTransfer(to, amount);
        
        emit TokensTransferred(token, to, amount);
    }
    
    // ✅ Fixed: Proper access control (already using onlyOwner from OpenZeppelin)
    function adminFunction() external onlyOwner {
        // Admin function with proper access control
        // Implementation here
    }
    
    // ✅ Fixed: Adding receive function for ETH transfers
    receive() external payable {
        // Handle direct ETH transfers
        balances[msg.sender] += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }
    
    // ✅ Fixed: Adding fallback function
    fallback() external payable {
        // Handle calls to non-existent functions
        revert("Function not found");
    }
    
    // ✅ Fixed: Pause functionality for emergency situations
    function pause() external onlyOwner {
        _pause();
    }
    
    function unpause() external onlyOwner {
        _unpause();
    }
}

// ✅ Fixed: Proper interface definition
interface IERC20Extended is IERC20 {
    function decimals() external view returns (uint8);
    function symbol() external view returns (string memory);
    function name() external view returns (string memory);
}
