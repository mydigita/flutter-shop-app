import 'package:flutter/material.dart';
import '../providers/order_provider.dart';
import 'package:intl/intl.dart';

class OrderItems extends StatelessWidget {
  final OrderItem order;
  const OrderItems({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$ ${order.amount}'),
          subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(order.dateTime)),
          trailing: IconButton(
            icon: const Icon(Icons.expand_more),
            onPressed: () {},
          ),
        )
      ]),
    );
  }
}
