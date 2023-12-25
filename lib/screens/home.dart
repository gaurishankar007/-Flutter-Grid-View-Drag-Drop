import '../core/constants/colors.dart';
import 'package:flutter/material.dart';

import 'drag_drop.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kP.withOpacity(.5),
        title: const Text("Drag & Drop Grid View"),
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => const DragDrop(),
              ),
            ),
            child: const Text("Open Drag & Drop"),
          ),
        ),
      ),
    );
  }
}
