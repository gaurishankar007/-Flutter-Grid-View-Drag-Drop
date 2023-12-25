import '../core/constants/colors.dart';

import '../injector.dart';
import 'box_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/drag_drop_cubit.dart';
import '../model/box_type_model.dart';

class BoxTypeContainer extends StatelessWidget {
  final List<BoxTypeModel> sTypes = const [
    BoxTypeModel(name: "Rectangle", icon: Icons.rectangle_outlined),
    BoxTypeModel(name: "Circle", icon: Icons.circle_outlined),
    BoxTypeModel(name: "Person", icon: Icons.face),
    BoxTypeModel(name: "Check", icon: Icons.check),
  ];

  const BoxTypeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DragDropCubit>(context);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: dSize.paddingH),
          height: dSize.upConH,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(size.pSH(20)), // From Calculation
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  spreadRadius: 2,
                  blurRadius: 3,
                )
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(sTypes.length, (index) {
                  BoxTypeModel sType = sTypes[index];
                  double bSize = size.pSH(60);
                  bool givePad = index != sTypes.length - 1;

                  return Container(
                    padding: givePad ? EdgeInsets.only(right: size.pSW(20)) : null,
                    child: LongPressDraggable(
                      delay: const Duration(milliseconds: 100),
                      onDragEnd: (DraggableDetails details) =>
                          cubit.addBox(sType: sType, details: details),
                      childWhenDragging: BoxCon(icon: sType.icon, height: bSize, width: bSize),
                      feedback: BoxCon(
                        icon: sType.icon,
                        height: dSize.dMagnification * dSize.gridGap.toDouble(),
                        width: dSize.dMagnification * dSize.gridGap.toDouble(),
                      ),
                      child: BoxCon(icon: sType.icon, height: bSize, width: bSize),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
