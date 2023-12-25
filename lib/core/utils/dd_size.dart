import '../../injector.dart';

class DragDropSize {
  DragDropSize._();
  static final DragDropSize _singleton = DragDropSize._();
  factory DragDropSize() => _singleton;

  final double appBarH = 60;
  final double upConH = size.pSH(130);
  final double gridTM = size.pSH(65);
  final int crossAxisCount = 25;
  final int dMagnification = 4;
  double paddingH = size.pSW(16);
  int gridGap = 0;
  int mainAxisCount = 0;

  init() {
    // Grid Spacing, Draggable Container Height, button height
    double vSpacing = size.sBarH + appBarH + upConH + gridTM;
    gridGap = ((size.width - paddingH * 2) ~/ crossAxisCount);
    // Adding remaining padding
    paddingH += ((size.width - paddingH * 2) % crossAxisCount) / 2;

    double gridWithVM = size.height - vSpacing;
    double gridBM = (gridWithVM % gridGap);
    mainAxisCount = (gridWithVM - gridBM) ~/ gridGap;
  }
}
