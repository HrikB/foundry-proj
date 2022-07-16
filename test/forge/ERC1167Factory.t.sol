//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../contracts/proxy/ERC1167/ERC1167Factory.sol";
import "../../contracts/assets/ERC721/ERC721Owl.sol";

contract ERC1167FactoryTest is Test {
    uint256 constant allE =
        108072616621495115728666252674775380663051985687931193103493745074052254330606;

    ERC1167Factory c;
    ERC721Owl impl;

    function setUp() public {
        c = new ERC1167Factory();
        impl = new ERC721Owl();
    }

    function testCloneDeterministic() public {
        ERC1167Factory(c).cloneDeterministic(
            address(impl),
            bytes32(abi.encode(0)),
            abi.encodeWithSignature(
                "initialize(address,string,string,string,address)",
                address(0),
                "name",
                "symbol",
                "uri",
                address(0)
            )
        );
    }
}
