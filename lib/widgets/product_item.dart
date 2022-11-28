import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../pages/product_detail_screen.dart";
import "../providers/product.dart";

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // // final double price;
  // final String imageUrl;
  // const ProductItem(this.id, this.title, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    // Make connection with the provider
    final product = Provider.of<Product>(context, listen: false);
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
          leading: Consumer<Product>(
            builder: (context, prdt, child) => IconButton(
              icon: Icon(
                prdt.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                prdt.toggleFavoriteStatus();
              },
            ),
          ),
          title: Text(
            product.title,
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
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
