import 'dart:convert';

import 'package:coffee_masters/datamodel.dart';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];

  fetchMenu() async {
    const url = "https://firtman.github.io/coffeemasters/api/menu.json";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = response.body;
      _menu = [];
      var decodedData = jsonDecode(body) as List<dynamic>;
      for (var json in decodedData) {
        _menu?.add(Category.fromJson(json));
      }
    }
  }

  Future<List<Category>> getMenu() async {
    if (_menu == null) {
      await fetchMenu();
    }
    return _menu!;
  }

  cartAdd(Product p) {
    bool found = false;
    for (var item in cart) {
      if (item.product.id == p.id) {
        item.quantity++;
        found = true;
      }
    }
    if (!found) {
      cart.add(ItemInCart(product: p, quantity: 1));
    }
  }

  cartRemove(Product p) {
    cart.removeWhere((item) => item.product.id == p.id);
  }

  cartClear() {
    cart.clear();
  }

  double cartTotal() {
    double total = 0;
    for (var items in cart) {
      total += items.quantity * items.product.price;
    }
    return total;
  }
}
