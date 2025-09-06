// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Test contract for Solidity
contract TestContract {
    // Bad formatting
    mapping(address => uint256) public balances;
    mapping(address => bool) public isWhitelisted;
    
    address public owner;
    uint256 public totalSupply;
    
    // Events
    event Transfer(address indexed from,address indexed to,uint256 value);
    event WhitelistAdded(address indexed account);
    
    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
    
    modifier onlyWhitelisted() {
        require(isWhitelisted[msg.sender], "Not whitelisted");
        _;
    }
    
    constructor() {
        owner = msg.sender;
        totalSupply = 1000000;
    }
    
    // Functions
    function transfer(address to, uint256 amount) public onlyWhitelisted {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(to != address(0), "Invalid address");
        
        balances[msg.sender] -= amount;
        balances[to] += amount;
        
        emit Transfer(msg.sender, to, amount);
    }
    
    function addToWhitelist(address account) public onlyOwner {
        require(account != address(0), "Invalid address");
        require(!isWhitelisted[account], "Already whitelisted");
        
        isWhitelisted[account] = true;
        emit WhitelistAdded(account);
    }
    
    // Unused function
    function unusedFunction() public pure returns (uint256) {
        return 42;
    }
}
