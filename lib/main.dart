import 'package:flutter/material.dart';

import "./pages/product_overview_page.dart";
import './pages/product_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        "/": (context) => ProductOverViewPage(),
        ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
      },
    );
  }
}
