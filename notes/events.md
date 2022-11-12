# Events

## Intro

-   Events are useful to let the contracts communicate outside the blockchain
-   Events are cheap to execute, about 78 times less than saving the data in the contract
-   Writing a transaction doesn't return values, that's why we need events
-   Events cannot be accessed inside the contract, just emitted

    ```Solidity
    //SPDX-License-Identifier: MIT
    pragma solidity 0.8.17;

    contract EventsIntro {
        mapping(address => uint) public accounts;
        // Here you define the event with the parameters you want to pass
        // Indexed allows to filter the event
        event Registered(address indexed Sender, uint Amount);

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

An interaction with this [contract's](https://goerli.etherscan.io/address/0x7B2c2d7085360C21b4fF460c2C6310706413d326) `addAccount` function will give us a **logs** output like this:

```JSON
[
	{
		"from": "0x7B2c2d7085360C21b4fF460c2C6310706413d326",
		"topic": "0x6f3bf3fa84e4763a43b3d23f9d79be242d6d5c834941ff4c1111b67469e1150c",
		"event": "Registered",
		"args": {
			"0": "0xDfdBF53B3181893918AA23F15173A7f4C10FA087",
			"1": "1000",
			"Sender": "0xDfdBF53B3181893918AA23F15173A7f4C10FA087",
			"Amount": "1000"
		}
	}
]
```

This structure can be used inside our terminal or frontend to display data from the transaction.

[Reference](https://ethereum-blockchain-developer.com/2022-05-erc20-token/03-events-and-return-variables-1/)

## Event Topics

Topics describe events and allows to quickly go through the underlying bloom filter. If you look at raw block headers, you will see they contain a logsBloom field. Bloom filter can help you finding which blocks contain certain logs with certain topics.

## Events as data storage

You can use events to emit a hash that can be related to an IPFS file with heavier data, this way you'll save costs.
