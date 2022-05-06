// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.2;

contract Modifiers {

    enum OrderStatus {
        Taken, //0
        Preparing, //1
        Boxed, //2
        Shipped //3
    }

    struct Order {
        address customer;
        string zipCode;
        uint256[] products;
        OrderStatus status;
    }

    Order[] public orders;
    address public owner; // contractı olusutran kisi. Magaza yoneticisi
    uint256 public txCount;

    constructor(){
        owner = msg.sender;
    }

    // ********* NOT: Butun function lara sadece dışarıdan erişeleceği için external olarak işaretlendi. ***********

    function createOrder(string memory _zipCode, uint256[] memory _products) checkProducts(_products) external returns(uint256) { // Order Id return edecek.
        //require(_products.length > 0, "No products.");

        // 2. Yontem
        orders.push(
            Order({
                customer: msg.sender,
                zipCode: _zipCode,
                products: _products,
                status: OrderStatus.Taken
            })
        );

        return orders.length - 1;
    }

    function advanceOrder(uint256 _orderId) checkOrderId(_orderId) onlyOwner external {
        // Mesajı gönderen kişi magaza yoneticisi mi kontrolu...
        //require(owner == msg.sender, "You are not authorized.");

        // Gelen Order Id parametresi validate ediliyor...
        //require(_orderId < orders.length, "Nor a valid Order Id.");

        // Siparis shipped edilmis mi kontrolu...
        Order storage order = orders[_orderId];
        require(order.status != OrderStatus.Shipped, "Order is already shipped.");

        if(order.status == OrderStatus.Taken) {
            order.status = OrderStatus.Preparing;
        } else if(order.status == OrderStatus.Preparing) {
            order.status = OrderStatus.Boxed;
        } else if(order.status == OrderStatus.Boxed) {
            order.status = OrderStatus.Shipped;
        }
    }

    function getOrder(uint256 _orderId) checkOrderId(_orderId) external view returns(Order memory) {
        //require(_orderId < orders.length, "Nor a valid Order Id.");

        return orders[_orderId];
    }

    function updateZip(uint256 _orderId, string memory _zipCode) checkOrderId(_orderId) onlyCustomer(_orderId) incTx external {
        //require(_orderId < orders.length, "Nor a valid Order Id.");
        Order storage order = orders[_orderId];

        //require(order.customer == msg.sender, "You are not the owner of the order.");
        order.zipCode = _zipCode;
    }

    modifier checkProducts(uint256[] memory _products) {
        require(_products.length > 0, "No products.");
        _; // Bu ifade modifier ı kullanan function ın gövdesini temsil ediyor. senaryoya göre require dan önce de sonra da yazılabilir
    }

    modifier checkOrderId(uint256 _orderId) {
        require(_orderId < orders.length, "Nor a valid Order Id.");
        _;
    }

    modifier incTx {
        _;
        txCount++;
    }

    modifier onlyOwner {
        require(owner == msg.sender, "You are not authorized.");
        _;
    }

    modifier onlyCustomer(uint256 _orderId) {
        require(orders[_orderId].customer == msg.sender, "You are not the owner of the order.");
        _;
    }
}