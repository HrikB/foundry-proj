// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../contracts/MinterBreeding.sol";
import "../contracts/ERC1167Factory.sol";
import "../contracts/FactoryERC20.sol";
import "../contracts/FactoryERC721.sol";

contract ContractScript is Script {
    MinterBreeding minterBreedingImpl;
    ERC1167Factory factory;
    FactoryERC20 token;
    FactoryERC721 nft;

    function setUp() public {
        token = new FactoryERC20(0, "a", "b");
        nft = new FactoryERC721("a", "b");
        nft.mintTokens(10);
    }

    struct BreedingRules {
        uint8 requiredParents;
        uint16 generationCooldownMultiplier;
        uint8[] genes;
        uint256 breedCooldownSeconds;
        uint256[] mutationRates;
    }

    function run() public {
        vm.broadcast();
        minterBreedingImpl = new MinterBreeding();
        factory = new ERC1167Factory();

        uint256[] memory emptyArr = new uint256[](0);
        uint8[] memory emptyArr1 = new uint8[](0);
        BreedingRules memory b = BreedingRules(2, 0, emptyArr1, 1, emptyArr);

        factory.cloneDeterministic(
            address(minterBreedingImpl),
            bytes32(uint256(1)),
            abi.encodeWithSignature(
                "intialize(address,address,address,(uint8,uint16,uint8[],uint256,uint256[]))",
                address(this),
                address(token),
                address(this),
                1e18,
                address(nft),
                abi.encode(b)
            )
        );
    }
}
