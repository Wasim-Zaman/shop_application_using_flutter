import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  // Creating a list of CartItems, but each CartItem will belong to
  // specific product id

  final Map<String, CartItem> _items = {};

  // create a getter
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get countCarts {
    return _items.length;
  }

  // Adding CartItem into the existing list of CartItme
  void addCartItem(String productId, String title, double price) {
    // Check if the product is already added to the cart
    if (_items.containsKey(productId)) {
      // Increase the quantity of the cart
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                price: existingCartItem.price,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      // Add new cart into the map
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          title: title,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
}
