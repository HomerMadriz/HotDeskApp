import 'package:flutter/foundation.dart';

class LogoAnimation with ChangeNotifier {
  double _logoOpacity = 0.0;
  double get logoOpacity => _logoOpacity;

  void changeLogoOpacity() {
    _logoOpacity = 1.0;
    notifyListeners();
  }
}
