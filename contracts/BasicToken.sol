//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicToken {
    uint256 totalSupply_;
    mapping(address => uint256) balances;
    uint256 constant initialSupply = 1000;

    constructor(uint256 initialSup) {
        totalSupply_ = initialSup;
        balances[msg.sender] = initialSup;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
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

    function whatIsTheMeaningOfLife() external pure returns (uint256) {
        return 0x42;
    }
}
