import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_components.dart' show appBar;
import '../providers/order.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  static const routeName = '/orders-page';

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Future? ordersFetchAndSet;
  Future getFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    ordersFetchAndSet = getFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: appBar(const Text('Orders'), []),
      body: FutureBuilder(
        future: ordersFetchAndSet,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return const Center(child: Text('An error occured'));
            } else {
              return Consumer<Orders>(
                builder: (context, orderData, child) {
                  return orderData.orders.isEmpty
                      ? const Center(
                          child: Text('No orders'),
                        )
                      : ListView.builder(
                          itemCount: orderData.orders.length,
                          itemBuilder: (ctx, index) {
                            return OrderItem(orderData.orders[index]);
                          },
                        );
                },
              );
            }
          }
        },
      ),
    );
  }
}
