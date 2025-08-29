// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {MananCoin} from "../src/MananCoin.sol";

contract MananCoinScript is Script {
    MananCoin public mananCoin;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        mananCoin = new MananCoin();

        vm.stopBroadcast();
    }
}
