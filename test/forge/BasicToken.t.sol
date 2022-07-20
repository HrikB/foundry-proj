//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../contracts/BasicToken.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract BasicTokenTest is Test {
    BasicToken basicToken;
    address constant deployer = 0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84;
    uint256 constant initialBalance = 1000;
    uint256 constant sendAmount = 50;

    function setUp() public {
        basicToken = new BasicToken();
    }

    function testTotalSupply() public {
        vm.broadcast();
        bytes memory b = abi.encodePacked(address(this));
        console.logBytes(b);
        assertEq(basicToken.totalSupply(), initialBalance);
    }

    function testTransfer() public {
        basicToken.transfer(address(1), sendAmount);
        assertEq(basicToken.balanceOf(deployer), initialBalance - sendAmount);
        assertEq(basicToken.balanceOf(address(1)), sendAmount);
    }
}
