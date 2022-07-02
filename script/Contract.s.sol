// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../contracts/BasicToken.sol";

contract ContractScript is Script {
    BasicToken basicToken;

    function setUp() public {}

    function run() public {
        vm.broadcast();
        basicToken = new BasicToken(1000);
    }
}
