import 'package:flutter/material.dart';

import '../pages/orders_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  List<Widget> drawerItem(
      BuildContext ctx, IconData icon, String title, String routeName) {
    return [
      Divider(),
      ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          Navigator.of(ctx).pushReplacementNamed(routeName);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Screens'),
            backgroundColor: Theme.of(context).accentColor,
          ),
          ...drawerItem(
            context,
            Icons.shop,
            "Shop",
            "/",
          ),
          ...drawerItem(
            context,
            Icons.request_quote,
            "Orders",
            OrdersPage.routeName,
          )
        ],
      ),
    );
  }
}
