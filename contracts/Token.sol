//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Token {
    string public name = "My Token";
    string public symbol = "MYTKN";

    uint256 public totalSupply = 1000000;

    address public owner;

    mapping(address => uint256) balances;

    // The transfer event helps off-chain applications understand
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor() {
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    // A function to transfer tokens.
    function transfer(address to, uint256 amount) external {
        // Check if the transaction sender has enough tokens.
        // If `require`'s first argument avaluates to `false`, the 
        // transaction will revert.
        require(balances[msg.sender] >= amount, "Not enough tokens");

        console.log(
            "Transferring from %s to %s tokens",
            msg.sender,
            to,
            amount
        );

        // Transfer the amount
        balances[msg.sender] -= amount;
        balances[to] += amount;

        // Notify off-chian applications of the transfer.
        emit Transfer(msg.sender, to, amount);
    }

    // Read only function to retrieve the token balance of a given account.
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}