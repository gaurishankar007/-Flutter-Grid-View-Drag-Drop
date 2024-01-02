import '../injector.dart';

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
      margin: EdgeInsets.only(left: dSize.paddingH, right: dSize.paddingH, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(right: size.pSW(10)),
              child: Text(name, style: const TextStyle(fontSize: 18)),
            ),
          ),
          PopupMenuButton(
            onSelected: (func) => func(),
            child: const Icon(Icons.more_vert_rounded, color: kP, size: 22),
            itemBuilder: (context) {
              return <PopupMenuItem<Function()>>[
                PopupMenuItem(
                  value: () => editSectionName(
                    context: context,
                    sectionIndex: sectionIndex,
                    name: name,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.edit, color: kP, size: 20),
                      SizedBox(width: size.pSW(10)),
                      const Text(
                        "Edit Name",
                        style: TextStyle(
                          color: kP,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                if (sectionIndex != 0)
                  PopupMenuItem(
                    value: () => cubit.deleteSection(sectionIndex),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.delete, color: Colors.red, size: 20),
                        SizedBox(width: size.pSW(10)),
                        const Text(
                          "Delete Section",
                          style: TextStyle(
                            color: kRed,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
              ];
            },
          ),
        ],
      ),
    );
  }
}
