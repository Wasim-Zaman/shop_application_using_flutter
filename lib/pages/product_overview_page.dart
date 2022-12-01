import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../components/my_components.dart";
import '../widgets/product_grid.dart';
import "../providers/cart.dart";
import "../widgets/badge.dart";

class ProductOverViewPage extends StatefulWidget {
  const ProductOverViewPage({super.key});

  @override
  State<ProductOverViewPage> createState() => _ProductOverViewPageState();
}

class _ProductOverViewPageState extends State<ProductOverViewPage> {
  var _isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: appBar(
        const Text(
          "Shop Application",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
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
              print(value);
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
          Badge(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
            ),
            value: cartData.countCarts.toString(),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ProductGrid(_isFavorite),
    );
  }
}
