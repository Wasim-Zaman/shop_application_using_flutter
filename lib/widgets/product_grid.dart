import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../widgets/product_item.dart';
import "../providers/products.dart";

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  const ProductGrid(this.showFavoriteOnly, {super.key});

  @override
  Widget build(BuildContext context) {
    // Make connection with the provider
    final productsInstance = Provider.of<Products>(context);
    final products = showFavoriteOnly
        ? productsInstance.favoriteItems
        : productsInstance.items;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        // print(
        // '^^^^^^^ ${products[index].isFavorite} ^^^^^^^ \n ${products[index].title}');
        return Container(
          padding: const EdgeInsets.all(5.0),
          child: ChangeNotifierProvider.value(
            value: products[index],
            // create: (context) => products[index],
            child: const ProductItem(
                // products[index].id,
                // products[index].title,
                // // products[index].price,
                // products[index].imageUrl,
                ),
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
