// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

// import "../contracts/BasicToken.sol";

contract ContractScript is Script {
    // BasicToken basicToken;

    function setUp() public {}

    function run(bytes memory performData) public {
        bytes memory args = abi.encode(
            2**256 - 1,
            108072616621495115728666252674775380663051985687931193103493745074052254330606,
            [[2]]
        );
        // bytes memory s = abi.encodePacked(sigPart, args, msg.sender);
        // console.logBytes(args);

        // console.logBytes(sigPart);

        // assembly {
        //     let szLoc := 0xc0
        //     let ptr := mload(0x40)
        //     mstore(ptr, sload(sigPart.slot))
        //     let sz := mload(szLoc)
        //     // prettier-ignore
        //     for { let i := 0 } lt(i, sz) { i := add(i, 0x20) } {
        //         mstore(add(ptr, add(i, 0x04)), mload(add(szLoc, add(i, 0x20))))
        //     }
        //     mstore(add(ptr, add(sz, 0x04)), shl(0x60, caller()))

        //     mstore(0x40, add(sz, 0x04))
        // }
    }
}
