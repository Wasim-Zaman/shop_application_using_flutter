import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import '../components/my_components.dart';
import '../models/no_products_exception.dart';
import '../models/http_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String authToken;
  final userId;

  Products(this.authToken, this._items, this.userId);
  // var _showFavoritesOnly = false;
  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((productItem) => productItem.isFavorite).toList();
    // }
    return [..._items]; // return a copy of the list of items not original
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Product getElementById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  // method that will return a list of favorite items
  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite == true).toList();
  }

  Future<void> fetchStoredProducts([bool filterById = false]) async {
    final filterString = filterById ? 'orderBy="userId"&equalTo="$userId"' : '';
    var url =
        'https://shop-application-296aa-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(Uri.parse(url));
      final List<Product> listOfLoadedProducts = [];
      // checking the type of the response.

      print("Body = = = ${json.decode(response.body)}");

      if (json.decode(response.body) == null) {
        throw NoProductsException('No products found');
      }
      url =
          'https://shop-application-296aa-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(Uri.parse(url));
      final favoriteData = json.decode(favoriteResponse.body);
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      responseBody.forEach((productId, productData) {
        final Product newProduct = Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite:
              favoriteData == null ? false : favoriteData[productId] ?? false,
        );
        listOfLoadedProducts.add(newProduct);
      });
      _items = listOfLoadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addItem(Product product) async {
    final url =
        'https://shop-application-296aa-default-rtdb.firebaseio.com/products.json?auth=$authToken';

    // return http
    //     .post(
    //   Uri.parse(url),
    //   body: json.encode(
    //     {
    //       'id': product.id,
    //       'title': product.title,
    //       'price': product.price,
    //       'description': product.description,
    //       'imageUrl': product.imageUrl,
    //       'isFavorite': product.isFavorite,
    //     },
    //   ),
    // )
    //     .then((response) {
    //   final body = json.decode(response.body);
    //   print("Body: $body");
    //   print("Status code: ${response.statusCode}");

    //   final newProduct = Product(
    //     id: body['name'],
    //     title: product.title,
    //     description: product.title,
    //     price: product.price,
    //     imageUrl: product.imageUrl,
    //   );
    //   _items.add(newProduct);
    //   notifyListeners();
    // }).catchError((error) {
    //   print('error');
    //   throw error;
    // });
    // This method will notify all the listeners for the update

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'id': product.id,
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'userId': userId,
          },
        ),
      );

      final body = json.decode(response.body);
      print("Body: $body");
      print("Status code: ${response.statusCode}");

      final newProduct = Product(
        id: body['name'],
        title: product.title,
        description: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print('error');
      rethrow;
    }
  }

  Future<void> updateItem(String id, Product product) async {
    final productIndex = _items.indexWhere((item) => item.id == id);

    if (productIndex >= 0) {
      final url =
          'https://shop-application-296aa-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );
      _items[productIndex] = product;
      notifyListeners();
    } else {
      // print('Item not found');
    }
  }

  Future<void> deleteItem(String id) async {
    final url =
        'https://shop-application-296aa-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    final deletedProductIndex =
        _items.indexWhere((element) => element.id == id);
    Product? deletedProduct = _items.elementAt(deletedProductIndex);
    _items.removeAt(deletedProductIndex);
    notifyListeners();

    try {
      final response = await http.delete(Uri.parse(url));
      print("The response status code is: '${response.statusCode}'");
      if (response.statusCode >= 400) {
        _items.insert(deletedProductIndex, deletedProduct);
        notifyListeners();
        throw HttpException('Product could not be deleted!');
      }
      print('product deleted successfully');
      deletedProduct = null;
    } catch (error) {
      print('internet problem');
      rethrow;
    }
  }
}
