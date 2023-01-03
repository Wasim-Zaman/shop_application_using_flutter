import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../pages/product_detail_screen.dart";

import "../providers/product.dart";
import "../providers/cart.dart";
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  // final String id;
  // final String title;
  // // final double price;
  // final String imageUrl;
  // const ProductItem(this.id, this.title, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    // Make connection with the provider
    final product = Provider.of<Product>(context, listen: false);
    final cartData = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(13.0),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(builder: (context, prdt, child) {
            // print('######## ${prdt.isFavorite} *******');
            return IconButton(
              icon: Icon(
                prdt.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                final token = Provider.of<Auth>(context, listen: false).token!;
                final userId =
                    Provider.of<Auth>(context, listen: false).userId!;

                prdt.toggleFavoriteStatus(token, userId);
              },
            );
          }),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Add product into the cart
              cartData.addCartItem(product.id, product.title, product.price);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Item added to cart!'),
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      cartData.removeSingleCartItem(product.id);
                    },
                  ),
                ),
              );
            },
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
