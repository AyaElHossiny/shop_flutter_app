import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/user_product_item.dart';
import '../providers/products_provider.dart';
import '../widgets/app_drawer.dart';
import './edit_product.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refershProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              }),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refershProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refershProducts(context),
                    child: Consumer<ProductsProvider>(
                      builder: (ctx, productsData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productsData.items.length,
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
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
