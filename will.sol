// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Will {
    address owner;
    uint256 fortune;
    bool deceased;

    constructor() public payable {
        owner = msg.sender;
        fortune = msg.value;
        deceased = false;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    modifier mustBeDeceased{
        require(deceased == true);
        _;
    }

    address payable[] familyWallets; 

    mapping(address=>uint) inherintance;

    function setInheritance(address payable wallet, uint amount) public onlyOwner
    {
        familyWallets.push(wallet);
        inherintance[wallet] = amount;
    }

    function payout() private mustBeDeceased{
        for(uint i=0;i<familyWallets.length;i++)
        {
            familyWallets[i].transfer(inherintance[familyWallets[i]]);
        }
    }

    function HasDeceased() public onlyOwner{
        deceased = true;
        payout();
    }
}
