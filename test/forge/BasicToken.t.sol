//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract BasicTokenTest is Test {
    uint256 s = 2**256 - 1;
    bytes sigPart = abi.encodeWithSignature("2");

    function setUp() public {
        // basicToken = new BasicToken();
    }

    function testTotalSupply() public returns (bytes memory) {
        // address instance;
        // bytes memory salt = "1";
        // address implementation = 0x6fd935c3BbbDf664b67e28B14236a66a7588D683;
        //0xad7c5bef00000000000000000000000000
        // bytes memory finalBytes = abi.encodeWithSignature(
        //     "2",
        //     msg.sender,
        //     2**256 - 1,
        //     108072616621495115728666252674775380663051985687931193103493745074052254330606,
        //     [[1]],
        //     100353144005674036033761520340862853472833986710221822167529906140191379021277
        // );
        //0x00a329c0648769a73afac7f9381e08fb43dbea72
        // assembly {
        //     mstore(0x80, sload(s.slot))
        // }
        bytes memory a;
        bytes memory args = abi.encode(
            2**256 - 1,
            108072616621495115728666252674775380663051985687931193103493745074052254330606,
            [[2]]
        );
        uint256 sz = args.length;
        // // bytes memory s = abi.encodePacked(sigPart, args, msg.sender);
        // // console.logBytes(args);
        // // console.logBytes(sigPart);
        assembly {
            let fptr := mload(0x40)
            let ptr := add(fptr, 0x20)
            mstore(ptr, sload(sigPart.slot))
            // prettier-ignore
            for { let i := 0 } lt(i, sz) { i := add(i, 0x20) } {
                mstore(add(ptr, add(i, 0x04)), mload(add(sub(fptr, sz), i)))
            }
            mstore(add(ptr, add(sz, 0x04)), shl(0x60, caller()))
            mstore(fptr, add(sz, 0x20))
            mstore(0x40, add(add(sz, 0x40), mload(0x40)))
            a := fptr
        }

        // console.logBytes(a);
    }

    // function testTransfer() public {
    //     basicToken.transfer(address(1), sendAmount);
    //     assertEq(basicToken.balanceOf(deployer), initialBalance - sendAmount);
    //     assertEq(basicToken.balanceOf(address(1)), sendAmount);
    // }

    // function testAssembly() public {
    //     assembly {
    //         let ptr := mload(0x40)
    //         mstore(
    //             ptr,
    //             0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000
    //         )
    //         mstore(
    //             add(ptr, 0x14),
    //             shl(0x60, 0xbebebebebebebebebebebebebebebebebebebebe)
    //         )
    //         mstore(
    //             add(ptr, 0x28),
    //             0x5af43d82803e903d91602b57fd5bf30000000000000000000000000000000000
    //         )
    //         let instance := create(0, ptr, 0x37)
    //     }
    // }

    // function testDeploy() public pure returns (uint256) {
    //     return 1;
    // }
}
