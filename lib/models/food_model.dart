import 'dart:convert';

FoodModel foodModelFromJson(String str) => FoodModel.fromJson(json.decode(str));

String foodModelToJson(FoodModel data) => json.encode(data.toJson());

class FoodModel {
  FoodModel({
    this.meals,
  });

  List<Meal> meals;

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return json["meals"]== null ? FoodModel() : FoodModel(
      meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class Meal {
  Meal({
    this.idMeal,
    this.strMeal,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
  });

  String idMeal;
  String strMeal;
  String strCategory;
  String strArea;
  String strInstructions;
  String strMealThumb;
  String strTags;
  String strYoutube;
  String strIngredient1;
  String strIngredient2;
  String strIngredient3;
  String strIngredient4;
  String strIngredient5;
  String strIngredient6;
  String strIngredient7;
  String strIngredient8;
  String strIngredient9;
  String strIngredient10;
  String strIngredient11;
  String strIngredient12;
  String strIngredient13;
  String strIngredient14;
  String strIngredient15;
  String strMeasure1;
  String strMeasure2;
  String strMeasure3;
  String strMeasure4;
  String strMeasure5;
  String strMeasure6;
  String strMeasure7;
  String strMeasure8;
  String strMeasure9;
  String strMeasure10;
  String strMeasure11;
  String strMeasure12;
  String strMeasure13;
  String strMeasure14;
  String strMeasure15;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        idMeal: json["idMeal"],
        strMeal: json["strMeal"],
        strCategory: json["strCategory"],
        strArea: json["strArea"],
        strInstructions: json["strInstructions"],
        strMealThumb: json["strMealThumb"],
        strTags: json["strTags"],
        strYoutube: json["strYoutube"],
        strIngredient1: json["strIngredient1"],
        strIngredient2: json["strIngredient2"],
        strIngredient3: json["strIngredient3"],
        strIngredient4: json["strIngredient4"],
        strIngredient5: json["strIngredient5"],
        strIngredient6: json["strIngredient6"],
        strIngredient7: json["strIngredient7"],
        strIngredient8: json["strIngredient8"],
        strIngredient9: json["strIngredient9"],
        strIngredient10: json["strIngredient10"],
        strIngredient11: json["strIngredient11"],
        strIngredient12: json["strIngredient12"],
        strIngredient13: json["strIngredient13"],
        strIngredient14: json["strIngredient14"],
        strIngredient15: json["strIngredient15"],
        strMeasure1: json["strMeasure1"],
        strMeasure2: json["strMeasure2"],
        strMeasure3: json["strMeasure3"],
        strMeasure4: json["strMeasure4"],
        strMeasure5: json["strMeasure5"],
        strMeasure6: json["strMeasure6"],
        strMeasure7: json["strMeasure7"],
        strMeasure8: json["strMeasure8"],
        strMeasure9: json["strMeasure9"],
        strMeasure10: json["strMeasure10"],
        strMeasure11: json["strMeasure11"],
        strMeasure12: json["strMeasure12"],
        strMeasure13: json["strMeasure13"],
        strMeasure14: json["strMeasure14"],
        strMeasure15: json["strMeasure15"],
      );

  Map<String, dynamic> toJson() => {
        "idMeal": idMeal,
        "strMeal": strMeal,
        "strCategory": strCategory,
        "strArea": strArea,
        "strInstructions": strInstructions,
        "strMealThumb": strMealThumb,
        "strTags": strTags,
        "strYoutube": strYoutube,
        "strIngredient1": strIngredient1,
        "strIngredient2": strIngredient2,
        "strIngredient3": strIngredient3,
        "strIngredient4": strIngredient4,
        "strIngredient5": strIngredient5,
        "strIngredient6": strIngredient6,
        "strIngredient7": strIngredient7,
        "strIngredient8": strIngredient8,
        "strIngredient9": strIngredient9,
        "strIngredient10": strIngredient10,
        "strIngredient11": strIngredient11,
        "strIngredient12": strIngredient12,
        "strIngredient13": strIngredient13,
        "strIngredient14": strIngredient14,
        "strIngredient15": strIngredient15,
        "strMeasure1": strMeasure1,
        "strMeasure2": strMeasure2,
        "strMeasure3": strMeasure3,
        "strMeasure4": strMeasure4,
        "strMeasure5": strMeasure5,
        "strMeasure6": strMeasure6,
        "strMeasure7": strMeasure7,
        "strMeasure8": strMeasure8,
        "strMeasure9": strMeasure9,
        "strMeasure10": strMeasure10,
        "strMeasure11": strMeasure11,
        "strMeasure12": strMeasure12,
        "strMeasure13": strMeasure13,
        "strMeasure14": strMeasure14,
        "strMeasure15": strMeasure15,
      };
}
