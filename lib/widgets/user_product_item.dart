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
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,

          // if image url does not work, load a sample image from app assets
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return Image.asset(
              'assets/images/image_not_found.jpg',
              fit: BoxFit.cover,
            );
          },
        ),
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
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .deleteProductById(id);
                  } catch (error) {
                    scaffoldMessenger.hideCurrentSnackBar();
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Delete operation failed!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
