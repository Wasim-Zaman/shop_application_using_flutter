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

  Map<String, CartItem> _items = {};

  // create a getter
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get countCarts {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.quantity * value.price;
    });
    return total;
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
        ),
      );
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

  void deleteItem(String key) {
    _items.remove(key);
    notifyListeners();
  }

  void removeSingleCartItem(String productId) {
    if (!_items.containsKey(productId)) {
      // if the items does not contain specific product id
      return;
    }
    // romove single quantity from the cart if user press undo
    if (_items[productId]!.quantity > 1) {
      // if there are more then one items in the cart items, then
      // remove only one quantity from it.
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          price: existingItem.price,
          title: existingItem.title,
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      // if there is only one item inside _items, then remove overall product
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
