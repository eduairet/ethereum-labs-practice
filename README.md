# Ethereum Blockchain Developer Bootcamp With Solidity (2022)

## Notes

1. [Remix IDE](./notes/remix.md)
2. [Ethereum Blockchain Basics](./notes/blockchain-basics.md)
3. [Ethereum Primitives and Objects](./notes/primitives-objects.md)
4. [Functions](./notes/functions.md)
5. [Constructor](./notes/constructor.md)
6. [Mappings](./notes/mappings.md)

## Docs

-   [Documentation](https://ethereum-blockchain-developer.com/)
-   [Resources](https://docs.google.com/spreadsheets/d/1OO06RZ7vw8-Hij8ZxB68FaRYRtQEz3GifnLDNwW8sTs/edit#gid=1051902784)

## Practice

Practice exercises developed during the course.

<details>
  <summary>Blockchain Networks</summary>

### [FirstSmartContract.sol](./contracts/FirstSmartContract.sol)

-   JavaScript VM(London) deploy 0xd9145CCE52D386f254917e481eB44e9943F39138

![JavaScript VM](./util/images/javaScriptVM.png)

-   Ropsten deploy [0x8346f00379d30Dc3bf7D069C96a65ec6B30ac0EF](https://ropsten.etherscan.io/address/0x8346f00379d30Dc3bf7D069C96a65ec6B30ac0EF)

-   Web3 Provider deploy 0x3dc61BFDa63a4FbA5C9bB5C20a99c97cecb90a9a

![JavaScript VM](./util/images/web3provider.png)

</details>

<details>
  <summary>Simple Variables</summary>

#### [Variables.sol](./contracts/Variables.sol)

#### [RollOver7.sol](./contracts/RollOver7.sol) pragma solidity 0.7.0;

#### [RollOver8.sol](./contracts/RollOver8.sol) pragma solidity ^0.8.1;

</details>

<details>
  <summary>Blockchain Messenger</summary>

#### [BlockchainMessenger.sol](./contracts/BlockchainMessenger.sol) pragma solidity 0.8.17;

</details>

<details>
  <summary>Smart Money</summary>

#### [SmartMoney.sol](./contracts/SmartMoney.sol) pragma solidity 0.8.15;

-   Deployment: [0x3e3a243eCd1D7651D99c34A1E65f3f52Af0f3D0D](https://mumbai.polygonscan.com/address/0x3e3a243eCd1D7651D99c34A1E65f3f52Af0f3D0D)
-   [Reference exercise](https://ethereum-blockchain-developer.com/2022-03-deposit-withdrawals/11-the-smart-money-implementation/)

</details>

<details>
  <summary>Deposit, withdraw</summary>

#### [SendMoneyExample.sol](./contracts/SendMoneyExample.sol)

</details>

<details>
  <summary>Start, stop and destroy</summary>

#### [StartStopUpdateExample.sol](./contracts/StartStopUpdateExample.sol)

</details>

<details>
  <summary>Mappings and Struct</summary>

#### [SimpleMappingExample.sol](./contracts/SimpleMappingExample.sol)

#### [MappingStructExample.sol](./contracts/MappingStructExample.sol)

</details>
