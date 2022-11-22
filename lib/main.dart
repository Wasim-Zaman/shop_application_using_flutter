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
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.deepPurple,
        fontFamily: "Lato",
      ),
      home: ProductOverViewPage(),
    );
  }
}
