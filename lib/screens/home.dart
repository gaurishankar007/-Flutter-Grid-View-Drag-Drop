import 'drag_drop.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => DragDrop(),
              ),
            ),
            child: Text("Open Drag & Drop"),
          ),
        ),
      ),
    );
  }
}
