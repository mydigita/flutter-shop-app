import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import './edit_product.dart';

class UserProductPage extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductPage.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, index) => Column(
            children: [
              UserProductItem(
                title: productData.items[index].title,
                imageUrl: productData.items[index].imageUrl,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
