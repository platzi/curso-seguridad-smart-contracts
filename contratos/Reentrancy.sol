// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Reentrancy {
    mapping (address => uint) private balances;

    function retirarFondos() public {
        uint monto = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool resultado, ) = msg.sender.call{value:monto}(""); 
        require(resultado);
    }
}

contract Ataque {

    address direccionContratoVulnerable;

    receive() external payable {
        direccionContratoVulnerable.call(abi.encodePacked("retirarFondos()"));
    }

}