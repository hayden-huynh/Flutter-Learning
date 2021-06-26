import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/product_details_screen.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Use Multiprovider and put all ChangeNotifierProvider into the 'providers' list when a widget should have multiple providers
      providers: [
        ChangeNotifierProvider(
          // Wrap widget with 'ChangeNotifierProvider' to turn it into a data provider for itself and/or all successor widgets
          create: (ctx) =>
              Products(), // Registering the data provider. Use the 'create' argument like this when a new instance of the Provider class is created
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.cyan,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
