// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Test file for AI Code Review - Solidity
// This file contains various Solidity patterns to test AI review functionality

contract TestContract {
    // ❌ Test case: Missing access control (should trigger AI review)
    function withdrawFunds() external {
        // AI should suggest adding access control
        payable(msg.sender).transfer(address(this).balance);
    }
    
    // ❌ Test case: External payable function without reentrancy protection (should trigger AI review)
    function deposit() external payable {
        // AI should suggest adding nonReentrant modifier
        // No reentrancy protection
    }
    
    // ❌ Test case: Using storage instead of memory (should trigger AI review)
    function processData(uint256[] storage data) external {
        // AI should suggest using memory for temporary variables
        for (uint256 i = 0; i < data.length; i++) {
            data[i] = data[i] * 2;
        }
    }
    
    // ❌ Test case: Missing events (should trigger AI review)
    function updateValue(uint256 newValue) external {
        // AI should suggest emitting events for important state changes
        value = newValue;
    }
    
    // ❌ Test case: Hardcoded values (should trigger AI review)
    uint256 public constant MAX_SUPPLY = 1000000; // AI should suggest using configurable values
    
    // ❌ Test case: Missing input validation (should trigger AI review)
    function setValue(uint256 _value) external {
        // AI should suggest adding input validation
        value = _value;
    }
    
    // ❌ Test case: Using block.timestamp for randomness (should trigger AI review)
    function generateRandomNumber() external view returns (uint256) {
        // AI should warn about using block.timestamp for randomness
        return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));
    }
    
    // ❌ Test case: Missing error handling (should trigger AI review)
    function transferTokens(address token, address to, uint256 amount) external {
        // AI should suggest adding error handling
        IERC20(token).transfer(to, amount);
    }
    
    // ❌ Test case: Using msg.sender without proper access control (should trigger AI review)
    function adminFunction() external {
        // AI should suggest adding proper access control
        require(msg.sender == owner, "Not owner"); // This is good, but AI should verify
    }
    
    // State variables
    uint256 public value;
    address public owner;
    
    // ❌ Test case: Missing constructor (should trigger AI review)
    // AI should suggest adding constructor to set initial values
    
    // ❌ Test case: Missing fallback function (should trigger AI review)
    // AI should suggest adding receive/fallback functions if needed
}

// ❌ Test case: Missing interface definition (should trigger AI review)
interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
}
