import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/add_or_edit_products_page.dart';
import '../widgets/user_products_item.dart';
import '../components/my_components.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

class UserProductPage extends StatelessWidget {
  const UserProductPage({super.key});

  static const String pageName = '/user-products-page';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchStoredProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: appBar(
        const Text('Your Products'),
        [
          IconButton(
            onPressed: () {
              // Navigate to the add / edit products page
              Navigator.of(context).pushNamed(AddOrEditProductsPage.pageName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: productsData.items.length,
              itemBuilder: (_, index) {
                return UserProductsItem(
                  id: productsData.items[index].id,
                  title: productsData.items[index].title,
                  imageUrl: productsData.items[index].imageUrl,
                );
              }),
        ),
      ),
    );
  }
}
