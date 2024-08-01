// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

contract TokenNoCap is Ownable, ERC20Pausable {
    uint8 private _deci;

    constructor(
        address initialOwner,
        string memory name,
        string memory symbol,
        uint8 deci,
        uint256 initialSupply
    )
        ERC20(name, symbol)
        Ownable(initialOwner)
    {
        _deci = deci;
        _mint(initialOwner, initialSupply);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address account, uint256 amount) public onlyOwner {
        _burn(account, amount);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _update(
        address from,
        address to,
        uint256 value
    ) internal override(ERC20Pausable) {
        super._update(from, to, value);
    }

    function getDecimals() public view returns (uint8) {
        return _deci;
    }

}