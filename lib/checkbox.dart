import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckNotifier extends ChangeNotifier {
  bool ?checked = false;
  void markCheckBox({bool? value = true}) {
    this.checked = value;
    notifyListeners();
  }
}
