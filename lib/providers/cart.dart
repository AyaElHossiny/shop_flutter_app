import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.quantity,
    @required this.title,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    int count = 0;
    _items.forEach((productId, value) => count += value.quantity);
    return count;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //change quantity
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String prouductId) {
    /*items.forEach(
      (key, value) {
        if (_items.containsKey(prouductId) && items[key].quantity > 1) {
          _items.update(
            prouductId,
            (i) => CartItem(
                id: i.id,
                price: i.price,
                quantity: i.quantity - 1,
                title: i.title),
          );
        } else {
          _items.remove(prouductId);
        }
        notifyListeners();
      },
    );*/
    _items.remove(prouductId); // remove the card
    notifyListeners();
  }

  addOrRemoveQuantity(String productId, bool operators, int quantity) {
    //remove only one
    if (quantity == 1 && operators == false) {
      _items.remove(productId);
    } else if (quantity >= 1 && _items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: operators
                ? existingCartItem.quantity + 1
                : existingCartItem.quantity - 1),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
          title: existingCartItem.title,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
