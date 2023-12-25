import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'coordinate_model.dart';

class BoxModel extends Equatable {
  final int id;
  final String name;
  final IconData icon;
  final double height;
  final double width;
  final int hm;
  final int wm;
  final CoordinateModel coordinate;

  const BoxModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.height,
    required this.width,
    this.hm = 4,
    this.wm = 4,
    required this.coordinate,
  });

  factory BoxModel.fromJson(Map<String, dynamic> json) => BoxModel(
        id: json["id"] as int,
        name: json["name"] as String,
        icon: json["icon"] as IconData,
        height: json["height"] as double,
        width: json["width"] as double,
        hm: json["hm"] as int,
        wm: json["wm"] as int,
        coordinate: CoordinateModel.fromJson(json["coordinate"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
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
        icon,
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
        icon: "$icon",
        hm:$hm,
        wm:$wm,
        height:$height,
        width:$width,
        coordinate: ${coordinate.toString()},
      )
    """;
  }
}
