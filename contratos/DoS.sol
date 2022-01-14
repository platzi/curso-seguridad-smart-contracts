// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DoS {
    address mejorPostor;
    uint mejorApuesta;

    function apostar() public payable {
        require(msg.value > mejorApuesta);

        require(payable(mejorPostor).send(mejorApuesta)); 

        mejorPostor = msg.sender;
        mejorApuesta = msg.value;
    }
}

contract Ataque {
    address direccion;

    receive() external payable {
        revert();
    }
}