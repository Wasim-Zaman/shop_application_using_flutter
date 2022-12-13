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
      confirmDismiss: (direction) => showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              title: const Text('Are you sure?'),
              content: const Text('Do you really want to delete cart item?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Cart item deleted',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.red,
                        dismissDirection: DismissDirection.down,
                      ),
                    );
                    Navigator.of(ctx).pop(true);
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          }),
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
