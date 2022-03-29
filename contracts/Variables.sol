// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;

contract WorkingWithVariables {
    uint256 public myUint;

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    bool public myBool;

    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }

    uint8 public myUint8;
    string public resultString;

    function setMyUint8(uint8 _myUint8) public {
        myUint8 = _myUint8;
    }

    function incrementUint() public {
        if (myUint8 < 255) {
            myUint8++;
            resultString = "Uint incremented";
        } else {
            resultString = "You need less than 255";
        }
    }

    function decrementUint() public {
        if (myUint8 > 0) {
            myUint8--;
            resultString = "Uint decremented";
        } else {
            resultString = "You need more than 0";
        }
    }
}