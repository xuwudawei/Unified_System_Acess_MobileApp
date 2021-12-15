import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int default_index = 0;

  int getDefaultIndex() {
    return default_index;
  }

  void setIndex(int index) {
    default_index = index;
    notifyListeners();
  }
}
