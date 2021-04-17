import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/screens/product_details_screen.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  // );

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          // Pushing a new screen on the fly, without registering the route
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (ctx) => ProductDetailsScreen(title),
          // ));

          Navigator.of(context)
              .pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            leading: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
              },
            ),
            trailing: Consumer<Product>(
              // Alternative listening approach: wrap the listening widget with Consumer and implement the 'builder' argument
              // Advantage of Consumer is that we can wrap smaller widget to rebuild exactly what needs to be and not everything around
              builder: (ctx, product, child) => IconButton(
                // The 'child' argument is the same as the widget passed to the 'child' argument of Consumer
                // The reason for the existence of this 'child' arg is also to avoid re-rendering things that never change
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  product.toggleFavoriteStatus();
                },
              ),
              // child: , // The widget passed here should never be re-rendered
            ),
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
