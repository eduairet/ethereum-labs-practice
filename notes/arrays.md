# Arrays

-   Fixed or dynamic size
    -   `T[k]` fixed size of type T with k Elements
    -   `T[]` dynamic size of type T
    -   `T[][5]` 5 dynamic sized arrays (reversed notation)
-   Have two members
    -   `Lengt`
    -   `Push(element)`
-   They can consume a lot of gas (better to use mappings)

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract MyArray {
    address[2] contractInfo;

    constructor() {
        //Owner
        contractInfo[0] = msg.sender;
        //Contract address
        contractInfo[1] = address(this);
    }

    function getArrayIndex(uint index) public view returns(address) {
        return contractInfo[index];
    }
}
```
