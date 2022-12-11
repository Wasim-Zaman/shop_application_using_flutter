import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_components.dart' show appBar;
import '../providers/order.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  static const routeName = '/orders-page';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: appBar(const Text('Orders'), []),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, index) {
          return OrderItem(orderData.orders[index]);
        },
      ),
    );
  }
}
