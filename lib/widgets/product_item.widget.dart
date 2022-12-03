import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/product_details.page.dart';
import '../providers/product.model.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // final double price;
  // const ProductItem({
  //   super.key,
  //   required this.id,
  //   required this.title,
  //   required this.imageUrl,
  //   required this.price,
  // });

  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        header: Text(
          'Product ID: ${product.id.toUpperCase()}',
        ),
        footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
                onPressed: () {
                  product.toggleFavoriteStatus();
                },
                color: Theme.of(context).primaryColor,
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border)),
            trailing: IconButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                icon: const Icon(Icons.shopping_cart)),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            )),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsPage.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
