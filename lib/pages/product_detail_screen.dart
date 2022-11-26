import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "../providers/products.dart";

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product-detail-screen";
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context)?.settings.arguments as String;

    final loadedProduct =
        Provider.of<Products>(context, listen: false).getElementById(productId);
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(loadedProduct.imageUrl),
          ),
          title: Text(loadedProduct.title),
        ),
      ),
    );
  }
}
