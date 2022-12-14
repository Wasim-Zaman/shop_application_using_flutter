import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../components/my_components.dart";
import '../providers/products.dart';
import '../widgets/product_grid.dart';
import "../providers/cart.dart";
import "../widgets/badge.dart";
import "../pages/cart_page.dart";
import '../widgets/app_drawer.dart';

class ProductOverViewPage extends StatefulWidget {
  const ProductOverViewPage({super.key});

  @override
  State<ProductOverViewPage> createState() => _ProductOverViewPageState();
}

class _ProductOverViewPageState extends State<ProductOverViewPage> {
  var _isFavorite = false;
  var _isLoading = false;
  var _isException = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Products>(context, listen: false)
          .fetchStoredProducts()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        print('******* Inside except block *********');
        setState(() {
          _isException = true;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: appBar(
        const Text(
          "Shop",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: "Lato",
          ),
        ),
        <Widget>[
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: "Favorite",
                child: Text("Favorites Only"),
              ),
              const PopupMenuItem(
                value: "All",
                child: Text("Show All"),
              ),
            ],
            onSelected: (String value) {
              // print(value);
              // if (value == "Favorite") {
              //   productData.showFavoritesOnly();
              // } else {
              //   productData.showAll();
              // }
              setState(() {
                if (value == "Favorite") {
                  _isFavorite = true;
                } else {
                  _isFavorite = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
          ),
          Consumer(
            builder: (_, cart, ch) => Badge(
              value: cartData.countCarts.toString(),
              child: ch!,
            ),
            child: IconButton(
              onPressed: () {
                // Navigate to cart page
                Navigator.pushNamed(context, CartPage.pageName);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: _isException
          ? const SizedBox(
              height: double.infinity,
              child: Center(
                child: Text('No products found!'),
              ),
            )
          : (_isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ProductGrid(_isFavorite)),
    );
  }
}
