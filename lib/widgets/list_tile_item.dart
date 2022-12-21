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
            OrderButton(cartData: cartData),
          ],
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cartData,
  }) : super(key: key);

  final Cart cartData;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cartData.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              // order your product now
              print('inside order');
              if (widget.cartData.items.values.isNotEmpty) {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                    widget.cartData.items.values.toList(),
                    widget.cartData.totalAmount);
                setState(() {
                  _isLoading = false;
                });
                widget.cartData.clear();
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('No products in cart!'),
                    backgroundColor: Theme.of(context).errorColor,
                  ),
                );
              }
            },
      child: Text(
        "ORDER NOW",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
