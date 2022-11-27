import "package:flutter/material.dart";

import '../widgets/product_grid.dart';

class ProductOverViewPage extends StatelessWidget {
  const ProductOverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: const Text("Shop"),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: const ProductGrid(),
    );
  }
}
