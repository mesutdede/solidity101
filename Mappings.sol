// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.2;


// key => value
contract Mappings {

    mapping(address => bool) public registered;
    mapping(address => uint256) public favNums;

    function register(uint256 _favNum) public {
        // require methodun 1 kez çalıştırılmasını sağlar. koşul şartı true değilse revert eder. 
        require(!isRegistered(), "Kullaniciniz daha once kayit yapti.");

        registered[msg.sender] = true;
        favNums[msg.sender] = _favNum;
    }

    function isRegistered() public view returns(bool) {
        return registered[msg.sender];
    }

    function deleteRegistered() public {
        require(isRegistered(), "Kullaniciniz kayitli degil.");
        delete(registered[msg.sender]);
        delete(favNums[msg.sender]);
    }

}

contract NestedMapping {
    mapping(address => mapping(address => uint256)) public depts;

    function incDept(address _borrower, uint256 _amount) public {
        depts[msg.sender][_borrower] += _amount;
    }

    function decDept(address _borrower, uint256 _amount) public {
        require(depts[msg.sender][_borrower] >= _amount, "Not enough dept.");
        depts[msg.sender][_borrower] -= _amount;
    }

    function getDept(address _borrower) public view returns(uint256) {
        return depts[msg.sender][_borrower];
    }
}