import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/edit_product.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(
      {super.key,
      required this.id,
      required this.title,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        color: null,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductPage.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
                onPressed: () {
                  Provider.of<Products>(context, listen: false)
                      .deleteProductById(id);
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
