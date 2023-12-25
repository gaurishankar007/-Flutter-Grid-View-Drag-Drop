import 'package:drag_drop/injector.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static double _sWidth = 0;
  static double _sHeight = 0;
  static double _aStatusBH = 0;

  void init(BoxConstraints constraints, BuildContext context) {
    _sWidth = constraints.maxWidth;
    _sHeight = constraints.maxHeight;
    _aStatusBH = MediaQuery.of(context).viewPadding.top;
    dSize.init();
  }

  // Get the proportionate height as per screen size
  double pSH(double inputHeight) => (inputHeight / 949.0) * _sHeight;
  // Get the proportionate height as per screen size
  double pSW(double inputWidth) => (inputWidth / 430.0) * _sWidth;

  double get height => _sHeight;
  double get width => _sWidth;
  double get sBarH => _aStatusBH;
}
