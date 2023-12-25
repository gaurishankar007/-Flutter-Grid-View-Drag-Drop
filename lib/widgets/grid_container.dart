import '../injector.dart';

import 'grid_title.dart';
import 'positioned_box.dart';

import 'custom_line_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/drag_drop_cubit.dart';
import '../model/box_model.dart';
import '../model/section_model.dart';

class GridContainer extends StatelessWidget {
  const GridContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DragDropCubit, DragDropState?>(
      builder: (builder, state) {
        if (state is DragDropState) {
          double gridH = dSize.mainAxisCount * dSize.gridGap.toDouble();
          int gridGap = dSize.gridGap;
          List<SectionModel> sections = state.sections;

          return SizedBox(
            width: double.maxFinite,
            height: gridH + dSize.gridTM,
            child: SingleChildScrollView(
              controller: state.sController,
              child: Column(
                children: List.generate(
                  sections.length,
                  (sectionIndex) {
                    SectionModel section = sections[sectionIndex];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GridTitle(sectionIndex: sectionIndex, name: section.name),
                        Container(
                          width: double.maxFinite,
                          height: (section.mainAxisCount * gridGap).toDouble(),
                          margin: EdgeInsets.symmetric(horizontal: dSize.paddingH),
                          child: Stack(
                            children: [
                              ...List.generate(
                                section.mainAxisCount + 1,
                                (index) {
                                  Offset sP = Offset(0, (gridGap * index).toDouble());
                                  Offset eP = Offset((dSize.crossAxisCount * gridGap).toDouble(),
                                      (gridGap * index).toDouble());
                                  return CustomPaint(painter: LinePainter(sPoint: sP, ePoint: eP));
                                },
                              ),
                              ...List.generate(
                                dSize.crossAxisCount + 1,
                                (index) {
                                  Offset sP = Offset((gridGap * index).toDouble(), 0);
                                  Offset eP = Offset((gridGap * index).toDouble(),
                                      (section.mainAxisCount * gridGap).toDouble());
                                  return CustomPaint(painter: LinePainter(sPoint: sP, ePoint: eP));
                                },
                              ),
                              ...List.generate(
                                section.boxes.length,
                                (boxIndex) {
                                  BoxModel box = section.boxes[boxIndex];
                                  return PositionedBox(
                                    box: box,
                                    sectionIndex: sectionIndex,
                                    boxIndex: boxIndex,
                                    gridGap: gridGap.toDouble(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
