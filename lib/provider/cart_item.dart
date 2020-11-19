import 'package:flutter/material.dart';
import 'package:isa_app/models/products.dart';

class CartItem extends ChangeNotifier{
  List<Product> products= [];

  addProduct(Product product){
    products.add(product);
    notifyListeners();
  }

  deleteProduct(Product product){
    products.remove(product);
    notifyListeners();
  }
}