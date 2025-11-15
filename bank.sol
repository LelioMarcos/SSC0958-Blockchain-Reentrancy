// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    mapping(address => uint256) private balances;
    
    // Utilização de modificadores para impedir reentrancy
    
    bool internal lock;
    modifier noReentrant() {
        require(!lock, "Sem reentrancia");
        lock = true;
        _;
        lock = false;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw() external noReentrant {
        uint256 amount = balances[msg.sender];
        require(amount >= 1, "Sem saldo suficiente");
        
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transacao falhou");   
        
        balances[msg.sender] = 0;
        

    }
}
