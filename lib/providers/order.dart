import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/no_products_exception.dart';
import './cart.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    const url =
        'https://shop-application-296aa-default-rtdb.firebaseio.com/orders.json';

    final List<Order> listOfOrders = [];
    try {
      final response = await http.get(Uri.parse(url));
      print("response body *****\t${json.decode(response.body)}\t*****");
      if (json.decode(response.body) == null) {
        throw NoProductsException('No order found');
      }
      final extractedOrders =
          json.decode(response.body) as Map<String, dynamic>;

      extractedOrders.forEach((orderId, orderInfo) {
        listOfOrders.add(
          Order(
            id: orderId,
            amount: orderInfo['amount'],
            dateTime: DateTime.parse(orderInfo['dateTime']),
            products: (orderInfo['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    price: item['price'],
                    quantity: item['quantity'],
                  ),
                )
                .toList(),
          ),
        );
      });
      _orders = listOfOrders;
      notifyListeners();
      print('done');
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double totalAmount) async {
    const url =
        'https://shop-application-296aa-default-rtdb.firebaseio.com/orders.json';
    final dateTime = DateTime.now();
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            "amount": totalAmount,
            "dateTime": dateTime.toIso8601String(),
            "products": cartProducts
                .map((cartProduct) => {
                      "id": cartProduct.id,
                      "title": cartProduct.title,
                      "quantity": cartProduct.quantity,
                      "price": cartProduct.price,
                    })
                .toList(),
          },
        ),
      );
      _orders.insert(
        0,
        Order(
          id: json.decode(response.body)['name'],
          amount: totalAmount,
          products: cartProducts,
          dateTime: dateTime,
        ),
      );
      print('order placed successfully!');
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
