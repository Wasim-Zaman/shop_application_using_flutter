import "package:flutter/material.dart";

import "../pages/product_detail_screen.dart";

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  // final double price;
  final String imageUrl;
  const ProductItem(this.id, this.title, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13.0),
      child: GridTile(
        // header: GridTileBar(
        //   backgroundColor: Colors.white60,
        //   leading: Text(
        //     "\$ ${price.toStringAsFixed(3)}",
        //     textAlign: TextAlign.center,
        //   ),
        // ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ),
        child: GestureDetector(
          onTap: () {
            // navigate to the next product details screen.
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: id,
            );
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
