import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.model.dart';
import './product.model.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where(((product) => product.isFavorite)).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final String filterString =
        filterByUser ? 'orderBy="ownerId"&equalTo="$userId"' : '';
    final String url =
        'https://replace_this_with_your_url.firebaseio.com/products.json?auth=$authToken&$filterString';

    try {
      var response = await http.get(Uri.parse(url));
      var serverJsonData = json.decode(response.body) as Map<String, dynamic>;

      final favoriteUrl =
          'https://replace_this_with_your_url.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(Uri.parse(favoriteUrl));
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      serverJsonData.forEach((productId, productData) {
        loadedProducts.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite:
              favoriteData == null ? false : favoriteData[productId] ?? false,
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      if (error is SocketException) {
        return;
      }
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://replace_this_with_your_url.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'ownerId': userId,
        }),
      );
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);

      // _items.add(newProduct);
      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      return;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      final url =
          'https://replace_this_with_your_url.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[productIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProductById(String id) async {
    final url =
        'https://replace_this_with_your_url.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex =
        _items.indexWhere((product) => product.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode != 200) {
      // if db operation fails, restore the removed product in local memory
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Delete operation failed!');
    }
    // existingProduct = null;
  }
}
