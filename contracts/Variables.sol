// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;

contract WorkingWithVariables {

    // UnsignedInteger256 -> uint == uint256 -> 2**256-1
        // 0 - 115792089237316195423570985008687907853269984665640564039457584007913129639935
    uint256 public myUint;
    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    // UnsignedInteger8 -> 2**8 - 1
        // 0 - 255
    uint8 public myUint8;
    bool public result;
    function setMyUint8(uint8 _myUint8) public {
        myUint8 = _myUint8;
    }
    // Overflow & Underflow
    function incrementUint() public {
        if (myUint8 < 255) {
            myUint8++;
            result = true;
        } else {
            result = false;
        }
    }
    function decrementUint() public {
        if (myUint8 > 0) {
            myUint8--;
            result = true;
        } else {
            result = false;
        }
    }

    // Boolean
    bool public myBool;
    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }

    // Address
    address public myAddress;
    function setAddress(address _myAddress) public {
        myAddress = _myAddress;
    }
    function getBalance() public view returns(uint) {
        return myAddress.balance;
    }

    // Strings
    string public myString;
    // Strings are expensive in gas, rule of thumb, avoid using it
    function setString(string memory _myString) public {
        myString = _myString;
    }

}
