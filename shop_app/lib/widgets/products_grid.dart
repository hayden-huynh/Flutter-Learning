import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/product_item.dart';

// This is a data-using widget. Data will be extracted from the provider class
class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(
        context); // Extracting the data from the provider. Must specify which provider we are targeting at using <>
    final products = productsProvider.items;

    return GridView.builder(
      gridDelegate:
          // Set certain quantity of columns to show
          SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing:
                  10), // How the grid layout (row, column, etc.) should be
      itemBuilder: (ctx, index) {
        // How each grid element should be built
        return ChangeNotifierProvider.value(
          // Should use the 'value' constructor when the child widget is a List or Grid item to avoid bugs caused by Flutter's widget recycling. Also change the 'create' argument to 'value'
          value: products[index],
          // 1. Product objects are already instantiated in the 'products' list
          // 2. Each ProductItem object needs to listen to its own associating Product object
          child: ProductItem(
              // products[index].id,
              // products[index].title,
              // products[index].imageUrl,
              ),
        );
      },
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
    );
  }
}
