// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract adamantine is ERC20{
    constructor(string memory _tokenName,string memory _tokenSymbol)ERC20(_tokenName,_tokenSymbol){

    }

    function minToken() public payable{
        require(msg.value == 1000,"10 tokens for 1000 wei!");
        _mint(msg.sender,10);
    }

    function getEtherBalance(address _address) public view returns(uint256)
    {
        return  _address.balance;
    }
}