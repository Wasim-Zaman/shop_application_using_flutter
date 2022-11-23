import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "./pages/product_overview_page.dart";
import './pages/product_detail_screen.dart';

import "./providers/products.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Shop Application",
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          primarySwatch: Colors.green,
          // ignore: deprecated_member_use
          accentColor: Colors.deepPurple,
          fontFamily: "Lato",
        ),
        // home: ProductOverViewPage(),
        routes: {
          "/": (context) => const ProductOverViewPage(),
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
        },
      ),
    );
  }
}
