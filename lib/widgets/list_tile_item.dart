import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import "../providers/order.dart";
import "../providers/cart.dart";

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    Key? key,
    required this.cartData,
  }) : super(key: key);

  final Cart cartData;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      borderOnForeground: true,
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Spacer(),
            Chip(
              label: Text(
                '\$${cartData.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            TextButton(
              onPressed: () {
                // order your product now
                if (cartData.items.values.isNotEmpty) {
                  Provider.of<Orders>(context, listen: false).addOrder(
                      cartData.items.values.toList(), cartData.totalAmount);
                  cartData.clear();
                } else {
                  print("No Products in a cart");
                }
              },
              child: Text(
                "ORDER NOW",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
