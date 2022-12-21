import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cart.dart';

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
  final List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
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
      print('order placed successfully1');
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
