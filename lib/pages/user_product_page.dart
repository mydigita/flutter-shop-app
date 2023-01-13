import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import './edit_product.dart';

class UserProductPage extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductPage({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => _refreshProducts(context),
                child: Consumer<Products>(
                  builder: (ctx, productData, _) => productData.items.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                            itemCount: productData.items.length,
                            itemBuilder: (_, index) => Column(
                              children: [
                                UserProductItem(
                                  id: productData.items[index].id,
                                  title: productData.items[index].title,
                                  imageUrl: productData.items[index].imageUrl,
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                        )
                      : const Center(
                          child: Text(
                          'You have no product!',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        )),
                ),
              ),
      ),
    );
  }
}
