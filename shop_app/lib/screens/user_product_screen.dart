import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/user_product_item.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const String routeName = "/user-products";

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final _productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    // Widget to pull down to refresh the current screen
                    onRefresh: () => _refreshProducts(
                        context), // onRefresh is the callback to be executed when the user pulls down to refresh the page
                    child: Consumer<Products>(
                      // Use Consumer instead of a Provider listener that recalls the build function to avoid an infinite loop because here in build we make a call to fetchAndSetProducts, which will cause _items list to change and thus this widget gets rebuilt entirely i.e. build gets called indefinitely
                      builder: (context, productsData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemBuilder: (_, i) => Column(
                            children: [
                              UserProductItem(
                                productsData.items[i].id,
                                productsData.items[i].title,
                                productsData.items[i].imageUrl,
                              ),
                              Divider(),
                            ],
                          ),
                          itemCount: productsData.items.length,
                        ),
                      ),
                    ),
                  ),
      ),
      drawer: AppDrawer(),
    );
  }
}
