# Functions

-   Functions can be
-   **Public:** Called internally and externally
-   **Private:** Just called by the contract
-   **External:** Can be called from other contracts and externally
-   **Internal:** Can be only called by the contract or by derived contracts. Cannot be invoked by a transaction

## View and Pure

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

[Reference View and Pure](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/07-writing-view-pure-functions)

## Receive and Fallback

-   `receive()`
    -   must be `payable`
    -   Works without calldata
    -   gets priority over `fallback()`
-   `fallback()`
    -   `payable` is optional
    -   Works with calldata
    -   gets precedence over receive when calldata does not fit a valid function signature
-   Called when a transaction with with wrong function signature is sent to the smart contract
-   Called when the function in the transaction is not found
-   Can only be external

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract SampleFallback {
    uint public lastValueSent;
    string public lastFunctionCalled;

    // This makes the contract to receive money by default
    receive() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
    }

    // This executes when the calldata is triggered and is different to receive
    fallback() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "fallback";
    }
}
```

-   Contracts receiving ether without fallback and function call will throw an exception (bad practice)
-   You cannot stop receiving ether (validator reward, selfdestruct) need ether
-   Worst case: rely on 2300 gas ([gas stipend](https://eips.ethereum.org/EIPS/eip-1285))
-   Prevent contract execution if called with calldata `require(msg.data.length ==0)`

[Reference Receive and Fallback](https://ethereum-blockchain-developer.com/2022-03-deposit-withdrawals/09-sending-ether-to-smart-contracts/)
