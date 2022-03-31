// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

contract SimpleMappingExample {

    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;
    mapping(uint => mapping(uint => bool)) public myNestedMapping;

    function setValue(uint _index) public {
        myMapping[_index] = true;
    }

    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }

    function setUintUintMapping(uint _index, uint _subindex) public {
        myNestedMapping[_index][_subindex] = true;
    }

    function getUintUintMapping(uint _index, uint _subindex) public view returns(bool) {
        return myNestedMapping[_index][_subindex];
    }

}