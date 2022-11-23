import "package:flutter/material.dart";

import '../widgets/product_grid.dart';

class ProductOverViewPage extends StatelessWidget {
  const ProductOverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: const Text("Shop"),
    );

    return Scaffold(
      appBar: appBar,
      body: const ProductGrid(),
    );
  }
}
