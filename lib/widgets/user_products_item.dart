import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/add_or_edit_products_page.dart';
import '../providers/products.dart';

class UserProductsItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductsItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        trailing: SizedBox(
          width: MediaQuery.of(context).size.width * 0.40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // Edit products here.
                  Navigator.of(context).pushNamed(
                    AddOrEditProductsPage.pageName,
                    arguments: id,
                  );
                },
                child: Icon(
                  Icons.edit,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).accentColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Provider.of<Products>(context, listen: false).deleteItem(id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Product deleted successfully!"),
                    ),
                  );
                },
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
