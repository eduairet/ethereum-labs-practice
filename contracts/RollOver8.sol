// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract RolloverExample {
    uint8 public myUint8;

    function setMyUint8(uint8 _myUint8) public {
        myUint8 = _myUint8;
    }

    function decrement() public {
        myUint8--;
    }

    function increment() public {
        myUint8++;
    }

    function decrementUnchecked() public {
        unchecked {
            myUint8--;
        }
    }

    function incrementUnchecked() public {
        unchecked {
            myUint8++;
        }
    }
}