//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Create3.sol";

contract BasicToken {
    uint256 totalSupply_;
    mapping(address => uint256) balances;

    // constructor() {
    //     totalSupply_ = 1000;
    //     balances[msg.sender] = 1000;
    // }

    function totalSupply() public returns (uint256) {
        Create3.create3(
            bytes32(abi.encode(0)),
            abi.encodePacked(0x553a96c13b67D500182bb6aB46d53A2eDFb22706)
        );
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_to != address(0));
        require(_value <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }
}
