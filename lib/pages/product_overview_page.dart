import "package:flutter/material.dart";

import '../widgets/product_grid.dart';
import "../components/my_components.dart";

class ProductOverViewPage extends StatelessWidget {
  const ProductOverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text("Favorites Only"),
                value: "Favorite",
              ),
              const PopupMenuItem(
                child: Text("Show All"),
                value: "Share",
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: const ProductGrid(),
    );
  }
}
