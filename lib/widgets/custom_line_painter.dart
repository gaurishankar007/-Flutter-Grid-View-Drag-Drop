import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class LinePainter extends CustomPainter {
  final Offset sPoint;
  final Offset ePoint;

  const LinePainter({required this.sPoint, required this.ePoint});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1
      ..color = kB15;

    canvas.drawLine(sPoint, ePoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
