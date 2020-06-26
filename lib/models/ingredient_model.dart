// To parse this JSON data, do
//
//     final ingredientModel = ingredientModelFromJson(jsonString);

import 'dart:convert';

IngredientModel ingredientModelFromJson(String str) =>
    IngredientModel.fromJson(json.decode(str));

String ingredientModelToJson(IngredientModel data) =>
    json.encode(data.toJson());

class IngredientModel {
  IngredientModel({
    this.meals,
  });

  List<Meal> meals;

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      IngredientModel(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class Meal {
  Meal({
    this.idIngredient,
    this.strIngredient,
    this.strDescription,
    this.strType,
  });

  String idIngredient;
  String strIngredient;
  String strDescription;
  dynamic strType;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        idIngredient: json["idIngredient"],
        strIngredient: json["strIngredient"],
        strDescription:
            json["strDescription"] == null ? null : json["strDescription"],
        strType: json["strType"],
      );

  Map<String, dynamic> toJson() => {
        "idIngredient": idIngredient,
        "strIngredient": strIngredient,
        "strDescription": strDescription == null ? null : strDescription,
        "strType": strType,
      };
}
