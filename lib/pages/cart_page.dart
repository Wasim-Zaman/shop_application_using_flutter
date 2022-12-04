import "package:flutter/material.dart";
import "package:provider/provider.dart";

import '../widgets/total_price_list_tile_item.dart';
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
          TotalPriceListTile(cartData: cartData),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CartItem(
                  price: cartData.items.values.toList()[index].price,
                  productKey: cartData.items.keys.toList()[index],
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
