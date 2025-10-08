import 'package:edu/model/cart_item.dart';
import 'package:flutter/material.dart';

class CartController with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get totalCount => _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.values.fold(0, (sum, item) => sum + item.price * item.quantity);

  void addItem(CartItem item) {
    if (_items.containsKey(item.title)) {
      _items[item.title]!.quantity += 1;
    } else {
      _items[item.title] = item;
    }
    notifyListeners();
  }

  void incrementItem(String title) {
    if (_items.containsKey(title)) {
      _items[title]!.quantity++;
      notifyListeners();
    }
  }

  void decrementItem(String title) {
    if (_items.containsKey(title)) {
      if (_items[title]!.quantity > 1) {
        _items[title]!.quantity--;
      } else {
        _items.remove(title);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
