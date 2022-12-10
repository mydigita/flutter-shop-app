import 'package:flutter/material.dart';
import '../providers/product.model.dart';
// import '../providers/products_provider.dart';

class EditProductPage extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: "", title: "", description: "", price: 0, imageUrl: "");

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveFormData() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    // print(_editedProduct.title);
    // print(_editedProduct.description);
    // print(_editedProduct.price);
    // print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveFormData, icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _form,
          child: ListView(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please provide a title';
                }
                return null;
              },
              onSaved: (newValue) {
                _editedProduct = Product(
                    id: _editedProduct.id,
                    title: newValue!,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              onSaved: (newValue) {
                _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(
                        newValue!.trim().replaceAll(RegExp('[^0-9.]'), '')),
                    imageUrl: _editedProduct.imageUrl);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please provide price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                if (double.parse(value) <= 0) {
                  return 'Please enter a valid price';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              onSaved: (newValue) {
                _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: newValue!,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please provide descripton';
                }
                if (value.length < 20) {
                  return 'Please add more details';
                }
                return null;
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: _imageUrlController.text.isEmpty
                      ? const Text('Enter a Url')
                      : FittedBox(
                          fit: BoxFit.cover,
                          child: Image.network(_imageUrlController.text),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text('Image url')),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onEditingComplete: () {
                      setState(() {});
                    },
                    onFieldSubmitted: (_) {
                      _saveFormData();
                    },
                    onSaved: (newValue) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: newValue!);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a url';
                      }
                      if (!value.startsWith('http://') ||
                          !value.startsWith('https://')) {
                        return 'Please add a valid url';
                      }
                      if (!value.endsWith('jpg') ||
                          !value.endsWith('jpeg') ||
                          !value.endsWith('png')) {
                        return 'Please add a photo-source url';
                      }
                      return null;
                    },
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
