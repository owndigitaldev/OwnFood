import 'dart:convert';

AreaModel areaModelFromJson(String str) => AreaModel.fromJson(json.decode(str));

String areaModelToJson(AreaModel data) => json.encode(data.toJson());

class AreaModel {
  AreaModel({
    this.meals,
  });

  List<Meal> meals;

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class Meal {
  Meal({
    this.strArea,
  });

  String strArea;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strArea: json["strArea"],
      );

  Map<String, dynamic> toJson() => {
        "strArea": strArea,
      };
}
