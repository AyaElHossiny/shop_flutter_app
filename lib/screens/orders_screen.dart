import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_Item.dart';
import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    //final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              //error handling
              return Center(
                child: Text('error'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => orderData.orders.isEmpty
                    ? Center(
                        child: Text(
                          "No orders yet!",
                          style: TextStyle(fontSize: 25),
                        ),
                      )
                    : ListView.builder(
                        itemCount: orderData.orders.length,
                        itemBuilder: (ctx, i) => OrderItem(
                          orderData.orders[i],
                        ),
                      ),
              );
            }
          }
        },
      ),
    );
  }
}
