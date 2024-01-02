import 'package:drag_drop/injector.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class BoxCon extends StatelessWidget {
  final double height;
  final double width;
  final IconData icon;
  const BoxCon({
    super.key,
    required this.height,
    required this.width,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double iconSize = 30;

    if (height / dSize.gridGap <= 2 || width / dSize.gridGap <= 2) iconSize = 20;

    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: kP,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            spreadRadius: 2,
            blurRadius: 5,
          )
        ],
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: kWhite, size: iconSize),
    );
  }
}
