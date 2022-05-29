import 'package:flutter/widgets.dart';

class MyProvider extends ChangeNotifier {
  int time = 1210;
  MyProvider({this.time = 1210});
  void azalt() {
    time--;
    notifyListeners();
  }

  void resle() {
    time = 1210;
  }
}
