import 'package:flutter/material.dart';

class CounterNotifier extends ChangeNotifier {
  int counter = 0;
  int get _counter => counter;
  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}
