// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.2;

contract Functions {
    /*
    uint public luckyNumber = 7;

    function showNumber() public view returns(uint) { // view sadece okuma yapılacağını belirtir.
        return luckyNumber;
    }

    function setNumber(uint newNumber) public {
        luckyNumber = newNumber;
    }

    function nothing() public pure returns(uint x, bool y, bool z) {
        // return (5,  true, false); // returns kısmında return edilecek değişkenlere isim verilmediğinde bu şekilde return ediliyor.
        
        // returns kısmında değişkenlere isim verildiğinde bu şekilde set edilerek return ediliyor.
        x = 6;
        y = true;
        z = false;
    }
    */

    uint x = 3;

    function setX(uint y) public view returns(uint) {
        return x + y;
    }

    function add(uint a, uint b) public pure returns(uint) {
        return a + b;
    }

    // contract üzerindeki herhangi bir değeri okuma yapmadığı durumda pure anahtar kelimesi kullanılır.
    function add2(uint c, uint d) public pure returns (uint) {
        //return a + b;
        return add(c,d);
    }


    // Access modifiers
    // public, private, internal, external
    // public: bu fonksiyon hem contract tarafından hem de dışarıdan çağrılabilir.

    function publicKeyword() public pure returns (string memory) {
        return "This is a public function.";
    }

    function callPublicKeyword() public pure returns(string memory) {
        return publicKeyword();
    }


    // private: Bu fonksiyona sadece ilgili contract içerisinden erişilebilir. Dışarıdan erişim yoktur.

    function privateKeyword() private pure returns(string memory) {
        return "This is a private function.";
    }

    function callPrivateKeyword() public pure returns(string memory) {
        return privateKeyword();
    }


    //internal: Bu fonksiyona ilgili contract içerisinden ve bu contractı inherit eden contractlar içerisinden erişilebilir. Dışarıdan erişim yoktur.
    function internalKeyword() internal pure returns(string memory) {
        return "This is a internal function.";
    }

    function callInternalKeyword() public pure returns(string memory) {
        return internalKeyword();
    }


    // external: Dışarıdan çağrılabilir. Contract içerisinden çağırılamaz.
    function externalKeyword() external pure returns(string memory) {
        return "This is a external function";
    }

    // Hatalı kullanım. external function lara contract içerisinden erişim yoktur.
    /*function callExternalKeyword() public pure returns(string memory) {
        return externalKeyword();
    } */

}