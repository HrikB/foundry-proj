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

    // function setUp() public {
    //     basicToken = new BasicToken();
    // }

    function testTotalSupply() public {
        assertEq(basicToken.totalSupply(), initialBalance);
    }

    function testTransfer() public {
        basicToken.transfer(address(1), sendAmount);
        assertEq(basicToken.balanceOf(deployer), initialBalance - sendAmount);
        assertEq(basicToken.balanceOf(address(1)), sendAmount);
    }

    function testAssembly() public {
        assembly {
            let ptr := mload(0x40)
            mstore(
                ptr,
                0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000
            )
            mstore(
                add(ptr, 0x14),
                shl(0x60, 0xbebebebebebebebebebebebebebebebebebebebe)
            )
            mstore(
                add(ptr, 0x28),
                0x5af43d82803e903d91602b57fd5bf30000000000000000000000000000000000
            )
            let instance := create(0, ptr, 0x37)
        }
    }

    function testDeploy() public pure returns (uint256) {
        return 1;
    }
}
