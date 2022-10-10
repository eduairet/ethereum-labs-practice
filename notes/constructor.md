# Constructor

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract MyConstructor {
    address public myAddress;
    // If you want to assign a value to a variable since the contract deployment
    // you'll need to use the special constructor() function
    constructor() {
        // Constructor is called only once and accepts all kinds of arguments
        myAddress = msg.sender;
    }

    function setMyAddress(address someAddress) public {
        // This is handy to change something set up during the deployment
        myAddress = someAddress;
    }
}
```

[Reference](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/08-solidity-constructor/)
