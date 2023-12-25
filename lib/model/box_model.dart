import 'package:equatable/equatable.dart';

import 'coordinate_model.dart';

class BoxModel extends Equatable {
  final int id;
  final String name;
  final double height;
  final double width;
  final int hm;
  final int wm;
  final CoordinateModel coordinate;

  const BoxModel({
    required this.id,
    required this.name,
    required this.height,
    required this.width,
    this.hm = 4,
    this.wm = 4,
    required this.coordinate,
  });

  BoxModel copyWith({
    int? id,
    String? name,
    double? height,
    double? width,
    int? hm,
    int? wm,
    CoordinateModel? coordinate,
  }) =>
      BoxModel(
        id: id ?? this.id,
        name: name ?? this.name,
        height: height ?? this.height,
        width: width ?? this.width,
        hm: hm ?? this.hm,
        wm: wm ?? this.wm,
        coordinate: coordinate ?? this.coordinate,
      );

  factory BoxModel.fromJson(Map<String, dynamic> json) => BoxModel(
        id: json["id"] as int,
        name: json["name"] as String,
        height: json["height"] as double,
        width: json["width"] as double,
        hm: json["hm"] as int,
        wm: json["wm"] as int,
        coordinate: CoordinateModel.fromJson(json["coordinate"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "height": height,
        "width": width,
        "hm": hm,
        "wm": wm,
        "coordinate": coordinate.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        height,
        width,
        hm,
        wm,
        coordinate,
      ];

  @override
  String toString() {
    return """
      BoxModel(
        id: $id,
        name: "$name",
        hm:$hm,
        wm:$wm,
        height:$height,
        width:$width,
        coordinate: ${coordinate.toString()},
      )
    """;
  }
}
