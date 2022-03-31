// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

contract StartStopUpdateExample {

    address public owner;
    bool public paused;

    constructor() {
        owner = msg.sender;
    }

    function setPaused(bool _paused) public {
        require(owner == msg.sender, "You are not the owner.");
        paused = _paused;
    }

    function sendMoney() public payable {}

    function withdrawMoney(address payable _to) public {
        require(owner == msg.sender, "You are not the owner.");
        require(paused == false, "Contract is paused.");
        _to.transfer(address(this).balance);
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function destroySmartContract(address payable _to) public {
        require(owner == msg.sender, "You are not the owner.");
        selfdestruct(_to);
    }

}