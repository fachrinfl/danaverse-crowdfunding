// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Crowdfunding.sol";

contract CrowdfundingTest is Test {
    Crowdfunding public crowdfunding;
    address public owner;
    address public creator;
    address public contributor1;
    address public contributor2;

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

    function setUp() public {
        owner = address(this);
        creator = makeAddr("creator");
        contributor1 = makeAddr("contributor1");
        contributor2 = makeAddr("contributor2");

        crowdfunding = new Crowdfunding();
    }

    function testCreateProject() public {
        string memory title = "Test Project";
        string memory description = "A test crowdfunding project";
        uint256 targetAmount = 10 ether;
        uint256 deadline = block.timestamp + 30 days;

        vm.prank(creator);
        uint256 projectId = crowdfunding.createProject(
            title,
            description,
            targetAmount,
            deadline
        );

        assertEq(projectId, 0);
        assertEq(crowdfunding.getTotalProjects(), 1);

        (
            uint256 id,
            address projectCreator,
            string memory projectTitle,
            string memory projectDescription,
            uint256 projectTargetAmount,
            uint256 currentAmount,
            uint256 projectDeadline,
            bool isActive,
            bool isCompleted
        ) = crowdfunding.getProject(projectId);

        assertEq(id, 0);
        assertEq(projectCreator, creator);
        assertEq(projectTitle, title);
        assertEq(projectDescription, description);
        assertEq(projectTargetAmount, targetAmount);
        assertEq(currentAmount, 0);
        assertEq(projectDeadline, deadline);
        assertTrue(isActive);
        assertFalse(isCompleted);
    }

    function testContribute() public {
        // Create a project first
        vm.prank(creator);
        uint256 projectId = crowdfunding.createProject(
            "Test Project",
            "A test project",
            10 ether,
            block.timestamp + 30 days
        );

        // Contribute to the project
        uint256 contributionAmount = 5 ether;
        vm.deal(contributor1, contributionAmount);
        
        vm.prank(contributor1);
        crowdfunding.contribute{value: contributionAmount}(projectId);

        assertEq(crowdfunding.getContribution(projectId, contributor1), contributionAmount);

        (
            ,,,,,uint256 currentAmount,,,
        ) = crowdfunding.getProject(projectId);
        assertEq(currentAmount, contributionAmount);
    }

    function testProjectCompletion() public {
        // Create a project with low target
        vm.prank(creator);
        uint256 projectId = crowdfunding.createProject(
            "Test Project",
            "A test project",
            1 ether,
            block.timestamp + 30 days
        );

        // Contribute enough to complete the project
        vm.deal(contributor1, 1 ether);
        vm.prank(contributor1);
        crowdfunding.contribute{value: 1 ether}(projectId);

        (
            ,,,,,,,bool isActive,bool isCompleted
        ) = crowdfunding.getProject(projectId);
        assertFalse(isActive);
        assertTrue(isCompleted);
    }

    function testWithdrawFunds() public {
        // Create and fund a project
        vm.prank(creator);
        uint256 projectId = crowdfunding.createProject(
            "Test Project",
            "A test project",
            1 ether,
            block.timestamp + 30 days
        );

        vm.deal(contributor1, 1 ether);
        vm.prank(contributor1);
        crowdfunding.contribute{value: 1 ether}(projectId);

        // Withdraw funds
        uint256 creatorBalanceBefore = creator.balance;
        vm.prank(creator);
        crowdfunding.withdrawFunds(projectId);

        uint256 creatorBalanceAfter = creator.balance;
        uint256 expectedAmount = 1 ether - (1 ether * 2 / 100); // 2% platform fee
        assertEq(creatorBalanceAfter - creatorBalanceBefore, expectedAmount);
    }

    function testCancelProject() public {
        // Create a project
        vm.prank(creator);
        uint256 projectId = crowdfunding.createProject(
            "Test Project",
            "A test project",
            10 ether,
            block.timestamp + 1 days
        );

        // Fast forward past deadline
        vm.warp(block.timestamp + 2 days);

        // Cancel the project
        vm.prank(creator);
        crowdfunding.cancelProject(projectId);

        (
            ,,,,,,,bool isActive,
        ) = crowdfunding.getProject(projectId);
        assertFalse(isActive);
    }

    function testRefund() public {
        // Create a project
        vm.prank(creator);
        uint256 projectId = crowdfunding.createProject(
            "Test Project",
            "A test project",
            10 ether,
            block.timestamp + 1 days
        );

        // Contribute to the project
        uint256 contributionAmount = 2 ether;
        vm.deal(contributor1, contributionAmount);
        vm.prank(contributor1);
        crowdfunding.contribute{value: contributionAmount}(projectId);

        // Fast forward past deadline and cancel
        vm.warp(block.timestamp + 2 days);
        vm.prank(creator);
        crowdfunding.cancelProject(projectId);

        // Get refund
        uint256 balanceBefore = contributor1.balance;
        vm.prank(contributor1);
        crowdfunding.refund(projectId);
        uint256 balanceAfter = contributor1.balance;

        assertEq(balanceAfter - balanceBefore, contributionAmount);
        assertEq(crowdfunding.getContribution(projectId, contributor1), 0);
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

    function testFailCreateProjectWithPastDeadline() public {
        vm.prank(creator);
        crowdfunding.createProject(
            "Test Project",
            "A test project",
            10 ether,
            block.timestamp - 1 days
        );
    }

    function testFailContributeToNonExistentProject() public {
        vm.deal(contributor1, 1 ether);
        vm.prank(contributor1);
        crowdfunding.contribute{value: 1 ether}(999);
    }

    function testFailContributeAfterDeadline() public {
        // Create a project
        vm.prank(creator);
        uint256 projectId = crowdfunding.createProject(
            "Test Project",
            "A test project",
            10 ether,
            block.timestamp + 1 days
        );

        // Fast forward past deadline
        vm.warp(block.timestamp + 2 days);

        // Try to contribute
        vm.deal(contributor1, 1 ether);
        vm.prank(contributor1);
        crowdfunding.contribute{value: 1 ether}(projectId);
    }
}
