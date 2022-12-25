// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import './pages/add_or_edit_products_page.dart';
import "./pages/product_overview_page.dart";
import './pages/product_detail_screen.dart';
import './pages/user_product_page.dart';
import './pages/auth_screen.dart';
import './pages/orders_page.dart';
import './pages/cart_page.dart';

import "./providers/products.dart";
import "./providers/order.dart";
import "./providers/cart.dart";
import './providers/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Shop",
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          fontFamily: "Lato",
          primaryColor: Colors.deepOrange,
          accentColor: Colors.deepOrangeAccent,
        ),
        // home: ProductOverViewPage(),
        routes: {
          "/": (context) => const AuthScreen(),
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
          CartPage.pageName: (context) => const CartPage(),
          OrdersPage.routeName: (context) => const OrdersPage(),
          UserProductPage.pageName: (context) => const UserProductPage(),
          AddOrEditProductsPage.pageName: (context) =>
              const AddOrEditProductsPage(),
        },
      ),
    );
  }
}
