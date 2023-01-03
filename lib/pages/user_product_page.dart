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
  Future<Products> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchStoredProducts(true);
    return Provider.of<Products>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
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
      body: FutureBuilder<Products>(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      try {
                        await _refreshProducts(context);
                      } catch (error) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                                'Problem occured while refreshing the page!'),
                            backgroundColor: Theme.of(context).errorColor,
                          ),
                        );
                      }
                    },
                    child: snapshot.data!.items.isEmpty
                        ? const Center(
                            child: Text('No Products Found!'),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8),
                            child: ListView.builder(
                              itemCount: snapshot.data?.items.length,
                              itemBuilder: (_, index) {
                                final title = snapshot.data?.items[index].title;
                                final imageUrl =
                                    snapshot.data?.items[index].imageUrl;
                                return UserProductsItem(
                                  id: snapshot.data?.items[index].id,
                                  title: title!,
                                  imageUrl: imageUrl!,
                                );
                              },
                            ),
                          ),
                  ),
      ),
    );
  }
}
