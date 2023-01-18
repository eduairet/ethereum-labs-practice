# Modifiers And Inheritance

-   Modifiers are useful to avoid code duplications, you can mix it with inheritance between to make it more reusable, for example having a owner contracts where you'll be the owner.

    -   `Ownable.sol`

        ```Solidity
        // SPDX-License-Identifier: MIT
        pragma solidity 0.8.17;

        contract Owned {
            address owner;

            constructor() {
                owner = msg.sender;
            }

            modifier onlyOwner() {
                require(msg.sender == owner, "You are not allowed");
                _;
            }
        }
        ```

    -   `ModifierExample.sol`

        ```Solidity
        // SPDX-License-Identifier: MIT
        pragma solidity 0.8.17;

        import "./Ownable.sol";

        contract ModifierExample is Owned {

            function changeOwner(address newOwner) public onlyOwner {
                owner = newOwner;
            }

        }
        ```

[Reference](https://ethereum-blockchain-developer.com/2022-05-erc20-token/06-modifiers/)
