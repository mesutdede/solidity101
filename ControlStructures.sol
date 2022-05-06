// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.2;

contract ControlStructures {
    bytes32 private hashedPassword;
    uint256 private loginCount;

    constructor(string memory _password) {
        hashedPassword = keccak256(abi.encode(_password));
    }

    // Bir değişkenin değeri burada değiştirildiği için view olarak işaretlemedik.
    function login(string memory _password) public returns (bool) {
        // solidity'de string ifadeler karşılaştırılamıyor. Bu nedenle hash leri karşılaştırılıyor. 
        //Bu nedenle hashedPassword bytes32 olarak tanımlandı.
        if(hashedPassword == keccak256(abi.encode(_password))){
            loginCount++;
            return true;
        } else {
            return false;
        }

        //return hashedPassword == keccak256(abi.encode(_password))
    }

    function loginStatus() public view returns(uint256) {
        if(loginCount == 0) {
            return 0;
        } else if(loginCount > 0 && loginCount != 1){
            return 1;
        } else if(loginCount == 1) {
            return 2;
        } else {
            return 3;
        }
    }
}