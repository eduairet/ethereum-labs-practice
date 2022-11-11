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

-   Events are really important in Web3 and you can listen to them using the `web3.eth.suscribe()` function
    -   It sends JavaScript free l

Reference

-   [Intro](https://ethereum-blockchain-developer.com/2022-05-erc20-token/01-web3js-introduction/)

## Event Listeners

