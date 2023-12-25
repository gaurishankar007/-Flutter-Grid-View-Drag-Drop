part of 'drag_drop_cubit.dart';

class DragDropState extends Equatable {
  final bool refresh;
  final List<SectionModel> sections;

  const DragDropState({
    required this.refresh,
    required this.sections,
  });

  @override
  List<Object?> get props => [
        refresh,
        sections,
      ];
}
