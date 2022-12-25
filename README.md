# flutter_shop_app

* Replace all the url in lib/providers/products_provider.dart file with yours one.
* Replace all the url in lib/providers/product.model.dart file
* Replace all the url in lib/providers/order_provider.dart file
* Replace all the url in lib/providers/cart_provider.dart file
* Replace all the url in lib/providers/auth_provider.dart file



## Firebase rules 

```json
{
  "rules": {
    ".read": "auth !=null",  
    ".write": "auth !=null",
    "products":{
      ".indexOn": ["ownerId"]
    }
  }
}


```