# Structs

-   Structs are like classes that contain different types of data

    ```Solidity
    //SPDX-License-Identifier: MIT
    pragma solidity 0.8.15;

    // Struct example

    contract MyStruct {
        struct AtendeeStruct {
            address atendeeID;
            uint balance;
            bool confirmed;
        }

        AtendeeStruct public atendee;

        function addAtendee() public payable {
            atendee = AtendeeStruct(msg.sender, msg.value, false);
        }
    }
    ```

-   Child components have a similar behavior than structs but they cost more gas because they need to deploy an extra contract

    ```Solidity
    //SPDX-License-Identifier: MIT
    pragma solidity 0.8.15;

    contract ChildContract {
            address public atendeeID;
            uint public balance;
            bool public confirmed;

            constructor(address initID, uint initBalance) {
                atendeeID = initID;
                balance = initBalance;
                confirmed = false;
            }
    }

    contract ParentContract {
        ChildContract public atendee;

        function addAtendee() public payable {
            atendee = new ChildContract(msg.sender, msg.value);
        }
    }
    ```

-   Uuse structs unless you need special logic.

[Reference Structs](https://ethereum-blockchain-developer.com/2022-04-smart-wallet/02-structs/)
