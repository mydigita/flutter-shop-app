import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../widgets/order_items.dart';
import '../widgets/app_drawer.dart';

class OrderPage extends StatelessWidget {
  static const routeName = '/order-page';
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your orders')),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, index) =>
              OrderItems(order: orderData.orders[index])),
    );
  }
}
