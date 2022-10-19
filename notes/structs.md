# Structs

-   Structs are like classes that contain different types of data (except other structs)

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

-   Use structs unless you need special logic.
-   If you need more complex data structures you can mix mappings with structs

    ```Solidity
    //SPDX-License-Identifier: MIT
    pragma solidity 0.8.15;

    contract StructsMappings {
        struct Transaction {
            uint ammount;
            uint timestamp;
        }

        struct Balance {
            uint total;
            uint numdeposits;
            mapping(uint => Transaction) deposits;
            uint numwithdrawals;
            mapping(uint => Transaction) withdrawals;
        }

        // Mapping of structs
        mapping(address => Balance) public balances;

        function depositMoney() public payable {
            balances[msg.sender].total += msg.value;
            //References need memory location
            Transaction memory deposit = Transaction(msg.value, block.timestamp);
            balances[msg.sender].deposits[balances[msg.sender].numdeposits] = deposit;
            balances[msg.sender].numdeposits++;
        }

        function getDeposit(address from, uint index) public view returns(Transaction memory) {
            return balances[from].deposits[index];
        }

        function withdrawMoney(address payable to, uint amount) public {
            balances[to].total -= amount;
            Transaction memory withdrawal = Transaction(amount, block.timestamp);
            balances[to].withdrawals[balances[to].numwithdrawals] = withdrawal;
            balances[to].numwithdrawals++;
            to.transfer(amount);
        }

        function getWithdrawal(address from, uint index) public view returns(Transaction memory) {
            return balances[from].withdrawals[index];
        }
    }
    ```

References:

-   [Reference Structs](https://ethereum-blockchain-developer.com/2022-04-smart-wallet/02-structs/)
-   [Reference Structs Mappings](https://ethereum-blockchain-developer.com/2022-04-smart-wallet/03-structs-and-mappings/)
