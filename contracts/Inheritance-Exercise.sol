// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

// 1️⃣ Imherit from the Multiplayer Game
// 2️⃣ Call the parent joinGame() function
// HINT: you might have to use the super keyword
// 3️⃣ Increment playerCount in joinGame() function

// MultiplayerGame contract - parent
contract MultiplayerGame {
    mapping(address => bool) public players;

    function joinGame() public virtual {
        players[msg.sender] = true;
    }
}

// Game contract inheriting from MultiplayerGame - child
contract Game is MultiplayerGame{
    string public gameName;
    uint256 public playerCount;

    constructor(string memory _gameName) {
        gameName = _gameName;
        playerCount = 0;
    }

    function startGame() public {
        // Perform game-specific logic here
    }

    function joinGame() public override {
       super.joinGame(); // function from parent contract

       playerCount++;
    }
}