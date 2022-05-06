// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.2;

contract Constructors {
    
    // constant, immutable
    uint public constant number1 = 10; // constant ile sabit tanımlar yapılır. Değiştirilemez.
    uint public immutable number2; // immutable da sabit tanımlamak için kullanılır. Tek farkı constructor'da değer set edilmesidir.

    string public tokenName;
    uint public totalSupply;

    address public immutable owner;

    constructor(string memory _tokenName, uint _totalSupply){
        tokenName = _tokenName;
        totalSupply = _totalSupply;

        number2 = 20;

        owner = msg.sender;
    }
}