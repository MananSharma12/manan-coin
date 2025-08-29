// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MananCoin is ERC20 {
    constructor() ERC20("Manan", "MAN") {
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}
