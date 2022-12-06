import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  const CartItem({
    super.key,
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(
              child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: FittedBox(child: Text('$price')),
          )),
          title: Text(title),
          subtitle: Text('Total: \$ ${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
