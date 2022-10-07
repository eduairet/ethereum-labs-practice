# Ethereum primitives and objects

## Booleans

> True or False value

-   A public boolean in solidity will look like this:

    ```Solidity
    //SPDX-License-Identifier: MIT
    pragma solidity 0.8.14;

    contract Boolean{
        // Initialized with default value (false), no undefined or null
        bool public myBool;
        // Function changes myBool when is called
        function setBool () public {
            myBool = !myBool;
        }
    }
    ```

[Reference](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/01-boolean/)

## Integers

-   Signed

    -   Whole numbers, negative included

-   Unsigned

    -   Large size, between `2 ** 8` to `2 ** 256 - 1`, always absolute numbers

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

contract MyInt {
    // Signed integers
    int8 public intInc = 10;
    int8 public myInt;
    int16 public myNegativeInt;
    // Unsigned integers
    uint256 public uintInc = 1000;
    uint256 public myUint;

    // Use integer sizes to control memory usage

    function addint () public {
        myInt = myInt + intInc; // If it overpasses 256 it will have an error
        // In Solidity versions <0.8.x an (unsigned) integer restarts to zero when it gets to its limit.
        myNegativeInt = myNegativeInt - 1; // It could be myNegativeInt--;
        myUint = myUint + uintInc;
    }
}
```

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

contract ExampleWrapAround {

    uint8 public myUint8 = 250;

    function decrement() public {
        myUint8--; // It will go backwards
    }

    function increment() public {
        myUint8++;
    }
}
```

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

contract ExampleWrapAround {

    uint8 public myUint8 = 250;

    function decrement() public {
        unchacked {
            myUint8--; // Default behavior
        }
    }

    function increment() public {
        myUint8++;
    }
}
```

[Reference](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/02-integer/)
[Reference rollovers](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/03-integer-rollovers)

## Strings and bytes

-   Strings are basically byte arrays
-   Strings are expensive to store in the Blockchain, that's the reason why thwy don't have much functionality

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

contract MyStrings {
    string public myString = "Dope!";
    bytes public myStringBytes = "Dope!"; //myStringBytes.length
    // byte representation of a string - bytes: 0x446f706521

    function setString(string memory newString) public {
        // Memory allows the script to use th memory and clear it after the transaction is done
        myString = newString;
    }

    // view is something supposed to be read outside the contract
    function compareStrings(string memory newString) public view returns(bool) {
        // Solidity doesn't allow direct string comparison
        return keccak256(abi.encodePacked(myString)) == keccak256(abi.encodePacked(newString));
    }
}
```

[Reference](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/04-strings-bytes/)

## Addresses
