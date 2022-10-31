import 'package:flutter/material.dart';

class SwitchNotifier extends ChangeNotifier {
  bool isNotifiable = false;

  void toggleNotification({bool isNotifiable = true}) {
    this.isNotifiable = isNotifiable;
    notifyListeners();
  }

  void listUpdated() {
    notifyListeners();
  }
}
