import '../injector.dart';

import '../core/constants/colors.dart';
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
          backgroundColor: kP.withOpacity(.5),
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
