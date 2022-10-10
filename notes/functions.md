# Functions

-   View: Reads from the state but doesn't write to the state (doesn't require a transaction [getters])
-   Pure: Not accessing state variables (virtually free)

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract Functions {
    uint someNum;

    // A function that reads data from the local contract scope
    // needs to be declared as view
    function viewFunc() public view returns(uint) {
        return someNum;
    }

    // Pure functions in the other hand can only call variables from their body
    // or use another pure functions inside them
    function viewFunc(uint someNum2) public pure returns(uint) {
        return someNum2 * 2;
    }
}
```

[Reference](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/07-writing-view-pure-functions)
