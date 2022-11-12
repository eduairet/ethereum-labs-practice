# Web3.js

> **web3.js** is a collection of libraries that allow you to **interact with a local or remote ethereum node** using HTTP, IPC or WebSocket.
> It uses RPC methods to request data to the node provider (RESTful HTTP interface, or WebSockets).
>
> -   [Docs](https://web3js.readthedocs.io/)
> -   [GitHub](https://github.com/web3/web3.js)

## Intro

-   Basic functions:

    ```JavaScript
    'use strict';
    // Importing web3.js
    // In Node.js
    const Web3 = require('web3');
    const web3 = new Web3('ws://localhost:8546');
    // You'll need an async function to manage promises
    (async () => {
        // Get all accounts from the node connected
        const accounts = await web3.eth.getAccounts();
        console.log(accounts)
        // Get the balance from certain account
        const balance = await web3.eth.getBalance(accounts[0]);
        console.log(balance); // wei
        const ethBalance = await web3.utils.fromWei(balance, 'ether');
        console.log(ethBalance);// eth
    })();
    ```

## Event Listeners

web3.js contains several function that can help you listening events:

-   Listening an event

    -   With `web3.eth.subscribe`

        ```JavaScript
        web3.eth.subscribe('logs', {
            address: '0x7B2c2d7085360C21b4fF460c2C6310706413d326',
            topics: ['0x6f3bf3fa84e4763a43b3d23f9d79be242d6d5c834941ff4c1111b67469e1150c']
        }, function(error, result){
            if (!error)
                console.log(result);
        });
        ```

    -   With `myContract.events.EventName()`

        ```JavaScript
        let myContract = new web3.eth.Contract(ABI, CONTRACT_ADDRESS);
        myContract.events.EventName().on('data', event => {
            console.log(JSON.stringify(event))
        });
        ```

-   Check past events

    ```JavaScript
    contractInstance
        .getPastEvents('EventName', {
            // Filter
            fromBlock: 0,
        })
        .then(event => {
            // Output
            console.log(event);
        });
    ```

-   Filtering

    ```JavaScript
    contractInstance
        .getPastEvents('EventName', {
            // Filter
            fromBlock: 0,
            toBlock: 'latest',
            filter: {SomeArg: 'someValue'}
        })
        .then(event => {
            // Output
            console.log(event);
        });
    ```

Check the complete example at [simple-listener](../daaps/simple-listener/) in this repository

Reference

-   [Intro](https://ethereum-blockchain-developer.com/2022-05-erc20-token/01-web3js-introduction/)
-   [Listeners](https://ethereum-blockchain-developer.com/2022-05-erc20-token/04-events-and-web3js/)
