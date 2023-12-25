import '../model/box_model.dart';
import 'box_container.dart';
import 'popups/bms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/drag_drop_cubit.dart';

class PositionedBox extends StatelessWidget {
  final BoxModel box;
  final int sectionIndex;
  final int boxIndex;
  final double gridGap;

  const PositionedBox({
    super.key,
    required this.box,
    required this.sectionIndex,
    required this.boxIndex,
    required this.gridGap,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DragDropCubit>(context);

    return Positioned(
      left: box.coordinate.dx,
      top: box.coordinate.dy,
      child: GestureDetector(
        onTap: () => bmsSeat(
          mainContext: context,
          box: box,
          sectionIndex: sectionIndex,
          boxIndex: boxIndex,
          gridGap: gridGap,
        ),
        child: LongPressDraggable(
          delay: const Duration(milliseconds: 100),
          onDragEnd: (DraggableDetails details) => cubit.updateSeatPosition(
            sectionIndex: sectionIndex,
            boxIndex: boxIndex,
            details: details,
          ),
          childWhenDragging: BoxCon(bSize: box.hm * gridGap, icon: box.icon),
          feedback: BoxCon(bSize: box.hm * gridGap, icon: box.icon),
          child: BoxCon(bSize: box.hm * gridGap, icon: box.icon),
        ),
      ),
    );
  }
}
