import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _edittedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );
  var _initValues = {
    "title": "",
    "description": "",
    "price": "",
    "imageUrl": ""
  };
  var _isInit = true;

  void _updateImageUrl() {
    // Update the image preview when we lose focus on the TextFormField of the image url
    if (!_imageUrlFocusNode.hasFocus) {
      // if (_imageUrlController.text.isEmpty ||
      //     (!_imageUrlController.text.startsWith("http") &&
      //         !_imageUrlController.text.startsWith("https")) ||
      //     (!_imageUrlController.text.endsWith(".png") &&
      //         !_imageUrlController.text.endsWith(".jpg") &&
      //         !_imageUrlController.text.endsWith("jpeg"))) {
      //   return;
      // }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState
        .validate(); // Trigger all available validators of the form fields
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_edittedProduct.id != null) {
      Provider.of<Products>(context, listen: false).updateProduct(
        _edittedProduct.id,
        _edittedProduct,
      );
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_edittedProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _edittedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          "title": _edittedProduct.title,
          "description": _edittedProduct.description,
          "price": _edittedProduct.price.toString(),
          "imageUrl": ""
        };
        _imageUrlController.text = _edittedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Need to dispose manually otherwise there will be memory leaks
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Title"),
                  initialValue: _initValues["title"],
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    // value is the string inputted into the field
                    // return "Some text"; // The error message is returned if there is error
                    // return null; // The input is always considered valid
                    if (value.isEmpty) {
                      return "Please provide a value";
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(
                        _priceFocusNode); // Transfer focus to the next text field
                  },
                  onSaved: (value) {
                    _edittedProduct = Product(
                      title: value,
                      price: _edittedProduct.price,
                      description: _edittedProduct.description,
                      imageUrl: _edittedProduct.imageUrl,
                      id: _edittedProduct.id,
                      isFavorite: _edittedProduct.isFavorite,
                    );
                  },
                ),
                TextFormField(
                    decoration: InputDecoration(labelText: "Price"),
                    initialValue: _initValues["price"],
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocusNode,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter a price value";
                      }
                      if (double.tryParse(value) == null) {
                        return "Please enter a valid price value";
                      }
                      if (double.parse(value) <= 0) {
                        return "Please enter a price value greater than 0";
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (value) {
                      _edittedProduct = Product(
                        title: _edittedProduct.title,
                        price: double.parse(value),
                        description: _edittedProduct.description,
                        imageUrl: _edittedProduct.imageUrl,
                        id: _edittedProduct.id,
                        isFavorite: _edittedProduct.isFavorite,
                      );
                    }),
                TextFormField(
                    decoration: InputDecoration(labelText: "Description"),
                    initialValue: _initValues["description"],
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    // textInputAction: TextInputAction.next, // A button to move to a new line will automatically be provided so we can't set anything here
                    // Also not possible to move our focus because we can't set the next button above

                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter a description";
                      }
                      if (value.length < 10) {
                        return "Description should be at least 10 characters long";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _edittedProduct = Product(
                        title: _edittedProduct.title,
                        price: _edittedProduct.price,
                        description: value,
                        imageUrl: _edittedProduct.imageUrl,
                        id: _edittedProduct.id,
                        isFavorite: _edittedProduct.isFavorite,
                      );
                    }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text("Enter a URL")
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      // Wrap into Expanded otherwise the TextFormField will take infinite width
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Image URL"),
                        // initialValue: _initValues["imageUrl"], // Cannot use this if already use a TextEdittingController
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter an image URL";
                          }
                          if (!value.startsWith("http") &&
                              !value.startsWith("https")) {
                            return "Please enter a valid URL";
                          }
                          // if (!value.endsWith(".png") &&
                          //     !value.endsWith(".jpg") &&
                          //     !value.endsWith("jpeg")) {
                          //   return "Please enter a valid image URL";
                          // }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) {
                          _edittedProduct = Product(
                            title: _edittedProduct.title,
                            price: _edittedProduct.price,
                            description: _edittedProduct.description,
                            imageUrl: value,
                            id: _edittedProduct.id,
                            isFavorite: _edittedProduct.isFavorite,
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
