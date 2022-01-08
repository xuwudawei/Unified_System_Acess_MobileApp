import 'package:flutter/material.dart';
import 'package:usa_app/models/product_model.dart';

class ProductListProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> getAllProducts() {
    return _products;
  }

  void setProductList(List<ProductModel> a) {
    _products = a;
    notifyListeners();
  }

  void setProductAccountStatusInactive(int index) {
    _products[index].accountStatus = 0;
    notifyListeners();
  }
}
