// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

// import "../contracts/BasicToken.sol";

contract ContractScript is Script {
    // BasicToken basicToken;

    enum GeneTransformType {
        none,
        add,
        sub,
        mult,
        set
    }

    struct GeneMod {
        GeneTransformType geneTransformType;
        uint256 value;
    }

    function setUp() public {}

    function run() public {
        uint8[] memory s = new uint8[](4);
        s[0] = 0;
        s[1] = 2;
        s[2] = 4;
        s[3] = 6;
        GeneMod[] memory v = new GeneMod[](4);
        v[0] = GeneMod(GeneTransformType.add, 1);
        v[1] = GeneMod(GeneTransformType.add, 1);
        v[2] = GeneMod(GeneTransformType.add, 1);
        v[3] = GeneMod(GeneTransformType.none, 1);
        transform(uint256(0x2a), s, v);
    }

    function transform(
        uint256 currDna,
        uint8[] memory genes,
        GeneMod[] memory modifications
    ) public pure returns (uint256 newDna) {
        for (uint16 geneIdx = 0; geneIdx < genes.length; geneIdx++) {
            // Gene details
            uint16 geneStartIdx = genes[geneIdx];
            uint16 geneEndIdx = geneIdx < genes.length - 1
                ? genes[geneIdx + 1]
                : 256;
            uint256 bitmask = get256Bitmask(geneStartIdx, geneEndIdx);
            uint256 gene = (currDna & bitmask) >> geneStartIdx;
            uint256 maxBits = geneEndIdx - geneStartIdx;
            GeneMod memory currMod = modifications[geneIdx];
            if (currMod.geneTransformType == GeneTransformType.add) {
                uint256 sum = gene + currMod.value;
                if (sum > 2**maxBits - 1) gene = 2**maxBits - 1;
                else gene = sum;
            } else if (currMod.geneTransformType == GeneTransformType.sub) {
                if (currMod.value > gene) gene = 0;
                else gene = gene - currMod.value;
            } else if (currMod.geneTransformType == GeneTransformType.mult) {
                uint256 prod = gene * currMod.value;
                if (prod > 2**maxBits - 1) gene = 2**maxBits - 1;
                else gene = prod;
            } else if (currMod.geneTransformType == GeneTransformType.set) {
                // Set must be in range, otherwise ignored
                if (currMod.value <= 2**maxBits - 1 && currMod.value >= 0)
                    gene = currMod.value;
            }
            gene = gene << geneStartIdx;
            newDna = newDna | gene;
        }
    }

    function get256Bitmask(uint16 startBit, uint16 endBit)
        internal
        pure
        returns (uint256 bitMask)
    {
        uint256 bitMaskStart = type(uint256).max << startBit;
        uint256 bitMaskEnd = type(uint256).max >> (256 - endBit);
        bitMask = bitMaskStart & bitMaskEnd;
    }
}
