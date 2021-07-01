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
import 'package:shop_app/screens/auth_screen.dart';
import "package:shop_app/providers/auth.dart";
import 'package:shop_app/screens/splash_screen.dart';

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
            create: (ctx) => Auth(),
          ),
          // ChangeNotifierProvider(
          //   // Wrap widget with 'ChangeNotifierProvider' to turn it into a data provider for itself and/or all successor widgets
          //   create: (ctx) =>
          //       Products(), // Registering the data provider. Use the 'create' argument like this when a new instance of the Provider class is created
          // ),
          ChangeNotifierProxyProvider<Auth, Products>(
            // ChangeNotifierProxyProvider<A, B> will make B depend on the changes in A. Whenever A changes, the function registered in the "update" arg will be called automatically
            // The function registered in the "update" arg is automatically passed an instance of A and B (respectively 2nd and 3rd arg) so that changes of data in A can be accessed by B
            // In the list of "providers" in MultiProvider, the ChangeNotifierProvider of A MUST be placed above the ChangeNotifierProxyProvider of B
            create: (ctx) => Products(),
            update: (ctx, auth, previousProducts) => previousProducts
              ..update(
                auth.token,
                auth.userId,
              ),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders(),
            update: (context, auth, previous) => previous
              ..update(
                auth.token,
                auth.userId,
              ),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              accentColor: Colors.cyan,
              fontFamily: 'Lato',
            ),
            home: auth.isAuth
                ? ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductScreen.routeName: (ctx) => UserProductScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen()
            },
            debugShowCheckedModeBanner: false,
          ),
        ));
  }
}
