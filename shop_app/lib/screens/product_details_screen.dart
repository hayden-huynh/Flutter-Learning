import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final String productTitle;
  // ProductDetailsScreen(this.productTitle);

  static const routeName = '/product-details-screen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;

    final loadedProduct = Provider.of<Products>(context, listen: false).findById(
        productId); // By default, 'listen' is true i.e. UI is rebuilt whenever there is a data change. Set it to false to switch off that effect

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
