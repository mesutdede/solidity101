// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.2;

contract Structs {

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

    constructor(){
        owner = msg.sender;
    }

    // ********* NOT: Butun function lara sadece dışarıdan erişeleceği için external olarak işaretlendi. ***********

    function createOrder(string memory _zipCode, uint256[] memory _products) external returns(uint256) { // Order Id return edecek.
        require(_products.length > 0, "No products.");

        // 1. Yontem
        // Order memory order;
        // order.customer = msg.sender;
        // order.zipCode = _zipCode;
        // order.products = _products;
        // order.status = OrderStatus.Taken;
        //orders.push(order);

        // 2. Yontem
        orders.push(
            Order({
                customer: msg.sender,
                zipCode: _zipCode,
                products: _products,
                status: OrderStatus.Taken
            })
        );

        // 3. Yontem
        //orders.push(Order(msg.sender, _zipCode, _products, OrderStatus.Taken ));

        return orders.length - 1;
    }

    function advanceOrder(uint256 _orderId) external {
        // Mesajı gönderen kişi magaza yoneticisi mi kontrolu...
        require(owner == msg.sender, "You are not authorized.");

        // Gelen Order Id parametresi validate ediliyor...
        require(_orderId < orders.length, "Nor a valid Order Id.");

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

    function getOrder(uint256 _orderId) external view returns(Order memory) {
        require(_orderId < orders.length, "Nor a valid Order Id.");

        /*
        Order memory order = orders[_orderId];
        return order;
        */

        return orders[_orderId];
    }

    function updateZip(uint256 _orderId, string memory _zipCode) external {
        require(_orderId < orders.length, "Nor a valid Order Id.");
        Order storage order = orders[_orderId];

        require(order.customer == msg.sender, "You are not the owner of the order.");
        order.zipCode = _zipCode;
    }
}