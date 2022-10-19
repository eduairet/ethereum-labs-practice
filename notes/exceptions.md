# Exceptions

-   Transactions are atomic
-   Errors are `state reverting`
-   `require, assert, revert (previously throw)`
-   They cascade (all contracts involved in a call will fail) except for low level functions
    -   `address.send() address.call() address.delegatecall() address.staticcall()`
-   `revert()` and `require()` return an error string

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract MyRevert {
    uint public currentPrice;

    constructor() {
        currentPrice = 10000000000000000;
    }

    function priceUp(uint newPrice) public {
        // if exception with revert()
        if (newPrice > currentPrice) {
            currentPrice = newPrice;
        } else {
            revert("Not more than current price");
        }
    }

    function priceDown(uint newPrice) public {
        // require exception
        // require(contitional, errorMessage);
        require(newPrice < currentPrice, "Not less than current price");
        currentPrice = newPrice;
    }

    function add100multiplier(uint newPrice) public {
        // assertion conditional
        assert(newPrice % 100 == 0);
        // If the assertion is not matched it will raise an exception
        currentPrice += newPrice;
    }
}
```

-   Exceptions and errors can be handled with try/catch events

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract TryCatch {
    uint public currentPrice;

    constructor() {
        currentPrice = 10000000000000000;
    }

    function priceUp(uint newPrice) public {
        require(newPrice > currentPrice, "Not more than current price");
        currentPrice = newPrice;
    }
}

// Error handling needs to be executed in an external contract
contract ErrorHandling {
    // Error handlers
    event ErrorLogging(string reason);
    event ErrorLogCode(uint code);
    event ErrorLogBytes(bytes reason);
    // Error catcher
    function catchError(uint newPrice) public {
        TryCatch will = new TryCatch();
        try will.priceUp(newPrice) {
            // Code if it works
        } catch Error(string memory reason) {
            // Simple reason, like failing a require (it has a message)
            // Returns remaining gas
            emit ErrorLogging(reason);
        } catch Panic(uint errorCode) {
            // Code error, like when failing an assertion (no message)
            // Consumes all the gas
            emit ErrorLogCode(errorCode);
        } catch (bytes memory lowLevelData) {
            // Any other error
            emit ErrorLogBytes(lowLevelData);
            // Custom exceptions will be triggered in this catch
            /*
            error ThisIsACustomError(string, string);
            function aFunction() public pure {
                revert ThisIsACustomError("Text 1", "text message 2");
            }
            */
        }
    }
}

// When fails it will emit a log event with an error
/*
[
	{
		"from": "0x5FD6eB55D12E759a21C09eF703fe0CBa1DC9d88D",
		"topic": "0xdcbe72357183be3854887085e70fd914c4c1733a94106878f48e8ba069d8fabc",
		"event": "ErrorLogging",
		"args": {
			"0": "Not more than current price",
			"reason": "Not more than current price"
		}
	}
]
*/
```

-   Use assert to validate invariants and require to validate user input
-   Assert is triggered when:
    -   Out of bounds index
    -   Division by zero or module zero (5/0 or 23%0)
    -   Byteshifting by negative amount
    -   Convert a very big valueo or negative to enum
    -   Zero-initialized variable of internal function type
    -   `assert(x)` where `x` is false
-   Require is triggered when:
    -   `require(x)` where `x` is false
    -   Function call via message calldoesn't finish properly (except low level functions)
    -   External function call to a contract doesn't contain code
    -   Contract receives ether without `payable`
    -   Contract receives ether in a getter function
    -   `address.transfer()` fails

Reference

-   [Reference Exceptions](https://ethereum-blockchain-developer.com/2022-04-smart-wallet/04-exceptions-require)
-   [Reference Try/Catch](https://ethereum-blockchain-developer.com/2022-04-smart-wallet/06-try-catch-named-exceptions)
