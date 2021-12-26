import 'package:flutter/material.dart';
import 'package:usa_app/models/product_model.dart';

class ProductListProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get getAllProducts => _products;
  void setProductList(List<ProductModel> a) {
    _products = a;
    notifyListeners();
  }
}
