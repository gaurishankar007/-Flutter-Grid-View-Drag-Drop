import 'package:drag_drop/injector.dart';

import '../core/constants/colors.dart';
import 'popups/edit_section_name_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/drag_drop_cubit.dart';

class GridTitle extends StatelessWidget {
  final String name;
  final int sectionIndex;

  const GridTitle({
    super.key,
    required this.name,
    required this.sectionIndex,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DragDropCubit>(context);

    return Container(
      height: dSize.gridTM,
      padding: EdgeInsets.only(left: dSize.paddingH, right: dSize.paddingH, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(name, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => editSectionName(
                  context: context,
                  sectionIndex: sectionIndex,
                  name: name,
                ),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: kP.withOpacity(.2)),
                  child: const Icon(Icons.edit, color: kP, size: 15),
                ),
              ),
            ],
          ),
          if (sectionIndex != 0)
            GestureDetector(
              onTap: () => cubit.deleteSection(sectionIndex),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withOpacity(.2),
                ),
                child: const Icon(Icons.delete, color: Colors.red, size: 15),
              ),
            ),
        ],
      ),
    );
  }
}
