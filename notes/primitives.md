# Ethereum Primitives

> -   All the information of a contract is public (Ether is not in your wallet, is in the blockchain)
> -   Addresses have a balance and can transfer ETH
> -   Global objects tell what happens inside a transaction like `block.timestamp`

## Variables

-   Always initialized with a default value (no null, undefined)
    -   `(u)int = 0`
    -   `bool = false`
    -   `string = ""`
-   Public variables have a getter with the variable name
    -   Variables and functions cannot share the same name
-   All reference types (arrays, strings, etc) need a memory location
-   Variable construction needs the type of value, the name of the variable and if it's posible, the value (inside functions for example)

    ```Solidity
    //SPDX-License-Identifier: MIT
    pragma solidity 0.8.15;

    contract MyContract {
        bool myVar;
        function changeBool() public returns(bool){
            bool opposite = !myVar;
            myVar = opposite;
            return myVar;
        }
    }
    ```

## Booleans

-   True or False value

-   A public boolean in solidity will look like this:

    ```Solidity
    //SPDX-License-Identifier: MIT
    pragma solidity 0.8.14;

    contract Boolean {
        // Initialized with default value (false), no undefined or null
        bool public myBool;
        // Function changes myBool when is called
        function setBool () public {
            myBool = !myBool;
        }
    }
    ```

    -   They can be the result of comparisons with _or_ and _and_ `|| &&`

[Reference boobleans](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/01-boolean/)

## Integers

-   Numbers in ranges of 8bit increments
-   No decimals
-   Signed

    -   Whole numbers, negative included
    -   `int8 range(-128, 127)`

-   Unsigned
    -   `uint` is an alias for `uint256`
    -   Large size, between `2 ** 8 - 1` to `2 ** 256 - 1`, always absolute numbers

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

References

-   [Reference integers](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/02-integer/)
-   [Reference rollovers](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/03-integer-rollovers)

## Strings and bytes

-   Bytes are arebitrary length of raw data
-   Strings are basically byte arrays of `utf-8` data
    -   The main difference between strings and bytes is that strings don't have length or index-access
-   Strings are expensive to store in the Blockchain, that's the reason why they don't have much functionality

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

[Reference strings and bytes](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/04-strings-bytes/)

## Addresses

-   20 bytes worth of an Ethereum address (account) `0x0000000000000000000000000000000000000000` (default value)
    -   User or contract
-   Are used to transfer ether from one account to another and check the balance in wei of them
    -   `.transfer()` -> Sends an amount in wei
    -   `.send()` -> Sends amount in wei and returns a boolean
        -   `transfer` and `send` only use 2300 gas and calling a contract will require more, be aware
    -   `.call{gas: ..., value: ...}()` -> returns a boolean if gas is specified
    -   `.delegatecall()` -> Similar to call
    -   `payable` -> makes an address able to receive money
    -   `.balance` -> balance of an address in wei
    -   The contract balance can be retreived with `address(this).balance`

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract MyAddress{
    address public someAddress;
    function setSomeAddress(address newAddress) public {
        someAddress = newAddress;
    }
    //Reading (view returns(value type)) the value of an address
    function getBalance() public view returns(uint) {
        return someAddress.balance;
    }
}
```

-

[Reference addresses](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/05-ethereum-addresses/)

## Payable

-   If you want to allow the contract functions to receive or send ETH value, you'll need to make it `payable`

    ```Solidity
    //SPDX-License-Identifier: MIT
    pragma solidity 0.8.14;

    contract PayableFunction {
        function deposit() public payable{}
        function withdraw(uint ammount) public{
            // Wrap the sender in a payable() modifier function to allow it to receive eth
            payable(msg.sender).transfer(ammount);
            // Every account has a transfer function for default
        }
    }
    ```

[Reference Payable Modifier](https://ethereum-blockchain-developer.com/2022-03-deposit-withdrawals/08-the-payable-modifier/)

## The `msg` object

### msg.sender

```Solidity
///SPDX-License-Identifier: MIT
pragma solidity 0.8.15;


contract MsgObject {

    address public someAddress;

    function updateAddress() public {
        someAddress = msg.sender;
        // msg.sender is the address that lastly interacted with the contract
    }

}
```

### msg.value

-   This is the value that a sender is defining for a transaction

    ```Solidity
    //SPDX-License-Identifier: MIT
    pragma solidity 0.8.16;

    contract PayableMsgValue {
        string public myMessage;

        constructor() {
            myMessage = "Hi!";
        }

        function changeMessage(string memory newMessage) public payable {
            // Message will only change if the msg.value is equal to 1 eth
            if (msg.value == 1 ether) {
                myMessage = newMessage;
            } else {
                // If the msg.value is not equal to 1 eth the money will come back to the sender
                payable(msg.sender).transfer(msg.value);
            }
        }
    }
    ```
