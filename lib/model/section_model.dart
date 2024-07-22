// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'box_model.dart';

class SectionModel {
  String name;
  int mainAxisCount;
  double height;
  List<BoxModel> boxes;

  SectionModel({
    required this.name,
    required this.mainAxisCount,
    required this.height,
    required this.boxes,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        name: json["name"] as String,
        mainAxisCount: json["mainAxisCount"] as int,
        height: json["height"] as double,
        boxes:
            (json["boxes"] as List).map((e) => BoxModel.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mainAxisCount": mainAxisCount,
        "height": height,
        "boxes": boxes.map((e) => e.toJson()).toList(),
      };

  SectionModel copyWith({
    String? name,
    int? mainAxisCount,
    double? height,
    List<BoxModel>? boxes,
  }) {
    return SectionModel(
      name: name ?? this.name,
      mainAxisCount: mainAxisCount ?? this.mainAxisCount,
      height: height ?? this.height,
      boxes: boxes ?? this.boxes,
    );
  }
}
