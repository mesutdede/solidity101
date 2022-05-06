// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.2;

contract Variables {
    // Fixed-size types
    bool isValid = true;

    int number = 10; // = int256. -2^256 to 2^256
    int8 number2 = 10; // -2^8 to 2^8
    uint number3 = 10; // = uint256. 0 to 2^256

    address myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; // 20 byte uzunluğunda.
    bytes32 name1 = "dede"; // bytes olarak tanımlandığında dinamik olur. uzunluk verilerek fixed type olarak tanımlanır.


    // Dynamic-size types
    string name2 = "itu blockchain";
    bytes name3 = "itu bc";

    uint[] array = [1, 2, 3, 4, 5];

    mapping(uint => address) list;
    //list[4] = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4";


    // User defined value types

    struct Human {
        uint ID;
        string name;
        uint age;
        address addr;
    }

    mapping(uint => Human) list2;

    Human person1 = Human({
        ID: 1234567,
        name: "mesut",
        age: 34,
        addr: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    });

    enum trafficLight {
        RED,
        YELLOW,
        GREEEN
    }

    
    // mapping ler function içinde set edilebiliyor. aksi taktirde hata veriyor. !!!
    function sendHuman(Human memory hmn) public {
        list2[2] = hmn;
    }

    // 1 eth = 10^18 wei
    // 1 gwei = 10^9 wei


    // state variable
    string public bestClub = "ITU Blockchain";

    function show() public pure returns(uint) {
        uint num = 17;
        return num;
    }

    function show2() public view returns(address) {
        // global variables
        block.number;
        block.difficulty;
        block.gaslimit;
        block.timestamp;
        
        return msg.sender;
    }
}