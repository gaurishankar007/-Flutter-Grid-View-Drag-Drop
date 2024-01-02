import '../injector.dart';

import '../widgets/popups/menu_button.dart';
import 'package:flutter/material.dart';
import '../widgets/grid_container.dart';
import '../widgets/box_type_container.dart';

class DragDrop extends StatelessWidget {
  const DragDrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, dSize.appBarH),
        child: AppBar(
          title: const Text("Drag & Drop Grid View"),
          elevation: 0,
          actions: const [PopMenu()],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const BoxTypeContainer(),
            GridContainer(),
          ],
        ),
      ),
    );
  }
}
