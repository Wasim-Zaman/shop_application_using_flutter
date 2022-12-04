import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.id,
    required this.productKey,
    required this.title,
    required this.price,
    required this.quantity,
  });

  final String id;
  final String productKey;
  final String title;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(productKey),
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).deleteItem(productKey);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: FittedBox(
              child: Text(
                "\$$price",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${quantity * price}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
