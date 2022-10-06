# Blockchain basics

## What is a smart contract?

-   Piece of code that runs on the blockchain and needs a transaction to change it's state.
-   Is turing complete, which in theory allows it to solve any computation problem
-   They're written in a high-level programming language (Vyper, Solidity) which translates the code into EVM Bytecode
-   Every node in the Ethereum network will execute the same code
-   Solidity is the most popular Ethereum language which makes it the best to use

## Contract structure

-   Class like structure
-   Contains functions
-   Has conditionals `if/else`
-   Has loops `for/while`
-   Has data types
    -   Unsigned integers `uint`, booleans, arrays
    -   Structs, mappings, addresses
    -   No floating point numbers are allowed
-   Is inheritable
-   It has special structures like modifiers
-   It has imports
-   Example of the structure:

```Solidity
//SPDX-License-Identifier: Undefined
pragma solidity 0.8.14;

contract MyContract {
    // Contract body
}
```

-   The first line of every contract is the [The Software Package Data Exchange® (SPDX®)](https://spdx.dev/), if you don't have a license add `Undefined` if not add the name of the license, like `MIT`
    ```Solidity
    //SPDX-License-Identifier: Undefined
    ```
-   Then add the solidity version you'll use for the contract
    ```Solidity
    pragma solidity 0.8.14;
    pragma solidity ^0.8.0
    pragma solidity >=0.8.0 and <0.9.0;
    ```
-   And finally add your contract's name (Cap word and camelCase) logic

    ```Solidity
    contract MyContract {
        // Contract body
        // Variable with a string
        string public ourMessage = "My message";

        // Function that modifies the string
        // and accepts a string storaged in the memory as an argument
        function updateOurMessage(string memory updateMessage) public {
            ourMessage = updateMessage;
        }
        // Every transaction that triggers the function
        // will change the variable on the blockchain
    }
    ```

-   When the contract is deployed on the blockchain it gets its own address after a transaction is submited to a 0x0 address

### References

-   [Starting, Stopping and Interacting with Smart Contracts](https://ethereum-blockchain-developer.com/2022-01-remix-introduction/02-starting-stopping-interacting/)
-   [Read and write a contract](https://ethereum-blockchain-developer.com/2022-01-remix-introduction/04-read-write-to-smart-contract/)
