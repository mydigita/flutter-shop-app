import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/product_details.page.dart';
import '../providers/product.model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    //don't listen for whole widgets - listen false
    // but it will listen where required through Consumer
    final product = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        header: Text(
          'Product ID: ${product.id.toUpperCase()}',
        ),
        footer: GridTileBar(
            backgroundColor: Colors.black87,

            // consume updates only where you want
            //and only this widget will be rebuilt

            leading: Consumer<Product>(
              builder: (ctx, prod, child) => IconButton(
                onPressed: () {
                  product.toggleFavoriteStatus();
                },
                color: Theme.of(context).primaryColor,
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
              ),
            ),
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
