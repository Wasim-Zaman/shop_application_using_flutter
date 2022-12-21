import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  // ignore: prefer_typing_uninitialized_variables
  final id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://shop-application-296aa-default-rtdb.firebaseio.com/products/$id.json';

    try {
      print('inside try block');
      final response = await http.patch(Uri.parse(url),
          body: json.encode({
            'isFavorite': isFavorite,
          }));

      if (response.statusCode >= 400) {
        // print('Some issue while favoriting !');
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      // print('inside catch block');
      // roll back the old value.
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
