import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class BoxCon extends StatelessWidget {
  final double bSize;
  final IconData icon;
  const BoxCon({super.key, required this.bSize, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bSize,
      width: bSize,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.3),
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: kP),
    );
  }
}
