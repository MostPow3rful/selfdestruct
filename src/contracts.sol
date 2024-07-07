// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

contract A {
    constructor() payable {}

    function start(address payable _addr) external {
        selfdestruct(_addr);
    }
}

contract B {}

contract C {}

contract D {}