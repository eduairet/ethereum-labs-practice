// HTML elements
const enableMetaMaskButton = document.querySelector('.enableMetamask');
const statusText = document.querySelector('.statusText');
const accountBalance = document.querySelector('.balance');
const listenToEventsButton = document.querySelector('.startStopEventListener');
const contractAddr = document.querySelector('#address');
const incommingEvents = document.querySelector('.incommingEvents');
const eventResult = document.querySelector('.eventResult');
const filtered = document.querySelector('.filtered');
// Functions to interact with Web3
// Initializes an Ethereum node
enableMetaMaskButton.addEventListener('click', () => {
    enableDapp();
});
// Retreives event data
listenToEventsButton.addEventListener('click', () => {
    listenToEvents();
});
// Web3 variables we'll need
let accounts, balance, web3;
// Ethereum connection
async function enableDapp() {
    // Check for an ethereum node (Metamask)
    if (typeof window.ethereum !== 'undefined') {
        // Check for the current wallet account
        try {
            // Secure connect to Metamask
            accounts = await ethereum.request({
                method: 'eth_requestAccounts',
            });
            // If the connection is successful web3.js can interact with the node
            web3 = new Web3(window.ethereum);
            balance = await web3.eth.getBalance(accounts[0]);
            statusText.textContent = `Account: ${accounts[0]}`;
            accountBalance.textContent = `${(balance / 10 ** 18).toFixed(
                4
            )} 'GoerliETH'`;
            // You can now check the events
            listenToEventsButton.removeAttribute('disabled');
        } catch (error) {
            // If something goes wrong an error is shown
            if (error.code === 4001) {
                // EIP-1193 userRejectedRequest error
                statusText.innerHTML =
                    'Error: Need permission to access MetaMAsk';
                console.log('Permissions needed to continue.');
            } else {
                console.error(error.message);
            }
        }
    } else {
        statusText.innerHTML = 'Error: Need to install MetaMask';
    }
}
// ABI generated from contract compilation
let abi = [
    {
        anonymous: false,
        inputs: [
            {
                indexed: true,
                internalType: 'address',
                name: 'Sender',
                type: 'address',
            },
            {
                indexed: false,
                internalType: 'uint256',
                name: 'Amount',
                type: 'uint256',
            },
        ],
        name: 'Registered',
        type: 'event',
    },
    {
        inputs: [
            {
                internalType: 'address',
                name: '',
                type: 'address',
            },
        ],
        name: 'accounts',
        outputs: [
            {
                internalType: 'uint256',
                name: '',
                type: 'uint256',
            },
        ],
        stateMutability: 'view',
        type: 'function',
    },
    {
        inputs: [],
        name: 'addAccount',
        outputs: [
            {
                internalType: 'bool',
                name: '',
                type: 'bool',
            },
        ],
        stateMutability: 'payable',
        type: 'function',
    },
];
// Event listener function
const displayEvents = arr => {
    return arr
        .map(
            ev =>
                `<hr /><div><a href="https://goerli.etherscan.io/tx/${
                    ev[1].transactionHash
                }" target="blank">${ev[1].transactionHash}</a> ${Object.entries(
                    ev[1].returnValues
                )
                    .map(data => `<p>${data[0]}: ${data[1]}</p>`)
                    .filter(
                        val => val.includes('Sender') || val.includes('Amount')
                    )
                    .join('')}</div>`
        )
        .join('');
};
async function listenToEvents() {
    // Create an insttance from the contract
    const contractAddress = contractAddr.textContent;
    const myContract = new web3.eth.Contract(abi, contractAddress);
    // Latest Events
    myContract.events.Registered().on('data', ev => {
        incommingEvents.textContent = JSON.stringify(ev);
    });
    // Past Events
    myContract.getPastEvents('Registered', { fromBlock: 0 }).then(events => {
        const eventArr = Object.entries(events);
        eventResult.innerHTML = displayEvents(eventArr);
    });
    // Filtered Past Events
    myContract
        .getPastEvents('Registered', {
            fromBlock: 0,
            toBlock: 'latest',
            filter: {
                Sender: '0x87c9ADAEA58209abc771bFF5F70bFE71535D67df',
            },
        })
        .then(events => {
            const eventArr = Object.entries(events);
            console.log(eventArr);
            filtered.innerHTML = displayEvents(eventArr);
        });
}
