part of 'drag_drop_cubit.dart';

class DragDropState extends Equatable {
  final bool updateState;
  final ScrollController sController;
  final int crossAxisCount;
  final int mainAxisCount;
  final int gridGap;
  final double gridHeight;
  final double seatTypeH;
  final double buttonH;
  final double paddingH;
  final double gridTM;
  final double gridBM;
  final int angle;
  final List<SeatTypeModel> sTypes;
  final List<SectionModel> sections;
  final double vWidth;

  const DragDropState({
    required this.updateState,
    required this.sController,
    required this.crossAxisCount,
    required this.mainAxisCount,
    required this.gridGap,
    required this.vWidth,
    required this.gridHeight,
    required this.seatTypeH,
    required this.buttonH,
    required this.paddingH,
    required this.gridTM,
    required this.gridBM,
    required this.angle,
    required this.sTypes,
    required this.sections,
  });

  @override
  List<Object?> get props => [
        updateState,
        mainAxisCount,
        angle,
        sections,
      ];
}
