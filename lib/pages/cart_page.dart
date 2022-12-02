import "package:flutter/material.dart";
import "package:provider/provider.dart";

import '../components/my_components.dart';
import '../providers/cart.dart'
    show Cart; // in order to avoid CartItem confusion
import '../widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static const pageName = '/cart-page';

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: appBar(
        const Text("Cart Page"),
        [],
      ),
      body: Column(
        children: [
          Card(
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
                      '\$${cartData.totalAmount}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {},
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
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CartItem(
                  price: cartData.items.values.toList()[index].price,
                  id: cartData.items.values.toList()[index].id,
                  title: cartData.items.values.toList()[index].title,
                  quantity: cartData.items.values.toList()[index].quantity,
                );
              },
              itemCount: cartData.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
