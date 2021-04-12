import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/product_details_screen.dart';
import 'package:shop_app/providers/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Wrap widget with 'ChangeNotifierProvider' to turn it into a data provider for itself and/or all successor widgets
      create: (ctx) =>
          Products(), // Registering the data provider. Use the 'create' argument like this when a new instance of the Provider class is created
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
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
