import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../injector.dart';
import '../model/box_model.dart';
import '../model/box_type_model.dart';
import '../model/coordinate_model.dart';
import '../model/section_model.dart';

part 'drag_drop_state.dart';

class DragDropCubit extends Cubit<DragDropState?> {
  List<SectionModel> sections = [];
  bool refresh = true;

  late Box gridBox;
  double gridWidth = 0;
  double gridHeight = 0;
  ScrollController get sController => dSize.sController;
  int get gridGap => dSize.gridGap;
  int get mainAxisCount => dSize.mainAxisCount;
  double get topH => size.sBarH + dSize.appBarH + dSize.upConH;

  DragDropCubit() : super(null);

  DragDropState get _state => DragDropState(
        refresh: refresh,
        sections: sections,
      );

  _uState() {
    refresh = !refresh;
    emit(_state);
    gridBox.put(
      "sections",
      jsonEncode(sections.map((e) => e.toJson()).toList()),
    );
  }

  init() async {
    gridHeight = (mainAxisCount * gridGap).toDouble();
    gridWidth = (dSize.crossAxisCount * gridGap).toDouble();

    sections.add(
      SectionModel(
        name: "First Section",
        boxes: const [],
        mainAxisCount: mainAxisCount,
        height: gridHeight,
      ),
    );

    emit(_state);

    gridBox = await Hive.openBox("Grid");
    int? prevGG = gridBox.get("gridGap");
    String? sectionData = gridBox.get("sections");

    if (prevGG == null) {
      return await gridBox.put("gridGap", gridGap);
    }

    if (sectionData != null) {
      List data = jsonDecode(sectionData);
      sections = data.map((e) => SectionModel.fromJson(e)).toList();

      List<SectionModel> newSections = [];

      for (int i = 0; i < sections.length; i++) {
        SectionModel sm = sections[i];
        List<BoxModel> newBoxes = sm.boxes;
        int newMAC = mainAxisCount;
        double newHeight = gridHeight;

        if (sm.mainAxisCount > mainAxisCount) {
          newMAC = sm.mainAxisCount;
          newHeight = (newMAC * gridGap).toDouble();
        }

        // Updating data for new screens
        if (prevGG != gridGap) {
          newBoxes = sm.boxes.map((box) {
            // New Coordinate
            double nDx = (box.coordinate.dx / prevGG) * gridGap;
            double nDy = (box.coordinate.dy / prevGG) * gridGap;

            // New Size
            double nH = box.hm * gridGap.toDouble();
            double nW = box.wm * gridGap.toDouble();

            return BoxModel(
              id: box.id,
              name: box.name,
              height: nH,
              width: nW,
              coordinate: CoordinateModel(dx: nDx, dy: nDy),
            );
          }).toList();
        }

        newSections.add(
          SectionModel(
            name: sm.name,
            boxes: newBoxes,
            mainAxisCount: newMAC,
            height: newHeight,
          ),
        );
      }

      sections = newSections;
      await gridBox.put(
        "sections",
        jsonEncode(sections.map((e) => e.toJson()).toList()),
      );
      emit(_state);
    }

    if (gridGap != prevGG) gridBox.put("gridGap", gridGap);
  }

  clearData() async {
    sections = [
      SectionModel(
        name: "First Section",
        boxes: const [],
        mainAxisCount: mainAxisCount,
        height: gridHeight,
      )
    ];

    emit(_state);

    gridBox.clear();
    await gridBox.put("gridGap", gridGap);
  }

  addSection(String name) async {
    sections.add(SectionModel(
      name: name,
      boxes: const [],
      mainAxisCount: mainAxisCount,
      height: gridHeight,
    ));
    _uState();
  }

  deleteSection(int index) async {
    sections.removeAt(index);
    _uState();
  }

  editSectionName({required int sectionIndex, required String newName}) async {
    sections[sectionIndex].name = newName;
    _uState();
  }

  removeBox({required int sectionIndex, boxIndex}) async {
    sections[sectionIndex].boxes.removeAt(boxIndex);
    _uState();
  }

  addBox({required BoxTypeModel sType, required DraggableDetails details}) async {
    // Determining box size
    double boxH = dSize.dMagnification * gridGap.toDouble();
    double boxW = dSize.dMagnification * gridGap.toDouble();

    // Checking if the dragged widget touches the grid area or not
    if (details.offset.dy + boxH - (boxH / 4) < topH + dSize.gridTM) {
      return;
    }

    // Finding in which section the dragged widget appears in
    late int sectionIndex;
    double yOffset = details.offset.dy;
    yOffset -= topH;
    // Adding the scroll amount
    yOffset += sController.offset;

    // Extra height above the section
    double extraHeight = 0;
    for (int i = 0; i < sections.length; i++) {
      double h = extraHeight + dSize.gridTM + sections[i].height;
      if (extraHeight < yOffset && yOffset <= h) {
        sectionIndex = i;
        break;
      }

      extraHeight = h;
    }
    SectionModel section = sections[sectionIndex];

    // New x coordinate of the dragged Widget
    double newLeft = details.offset.dx - dSize.paddingH;
    // The max x coordinate to which it can be moved
    double maxLeft = gridWidth - boxW;
    // final x coordinate inside the grid view
    double left = max(0, min(maxLeft, newLeft));

    double newTop = yOffset - dSize.gridTM - extraHeight;
    double maxTop = section.height - boxH;
    double top = max(0, min(maxTop, newTop));

    // Alignment of widget along with the grid lines
    if (left % gridGap >= gridGap / 2) {
      left = left - (left % gridGap) + gridGap;
    } else {
      left = left - (left % gridGap);
    }

    if (top % gridGap >= gridGap / 2) {
      top = top - (top % gridGap) + gridGap;
    } else {
      top = top - (top % gridGap);
    }

    // Checking if the dragged widget collides with other widgets inside the grid area or not
    for (int i = 0; i < section.boxes.length; i++) {
      CoordinateModel cn = section.boxes[i].coordinate;
      double h = section.boxes[i].height;
      double w = section.boxes[i].width;

      bool xExist = (cn.dx <= left && left < cn.dx + w) || (left <= cn.dx && cn.dx < left + boxW);
      bool yExist = (cn.dy <= top && top < cn.dy + h) || (top <= cn.dy && cn.dy < top + boxH);

      if (xExist && yExist) return;
    }

    // if the dragged widget reaches the end of grid container
    if ((top + boxH) ~/ gridGap >= section.mainAxisCount - 1) {
      sections[sectionIndex].mainAxisCount++;
      sections[sectionIndex].height += gridGap;
    }

    final box = BoxModel(
      id: section.boxes.length + 1,
      name: sType.name,
      height: boxH,
      width: boxW,
      coordinate: CoordinateModel(dx: left, dy: top),
    );
    sections[sectionIndex].boxes.add(box);

    _uState();
  }

  updateBoxPosition({
    required int sectionIndex,
    required int boxIndex,
    required DraggableDetails details,
  }) async {
    SectionModel section = sections[sectionIndex];
    BoxModel box = section.boxes[boxIndex];

    double prevLeft = box.coordinate.dx;
    double newLeft = details.offset.dx - dSize.paddingH;
    double maxLeft = gridWidth - box.width;
    double left = max(0, min(maxLeft, newLeft));

    double yOffset = details.offset.dy;
    yOffset -= topH;
    yOffset += sController.offset;
    double extraHeight = 0;

    for (int i = 0; i < sectionIndex; i++) {
      extraHeight += dSize.gridTM + sections[i].height;
    }

    double prevTop = box.coordinate.dy;
    double newTop = yOffset - dSize.gridTM - extraHeight;
    double maxTop = section.height - box.height;
    double top = max(0, min(maxTop, newTop));

    if (left != 0) {
      // Not modifying if the dragged widget touches the border
      if (left - prevLeft < 0) {
        if (left % gridGap >= gridGap / 2) {
          left = left - (left % gridGap) + gridGap;
        } else {
          left = left - (left % gridGap);
        }
      } else {
        if ((left - prevLeft) % gridGap >= gridGap / 2) {
          left = left - (left % gridGap) + gridGap;
        } else {
          left = left - (left % gridGap);
        }
      }
    }

    if (top != 0) {
      if (top - prevTop < 0) {
        if (top % gridGap >= gridGap / 2) {
          top = top - (top % gridGap) + gridGap;
        } else {
          top = top - (top % gridGap);
        }
      } else {
        if ((top - prevTop) % gridGap >= gridGap / 2) {
          top = top - (top % gridGap) + gridGap;
        } else {
          top = top - (top % gridGap);
        }
      }
    }

    for (int i = 0; i < section.boxes.length; i++) {
      CoordinateModel cn = section.boxes[i].coordinate;
      double h = section.boxes[i].height;
      double w = section.boxes[i].width;

      // Not checking with the same widget
      if (section.boxes[i].id != box.id) {
        bool xExist =
            (cn.dx <= left && left < cn.dx + w) || (left <= cn.dx && cn.dx < left + box.width);
        bool yExist =
            (cn.dy <= top && top < cn.dy + h) || (top <= cn.dy && cn.dy < top + box.height);

        if (xExist && yExist) return;
      }
    }

    if ((top + box.height) ~/ gridGap >= section.mainAxisCount - 1) {
      sections[sectionIndex].mainAxisCount++;
      sections[sectionIndex].height += gridGap;
    }

    sections[sectionIndex].boxes[boxIndex] =
        box.copyWith(coordinate: CoordinateModel(dx: left, dy: top));

    _uState();
  }

  updateBox({required int sectionIndex, boxIndex, newHM, newWM, required BoxModel box}) async {
    SectionModel section = sections[sectionIndex];
    bool overlap = false;

    double boxH = (newHM * gridGap).toDouble();
    double boxW = (newWM * gridGap).toDouble();

    // Checking overlapping with other widgets with the new height and width
    if (box.hm != newHM || box.wm != newWM) {
      double left = box.coordinate.dx;
      double top = box.coordinate.dy;

      for (int i = 0; i < section.boxes.length; i++) {
        CoordinateModel cn = section.boxes[i].coordinate;
        double h = section.boxes[i].height;
        double w = section.boxes[i].width;

        if (cn.dx != left || cn.dy != top) {
          bool xExist =
              (cn.dx <= left && left < cn.dx + w) || (left <= cn.dx && cn.dx < left + boxW);
          bool yExist = (cn.dy <= top && top < cn.dy + h) || (top <= cn.dy && cn.dy < top + boxH);

          if (xExist && yExist) {
            overlap = true;
          }
        }
      }
    }

    late double h, w;
    late int hm, wm;
    // If does not overlap with other and does not exceed grid area, then setting new size
    if (overlap ||
        boxH >= section.height - box.coordinate.dy ||
        boxW >= gridWidth - box.coordinate.dx) {
      h = box.height;
      w = box.width;

      hm = box.hm;
      wm = box.wm;
    } else {
      h = boxH;
      w = boxW;

      hm = newHM;
      wm = newWM;
    }

    sections[sectionIndex].boxes[boxIndex] = box.copyWith(height: h, width: w, hm: hm, wm: wm);
    _uState();
  }
}
