import 'package:drag_drop/core/constants/colors.dart';
import 'package:drag_drop/injector.dart';
import 'package:drag_drop/widgets/box_container.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/drag_drop_cubit.dart';
import '../../model/box_model.dart';

void bmsSeat({
  required BuildContext mainContext,
  required BoxModel box,
  required int sectionIndex,
  required int boxIndex,
  required double gridGap,
}) {
  final cubit = BlocProvider.of<DragDropCubit>(mainContext);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController sH = TextEditingController(text: "${box.hm}");
  TextEditingController sW = TextEditingController(text: "${box.wm}");

  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: mainContext,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(builder: (context, newSetState) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: size.pSH(15),
            horizontal: size.pSW(20),
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BoxCon(
                bSize: dSize.dMagnification * dSize.gridGap.toDouble(),
                icon: box.icon,
              ),
              Container(
                margin: EdgeInsets.only(top: size.pSH(30), bottom: size.pSH(15)),
                child: Form(
                  key: formKey,
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: sH,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Size must be provided";
                            } else if (double.tryParse(value) == null) {
                              return "Invalid size";
                            }
          
                            return null;
                          },
                          decoration: const InputDecoration(
                            isDense: true,
                            labelText: "Height",
                            hintText: "Enter height magnification",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: size.pSW(20)),
                      Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: sW,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Size must be provided";
                            } else if (double.tryParse(value) == null) {
                              return "Invalid size";
                            }
          
                            return null;
                          },
                          decoration: const InputDecoration(
                            isDense: true,
                            labelText: "Width",
                            hintText: "Enter width magnification",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
          
                      Navigator.pop(context);
          
                      BoxModel newSeat = BoxModel(
                        id: box.id,
                        name: box.name,
                        icon: box.icon,
                        height: box.height,
                        width: box.width,
                        hm: box.hm,
                        wm: box.wm,
                        coordinate: box.coordinate,
                      );
          
                      cubit.updateSeat(
                        sectionIndex: sectionIndex,
                        boxIndex: boxIndex,
                        box: newSeat,
                        newHM: int.parse(sH.text),
                        newWM: int.parse(sW.text),
                      );
                    },
                    child: const Text("Save"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      cubit.removeSeat(sectionIndex: sectionIndex, boxIndex: boxIndex);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, foregroundColor: kWhite),
                    child: Text("Delete"),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
            ],
          ),
        );
      });
    },
  );
}
