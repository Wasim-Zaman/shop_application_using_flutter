import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/user_products_item.dart';
import '../components/my_components.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

class UserProductPage extends StatelessWidget {
  const UserProductPage({super.key});

  static const String pageName = '/user-products-page';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: appBar(const Text('Your Products'), []),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, index) {
              return UserProductsItem(
                title: productsData.items[index].title,
                imageUrl: productsData.items[index].imageUrl,
              );
            }),
      ),
    );
  }
}
