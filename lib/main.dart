import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/auth_provider.dart';
import './pages/product_overview.page.dart';
import './pages/product_details.page.dart';
import './providers/products_provider.dart';
import './providers/cart_provider.dart';
import './pages/cart_page.dart';
import './providers/order_provider.dart';
import './pages/order_page.dart';
import './pages/user_product_page.dart';
import './pages/edit_product.dart';
import './pages/auth_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (contex) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (context) => Products('', []),
            update: (context, authValue, previousProduct) => Products(
                authValue.token,
                previousProduct == null ? [] : previousProduct.items),
          ),
          ChangeNotifierProvider(create: (contex) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
              create: ((context) => Orders('', [])),
              update: ((context, authValue, previousOrder) => Orders(
                  authValue.token,
                  previousOrder == null ? [] : previousOrder.orders))),
        ],
        child: Consumer<Auth>(
          builder: (context, authValue, child_) => MaterialApp(
            title: 'flutter-shop-app',
            theme: ThemeData(primarySwatch: Colors.pink),
            home: authValue.isAuth
                ? const ProductsOverviewPage()
                : const AuthPage(),
            routes: {
              ProductDetailsPage.routeName: (context) =>
                  const ProductDetailsPage(),
              CartPage.routeName: (context) => const CartPage(),
              OrderPage.routeName: (context) => const OrderPage(),
              UserProductPage.routeName: (context) => const UserProductPage(),
              EditProductPage.routeName: (context) => const EditProductPage(),
              AuthPage.routeName: (context) => const AuthPage(),
            },
          ),
        ));
  }
}
