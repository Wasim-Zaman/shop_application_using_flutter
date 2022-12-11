import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "../providers/products.dart";
import '../components/my_components.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});
  static const routeName = "/product-detail-screen";

  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context)?.settings.arguments as String;

    final loadedProduct =
        Provider.of<Products>(context, listen: false).getElementById(productId);
    return Scaffold(
      appBar: appBar(
        Text(
          loadedProduct.title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "\$${loadedProduct.price}",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
