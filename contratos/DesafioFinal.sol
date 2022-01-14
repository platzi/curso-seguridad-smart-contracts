// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Desafio{

    address owner;
    mapping(address => uint) balances;

    constructor() {
        owner = msg.sender;
    }

    function mint(uint amount) public {
        require(owner == msg.sender, "El usuario no es el owner.");
        balances[msg.sender] += amount;
    }

    function depositar() public payable {
        balances[msg.sender] += msg.value;
    }

    function retirar() public {
        require(balances[msg.sender] > 0);
        uint monto = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool resultado, ) = msg.sender.call{value:monto, gas: 1000000}("");
        if (!resultado) revert();
    }

}
