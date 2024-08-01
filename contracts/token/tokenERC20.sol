// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable(msg.sender) {
    constructor(string memory tokenName, string memory tokenSymbol)
        ERC20(tokenName, tokenSymbol)
    {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public {
        _burn(from, amount);
    }

    function transfer(address to, uint256 amount)
        public
        override
        returns (bool)
    {
        require(amount > balanceOf(msg.sender), "Error");
        require(balanceOf(msg.sender) <= 0, "Error 1");
        _transfer(msg.sender, to, amount);
        return true;
    }
}
