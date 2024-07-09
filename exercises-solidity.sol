// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract simpleStorage{
    uint storeData;

    function set(uint x) public{
        uint multiplierByFive = 5;
        storeData = x * multiplierByFive;
    }

    function get() public view returns (uint){
        return storeData;
    }
}