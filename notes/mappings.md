# Mappings

-   They are pretty much like hash maps

    ```Solidity
    //SPDX-License-Identifier: MIT
    pragma solidity 0.8.15;

    contract MyMapping {
        //mapping(key type => value type) Visibility MappingName;
        mapping(uint => bool) public myMapping;

        // Mappings come with a built in getter function to check the value of certain entry
        // It looks like this:

        // function sameNameAsMappingVariable(keyType keyName) visibility returns (valueType) {
        //     return myMapping[keyName];
        // }

        function setValue(uint index, bool val) public {
            // Set a value to a specific item of the mapping
            myMapping[index] = val;
        }
    }
    ```

-   Mappings are not indexed as arrays or list, so you'll have all the possible entries initialized
-   They're value restricted but you can make a nested mapping to handle different value types

    ```Solidity
    //SPDX-License-Identifier: MIT
    pragma solidity 0.8.15;

    contract MyMapping {

        uint public currentMember;

        //Mapping of mappings
        mapping(address => mapping(bool => uint)) public bank;

        constructor() {
            //bank[address] = true are admins
            //bank[false] = true are users
            //currentMember 0 is the owner of the bank
            bank[msg.sender][true] = currentMember;
            currentMember++;
        }

        function addMember(address member, bool isAdmin) public {
            bank[member][isAdmin] = currentMember;
            currentMember++;
        }
    }
    ```

-   Safe behavior using the [Checks Effects Interactions](https://fravoll.github.io/solidity-patterns/checks_effects_interactions.html)

    ```Solidity
    //SPDX-License-Identifier: MIT
    pragma solidity 0.8.15;

    contract TrackDeposits {
        mapping(address => uint) public users;

        function getContractBalance() public view returns(uint) {
            return address(this).balance;
        }

        function getUserBalance() public view returns(uint) {
            return users[msg.sender];
        }

        function addMoney() public payable {
            users[msg.sender] += msg.value;
        }

        //Safety: first set your Variables to the state you want,
        //you'll be protected if someone could call back to the contract before you can execute the next line after .transfer()

        function withdrawAll() public {
            uint balanceToSend = users[msg.sender];
            users[msg.sender] = 0;
            payable(msg.sender).transfer(balanceToSend);
        }

        function sendAll(address payable to) public {
            uint balanceToSend = users[msg.sender];
            users[msg.sender] = 0;
            to.transfer(balanceToSend);
        }

        function withdrawASome(uint balanceToSend) public {
            require(balanceToSend <= users[msg.sender])
            users[msg.sender] -= balanceToSend;
            payable(msg.sender).transfer(balanceToSend);
        }

        function sendSome(address payable to, uint balanceToSend) public {
            require((balanceToSend <= users[msg.sender])
            users[msg.sender] -= balanceToSend;
            to.transfer(balanceToSend);
        }
    }
    ```

-   The `require()` function is very helpful as a conditional for transactions and gives the user an error message if the process is not successful
-   Iterable mappings are accessible through external libraries

References

-   [Reference Mappings](https://ethereum-blockchain-developer.com/2022-04-smart-wallet/01-mappings/)
-   [Mapping Documentation](https://docs.soliditylang.org/en/v0.8.3/internals/layout_in_storage.html?highlight=storage#mappings-and-dynamic-arrays)
