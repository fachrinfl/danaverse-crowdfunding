// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Crowdfunding
 * @dev A decentralized crowdfunding platform contract
 */
contract Crowdfunding is ReentrancyGuard, Pausable, Ownable {
    constructor() Ownable(msg.sender) {}

    // Structs
    struct Project {
        uint256 id;
        address creator;
        string title;
        string description;
        uint256 targetAmount;
        uint256 currentAmount;
        uint256 deadline;
        bool isActive;
        bool isCompleted;
        mapping(address => uint256) contributions;
    }

    // State variables
    uint256 private _projectIds;
    mapping(uint256 => Project) public projects;
    uint256 public totalProjects;
    uint256 public platformFeePercentage = 2; // 2% platform fee

    // Events
    event ProjectCreated(
        uint256 indexed projectId,
        address indexed creator,
        string title,
        uint256 targetAmount,
        uint256 deadline
    );

    event ContributionMade(
        uint256 indexed projectId,
        address indexed contributor,
        uint256 amount
    );

    event ProjectCompleted(uint256 indexed projectId, uint256 totalRaised);
    event ProjectCancelled(uint256 indexed projectId);
    event FundsWithdrawn(uint256 indexed projectId, address indexed creator, uint256 amount);

    // Modifiers
    modifier onlyProjectCreator(uint256 _projectId) {
        require(projects[_projectId].creator == msg.sender, "Not the project creator");
        _;
    }

    modifier projectExists(uint256 _projectId) {
        require(_projectId < _projectIds, "Project does not exist");
        _;
    }

    modifier projectActive(uint256 _projectId) {
        require(projects[_projectId].isActive, "Project is not active");
        _;
    }


    /**
     * @dev Create a new crowdfunding project
     * @param _title Project title
     * @param _description Project description
     * @param _targetAmount Target funding amount in wei
     * @param _deadline Project deadline timestamp
     */
    function createProject(
        string memory _title,
        string memory _description,
        uint256 _targetAmount,
        uint256 _deadline
    ) external whenNotPaused returns (uint256) {
        require(_targetAmount > 0, "Target amount must be greater than 0");
        require(_deadline > block.timestamp, "Deadline must be in the future");
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_description).length > 0, "Description cannot be empty");

        uint256 projectId = _projectIds;
        _projectIds++;

        Project storage project = projects[projectId];
        project.id = projectId;
        project.creator = msg.sender;
        project.title = _title;
        project.description = _description;
        project.targetAmount = _targetAmount;
        project.currentAmount = 0;
        project.deadline = _deadline;
        project.isActive = true;
        project.isCompleted = false;

        totalProjects++;

        emit ProjectCreated(projectId, msg.sender, _title, _targetAmount, _deadline);

        return projectId;
    }

    /**
     * @dev Contribute to a project
     * @param _projectId Project ID to contribute to
     */
    function contribute(uint256 _projectId)
        external
        payable
        nonReentrant
        whenNotPaused
        projectExists(_projectId)
        projectActive(_projectId)
    {
        Project storage project = projects[_projectId];
        
        require(block.timestamp <= project.deadline, "Project deadline has passed");
        require(msg.value > 0, "Contribution must be greater than 0");

        project.contributions[msg.sender] += msg.value;
        project.currentAmount += msg.value;

        emit ContributionMade(_projectId, msg.sender, msg.value);

        // Check if project is fully funded
        if (project.currentAmount >= project.targetAmount) {
            project.isCompleted = true;
            project.isActive = false;
            emit ProjectCompleted(_projectId, project.currentAmount);
        }
    }

    /**
     * @dev Withdraw funds for a completed project
     * @param _projectId Project ID to withdraw funds from
     */
    function withdrawFunds(uint256 _projectId)
        external
        nonReentrant
        onlyProjectCreator(_projectId)
        projectExists(_projectId)
    {
        Project storage project = projects[_projectId];
        
        require(project.isCompleted, "Project is not completed");
        require(project.currentAmount > 0, "No funds to withdraw");

        uint256 totalAmount = project.currentAmount;
        uint256 platformFee = (totalAmount * platformFeePercentage) / 100;
        uint256 creatorAmount = totalAmount - platformFee;

        project.currentAmount = 0;

        // Transfer funds to creator
        payable(project.creator).transfer(creatorAmount);
        
        // Transfer platform fee to owner
        if (platformFee > 0) {
            payable(owner()).transfer(platformFee);
        }

        emit FundsWithdrawn(_projectId, project.creator, creatorAmount);
    }

    /**
     * @dev Cancel a project (only if not completed and deadline passed)
     * @param _projectId Project ID to cancel
     */
    function cancelProject(uint256 _projectId)
        external
        onlyProjectCreator(_projectId)
        projectExists(_projectId)
    {
        Project storage project = projects[_projectId];
        
        require(project.isActive, "Project is not active");
        require(block.timestamp > project.deadline, "Project deadline has not passed");
        require(project.currentAmount < project.targetAmount, "Project is fully funded");

        project.isActive = false;

        emit ProjectCancelled(_projectId);
    }

    /**
     * @dev Refund contribution for a cancelled project
     * @param _projectId Project ID to get refund from
     */
    function refund(uint256 _projectId)
        external
        nonReentrant
        projectExists(_projectId)
    {
        Project storage project = projects[_projectId];
        
        require(!project.isActive, "Project is still active");
        require(project.currentAmount < project.targetAmount, "Project was completed");
        require(project.contributions[msg.sender] > 0, "No contribution to refund");

        uint256 refundAmount = project.contributions[msg.sender];
        project.contributions[msg.sender] = 0;
        project.currentAmount -= refundAmount;

        payable(msg.sender).transfer(refundAmount);
    }

    /**
     * @dev Get project details
     * @param _projectId Project ID
     */
    function getProject(uint256 _projectId)
        external
        view
        projectExists(_projectId)
        returns (
            uint256 id,
            address creator,
            string memory title,
            string memory description,
            uint256 targetAmount,
            uint256 currentAmount,
            uint256 deadline,
            bool isActive,
            bool isCompleted
        )
    {
        Project storage project = projects[_projectId];
        return (
            project.id,
            project.creator,
            project.title,
            project.description,
            project.targetAmount,
            project.currentAmount,
            project.deadline,
            project.isActive,
            project.isCompleted
        );
    }

    /**
     * @dev Get user's contribution to a project
     * @param _projectId Project ID
     * @param _contributor Contributor address
     */
    function getContribution(uint256 _projectId, address _contributor)
        external
        view
        projectExists(_projectId)
        returns (uint256)
    {
        return projects[_projectId].contributions[_contributor];
    }

    /**
     * @dev Update platform fee percentage (only owner)
     * @param _feePercentage New fee percentage (0-100)
     */
    function updatePlatformFee(uint256 _feePercentage) external onlyOwner {
        require(_feePercentage <= 10, "Fee cannot exceed 10%");
        platformFeePercentage = _feePercentage;
    }

    /**
     * @dev Pause the contract (only owner)
     */
    function pause() external onlyOwner {
        _pause();
    }

    /**
     * @dev Unpause the contract (only owner)
     */
    function unpause() external onlyOwner {
        _unpause();
    }

    /**
     * @dev Get total number of projects
     */
    function getTotalProjects() external view returns (uint256) {
        return totalProjects;
    }
}
