import 'package:flutter/material.dart';

import "./pages/product_overview_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shop Application",
      home: ProductOverViewPage(),
    );
  }
}
