import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productId;

  CartItem(
    this.id,
    this.price,
    this.quantity,
    this.title,
    this.productId,
  );

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Dismissible(
      // A wiget wrapping other widgets, allowing them to be swiped over to dismiss
      key: ValueKey(id), // Must be unique so that Dismissible works correctly
      direction: DismissDirection
          .endToStart, // Allow only one direction of swiping (right to left)
      onDismissed: (direction) {
        cart.removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ), // What shown behing the dismissible widget when swiping starts
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text('\$$price')),
            ),
            title: Text('$title'),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text('Quantity: $quantity'),
          ),
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}
