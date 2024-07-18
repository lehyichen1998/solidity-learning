// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract TheodoresToken is ERC20("Theodores Token", "TT"),Ownable(msg.sender){
    
    function mintFifty(uint256 num_token) public onlyOwner{
        _mint(msg.sender, num_token*10**18);
    }
}
