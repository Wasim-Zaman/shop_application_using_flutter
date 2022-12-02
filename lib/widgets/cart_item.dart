import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });

  final String id;
  final String title;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: const FittedBox(
            child: Text(
              "\$price",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Text(title),
        subtitle: Text('Total: \$${quantity * price}'),
        trailing: Text('$quantity x'),
      ),
    );
  }
}
