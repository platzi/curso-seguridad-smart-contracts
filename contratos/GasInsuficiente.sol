// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract GasInsuficiente {

    uint llamadasExitosas;

    function incrementarLlamadas(address direccion) public {
        (bool resultado, ) = direccion.call(abi.encodePacked("algunaFuncion()"));

        if (!resultado) revert();

        if (resultado) llamadasExitosas++;
    }

}