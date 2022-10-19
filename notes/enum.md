# Enum

-   Enums are a way to create user-defined type in solidity
-   Will be integers internally
    -   If it fits in `uint8` -> 0-255 in the ABI
    -   More than 256 values -> `uint16`

```Solidity
//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract MyEnum {
    enum Game{ ROCK, PAPER, SCISSOR }
    Game choice;
    // You can set a default constant choice
    Game constant defaultChoice = Game.ROCK;
    // Or add setters
    function setRock() public {
        choice = Game.ROCK; // 0
    }
    function setPaper() public {
        choice = Game.PAPER; // 1
    }
    function setScissor() public {
        choice = Game.SCISSOR; // 2
    }
    // This way you can retreive the selections based on the called functions
    function getChoice() public view returns (Game) {
        return choice; // Choice defined by setters
    }
    function getDefaultChoice() public pure returns (uint) {
        return uint(defaultChoice); //0
    }
}
```
