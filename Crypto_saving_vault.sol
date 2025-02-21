// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SavingsVault {
    mapping(address => uint256) private balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    // Deposit ETH into savings
    function deposit() external payable {
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    // Withdraw all ETH from savings
    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No funds available");

        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        
        emit Withdrawn(msg.sender, amount);
    }

    // Get balance of sender
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    // Get total contract balance
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
