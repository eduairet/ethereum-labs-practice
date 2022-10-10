//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract BlockchainMesenger {
    uint256 public changeCounter;
    address public owner;
    string public theMessage;

    constructor() {
        owner = msg.sender; // First address interacting with the contract (creator)
    }

    function setMessage(string memory newMessage) public {
        // String is a reference object and needs a space in the memory
        if (msg.sender == owner) {
            // Safe check that allows just the owner to change the message
            theMessage = newMessage;
            changeCounter++;
        }
    }
}
