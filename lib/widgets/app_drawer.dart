import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Hello!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Divider(),
          Container(
            color: Theme.of(context).accentColor,
            child: ListTile(
              leading: Icon(
                Icons.shop,
                color: Colors.black,
              ),
              title: Text('Shop'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ),
          Divider(),
          Container(
            color: Theme.of(context).accentColor,
            child: ListTile(
              leading: Icon(
                Icons.payment,
                color: Colors.black,
              ),
              title: Text('Orders'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
                /* Navigator.of(context).pushReplacement(
                  CustomRoute(
                    builder: (ctx) => OrdersScreen(),
                  ),
                );*/
              },
            ),
          ),
          Divider(),
          Container(
            color: Theme.of(context).accentColor,
            child: ListTile(
              leading: Icon(
                Icons.edit,
                color: Colors.black,
              ),
              title: Text('Manage Products'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductScreen.routeName);
              },
            ),
          ),
          Divider(),
          Container(
            color: Theme.of(context).accentColor,
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              title: Text('Logout'),
              onTap: () {
                //Navigator.of(context).pop;
                Navigator.of(context).pushReplacementNamed('/');
                //Navigator.of(context)
                //    .pushReplacementNamed(UserProductScreen.routeName);
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
