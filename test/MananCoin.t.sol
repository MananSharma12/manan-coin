// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {MananCoin} from "../src/MananCoin.sol";

contract MananCoinTest is Test {
    MananCoin public mananCoin;
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
https://eth-sepolia.g.alchemy.com/v2/XwzujvPWu7KpuUEHuzunHnzcwF0CYqpo
55732426973be10d3a7006277b8ee8f68c0c92e25c2b9baf09cd7d6558a70755
    function setUp() public {
        mananCoin = new MananCoin();
    }

    function test_Mint() public {
        mananCoin.mint(address(this), 100);
        assertEq(mananCoin.balanceOf(address(this)), 100);

        assertEq(mananCoin.balanceOf(0x87eDE136CDECc6a94e764d244377C7Dd80d4683c), 0);
        mananCoin.mint(0x87eDE136CDECc6a94e764d244377C7Dd80d4683c, 100);
        assertEq(mananCoin.balanceOf(0x87eDE136CDECc6a94e764d244377C7Dd80d4683c), 100);
    }

    function test_Transfer() public {
        mananCoin.mint(address(this), 100);
        mananCoin.transfer(0x87eDE136CDECc6a94e764d244377C7Dd80d4683c, 50);
        assertEq(mananCoin.balanceOf(address(this)), 50);
        assertEq(mananCoin.balanceOf(0x87eDE136CDECc6a94e764d244377C7Dd80d4683c), 50);

        vm.prank(0x87eDE136CDECc6a94e764d244377C7Dd80d4683c);
        mananCoin.transfer(address(this), 50);

        assertEq(mananCoin.balanceOf(address(this)), 100);
        assertEq(mananCoin.balanceOf(0x87eDE136CDECc6a94e764d244377C7Dd80d4683c), 0);
    }

    function test_Approvals() public {
        mananCoin.mint(address(this), 100);
        mananCoin.approve(0x87eDE136CDECc6a94e764d244377C7Dd80d4683c, 50);

        assertEq(mananCoin.allowance(address(this), 0x87eDE136CDECc6a94e764d244377C7Dd80d4683c), 50);

        vm.prank(0x87eDE136CDECc6a94e764d244377C7Dd80d4683c);

        mananCoin.transferFrom(address(this),0x604034FC78917233c4facc9220B600820eF3fC91, 25);

        assertEq(mananCoin.balanceOf(address(this)), 75);
        assertEq(mananCoin.balanceOf(0x87eDE136CDECc6a94e764d244377C7Dd80d4683c), 0);
        assertEq(mananCoin.balanceOf(0x604034FC78917233c4facc9220B600820eF3fC91), 25);
        assertEq(mananCoin.allowance(address(this), 0x87eDE136CDECc6a94e764d244377C7Dd80d4683c), 25);
    }

    function test_Revert_When_FailApprovals() public {
        mananCoin.mint(address(this), 100);
        mananCoin.approve(0x87eDE136CDECc6a94e764d244377C7Dd80d4683c, 10);

        vm.prank(0x87eDE136CDECc6a94e764d244377C7Dd80d4683c);

        vm.expectRevert();
        mananCoin.transferFrom(address(this), 0x604034FC78917233c4facc9220B600820eF3fC91, 20);
    }

    function test_Revert_When_NoBalance() public {
        mananCoin.mint(address(this), 10);

        vm.expectRevert();
        mananCoin.transfer(0x604034FC78917233c4facc9220B600820eF3fC91, 20);
    }

    function test_Emits() public {
        mananCoin.mint(address(this), 30);
        vm.expectEmit(true, true, false, false);
        emit Transfer(address(this), 0x604034FC78917233c4facc9220B600820eF3fC91, 10);

        mananCoin.transfer(0x604034FC78917233c4facc9220B600820eF3fC91, 10);
    }

    function test_Approval() public {
        mananCoin.mint(address(this), 100);

        vm.expectEmit(true, true, false, true);
        emit Approval(address(this), 0x604034FC78917233c4facc9220B600820eF3fC91, 10);

        mananCoin.approve(0x604034FC78917233c4facc9220B600820eF3fC91, 10);

        vm.prank(0x604034FC78917233c4facc9220B600820eF3fC91);

        mananCoin.transferFrom(address(this), 0x87eDE136CDECc6a94e764d244377C7Dd80d4683c, 10);
    }
}
