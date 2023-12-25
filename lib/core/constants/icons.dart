import 'package:flutter/material.dart';

IconData getIcon(String icon) {
  final Map<String, IconData> icons = {
    "Rectangle": Icons.rectangle_outlined,
    "Circle": Icons.circle_outlined,
    "Person": Icons.face,
    "Check": Icons.check,
  };

  return icons[icon] ?? Icons.cancel;
}
