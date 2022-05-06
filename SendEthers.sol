// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.2;

contract Bank {
    mapping(address => uint) balances;

    // Fonksiyona bir varlık(ether) göndermek istiyorsak payable ile işaretliyoruz.
    function SendEtherToContract() payable external {
        balances[msg.sender] = msg.value;
    }

    function showBalance() external view returns(uint) {
        return balances[msg.sender];
    }

    // contract tan ether cekiliyor.
    function withdraw(address payable to, uint amount) external {
        require(balances[msg.sender] >= amount, "you do not have enough limits on your account");
        to.transfer(amount);
        balances[msg.sender] -= amount;

        // 3 farklı varlık gönderme yöntemi var.
        // 1. transfer() : (amount balance dan fazla olursa işlem revert edilir.)
        to.transfer(amount);

        // 2 .send() : (true, false)
        bool isok = to.send(amount);

        // 3. call()
        (bool sent, ) = to.call{value: amount}("");
    }

    uint public receiveCount = 0;
    uint public fallbackCount = 0;
    // Contract a ether geldiğinde kendiliğinden çalışacak fonksiyon.
    receive() external payable {
        receiveCount++;
    }

    // Data içeren ether gönderme islemlerinde calisir.
    fallback() external payable {
        fallbackCount++;
    }
}