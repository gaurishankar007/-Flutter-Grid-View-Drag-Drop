import '../../cubit/drag_drop_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_section_dialog.dart';
import 'package:flutter/material.dart';

class PopMenu extends StatelessWidget {
  const PopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DragDropCubit>(context);

    return PopupMenuButton(
      onSelected: (func) => func(),
      itemBuilder: (context) {
        return <PopupMenuItem<Function()>>[
          PopupMenuItem(
            value: () => addSection(context),
            child: Text(
              "Add Section",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          PopupMenuItem(
            value: () => cubit.clearData(),
            child: Text(
              "Reset",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ];
      },
    );
  }
}
