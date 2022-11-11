# Events

## Intro

Events are useful to let the contracts communicate outside the blockchain

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract EventsIntro {
    mapping(address => uint) public accounts;
    // Here you define the event with the parameters you want to pass
    event Registered(address Sender, uint Amount);

    function addAccount() public payable returns(bool) {
        require(msg.value > 0);
        accounts[msg.sender] = msg.value;
        // Here we call our event if the transation is successful
        // emit EventName(params);
        emit Registered(msg.sender, msg.value);
        return true;
    }
}
```

An interaction with this [contract's](https://mumbai.polygonscan.com/address/0x75b5ae50300aD65506F952A3f2E529a0908E7AeF) `addAccount` function will give us a **logs** output like this:

```JSON
[
	{
		"from": "0x75b5ae50300aD65506F952A3f2E529a0908E7AeF",
		"topic": "0x6f3bf3fa84e4763a43b3d23f9d79be242d6d5c834941ff4c1111b67469e1150c",
		"event": "Registered",
		"args": {
			"0": "0x79D755FBc47d4BB9e1957708C482BD2A0e91b812",
			"1": "10000",
			"Sender": "0x79D755FBc47d4BB9e1957708C482BD2A0e91b812",
			"Amount": "10000"
		}
	}
]
```

This output can be used inside our terminal or frontend to display data from the transaction.

[Reference](https://ethereum-blockchain-developer.com/2022-05-erc20-token/03-events-and-return-variables-1/)