import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/product_overview.page.dart';
import './pages/product_details.page.dart';
import './providers/products_provider.dart';

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
        title: 'flutter-shop-app',
        theme: ThemeData(primarySwatch: Colors.pink),
        home: const ProductsOverviewPage(),
        routes: {
          ProductDetailsPage.routeName: ((context) =>
              const ProductDetailsPage())
        },
      ),
    );
  }
}