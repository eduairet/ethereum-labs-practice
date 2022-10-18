# External Function Calls and Low-Level Calls

-   `.transfer`: Sends money and raises an error if it's not successful
-   `.send`: Sends money and returns a boolean if it's not successful

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Sender {
    // Recive will allow the contract to receive ether in a low level interaction
    receive() external payable {}

    function withdrawTransfer(address payable to) public {
        // Raises an error if fails
        to.transfer(10);
    }

    function withdrawSend(address payable to) public {
        // Returns a boolean but won't make the transaction fail
        bool sent = to.send(10);
        // Conditional that raises an error if fails
        require(sent, "Something failed!");
    }
}

contract ReceiverNoAction {
    // This will allow sender contract to transfer ETH
    // because it doesn't have extra functions
    // which will be a 2300 gas transaction both with
    // withdrawTransfer() and withdrawSend()
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {}
}

contract ReceiverAction {
    uint public balanceReceived;
    // This function will cost more gas when deploy
    // which will be translated into a failed transaction
    // If withdrawSend() just has to.send(10) inside
    // The transaction will be successful even though it fails
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {
        balanceReceived += msg.value;
    }
}
```

> **Pull over Push:** Allways let users withdraw money instead pushing the funds

-   Sending eth from one contract to another

    ```Solidity
    // SPDX-License-Identifier: GPL-3.0
    pragma solidity 0.8.15;

    contract ContractOne {
        // A book with addresses balances
        mapping(address => uint) public addressBalances;
        // Retrieve balance from this contract
        function getBalance() public view returns(uint) {
            return address(this).balance;
        }
        // Add money to certain address inside this contract
        function deposit() public payable {
            addressBalances[msg.sender] += msg.value;
        }
    }

    contract ContractTwo {
        // Deposit into this contract function
        function deposit() public payable {}
        // Calling deposit from contract 1
        function depositOnContractOne(address _contractOne) public {
            // New contract 1 instance
            ContractOne one = ContractOne(_contractOne);
            // Calling the deposit function from contract 1
            // defining the amount of wei sent and consumed in the contract*
            one.deposit{value: 10, gas: 100000}();
            // * If gas is not consumed it will be returned to the sender
            // You'll see something like this while debugging
            // xecution cost: 24246 gas (Cost only applies when called by a contract)
        }
    }
    ```

    -   About gas:

        -   Make its limit higher than the cost of a transaction (remainder will be returned)
        -   Receiving address is a contract
        -   Receiving contract has a receiving function (like .deposit() in the previous example)

            -   If we don't have an scenario where we can verify if the address is from a contract we can do it in a low-level interaction

                ```Solidity
                // SPDX-License-Identifier: GPL-3.0
                pragma solidity 0.8.15;

                contract ContractOne {
                    // Mapping with adresses and balances
                    mapping(address => uint) public addressBalances;
                    // Get contract balance
                    function getBalance() public view returns(uint) {
                        return address(this).balance;
                    }
                    // Deposit balance to the contract and index it in the balance mapping by address
                    receive() external payable {
                        addressBalances[msg.sender] += msg.value;
                    }
                }

                contract ContractTwo {
                    // Deposit eth function
                    function deposit() public payable {}
                    // Deposit in contract one
                    function depositOnContractOne(address contractOne) public {
                        // If we're looking for a known function it'll need these lines
                        /*
                        bytes memory payload = abi.encodeWithSignature("deposit()");
                        (bool success, ) = contractOne.call{value: 10, gas: 100000}(payload);
                        */
                        // If we're looking for receive() (more anonymous) we can do it this way
                        (bool success, ) = contractOne.call{value: 10, gas: 100000}("");
                        require(success);
                    }
                }
                ```

                -   Always be careful with the gas, if you put the amount very high it might lead re-entrancy attacks
                    > -   Always try to follow the so-called checks-effects-interactions pattern, where the external smart contract interaction comes last

[Reference External Function Calls and Low-Level Calls](https://ethereum-blockchain-developer.com/2022-04-smart-wallet/07-low-level-calls-in-depth/)
