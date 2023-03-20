import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodDatabase {
  final String _apiKey = '8PbuwZBWzUbutFM77hZx8SpEtDWP2TtyJlnXrmba';
  final String _baseUrl = "https://api.nal.usda.gov/fdc/v1/";

  Future<List<SearchFoodItem>> searchFood(String query) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/search?api_key=$_apiKey&query=$query"),
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final foods = List<SearchFoodItem>.from(
        jsonBody['foods'].map((food) => SearchFoodItem.fromJson(food)),
      );
      return foods;
    } else {
      throw Exception('Failed to load food');
    }
  }

  Future<FoodItem> getFoodDetails(String foodId) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/$foodId?api_key=$_apiKey"),
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final food = FoodItem.fromJson(jsonBody);
      return food;
    } else {
      throw Exception('Failed to load food details');
    }
  }
}

class SearchFoodItem {
  final int id;
  final String name;
  final String brandName;
  final String description;

  SearchFoodItem({
    required this.id,
    required this.name,
    required this.brandName,
    required this.description,
  });

  factory SearchFoodItem.fromJson(Map<String, dynamic>? json) {
    return SearchFoodItem(
      id: json?['fdcId'] ?? -1,
      name: json?['description'] ?? '',
      brandName: json?['brandName'] ?? "",
      description: json?['ingredients'] ?? "",
    );
  }
}

class FoodItem {
  final int fdcId;
  final String description;
  final String brandOwner;
  final String brandedFoodCategory;
  final String ingredients;
  final LabelNutrients labelNutrients;
  final List<FoodNutrient> foodNutrients;

  FoodItem({
    required this.fdcId,
    required this.description,
    required this.brandOwner,
    required this.brandedFoodCategory,
    required this.ingredients,
    required this.labelNutrients,
    required this.foodNutrients,
  });

  factory FoodItem.fromJson(Map<String, dynamic>? json) {
    return FoodItem(
      fdcId: json?['fdcId'] ?? -1,
      description: json?['description'] ?? '',
      brandOwner: json?['brandOwner'] ?? '',
      brandedFoodCategory: json?['brandedFoodCategory'] ?? '',
      ingredients: json?['ingredients'] ?? '',
      labelNutrients: LabelNutrients.fromJson(json?['labelNutrients']),
      foodNutrients: List<FoodNutrient>.from((json?['foodNutrients'] ?? [])
          .map((nutrient) => FoodNutrient.fromJson(nutrient))),
    );
  }
}

class FoodNutrient {
  final Nutrient nutrient;
  final double amount;

  FoodNutrient({
    required this.nutrient,
    required this.amount,
  });

  factory FoodNutrient.fromJson(Map<String, dynamic>? json) {
    return FoodNutrient(
      nutrient: Nutrient.fromJson(json?['nutrient']),
      amount: json?['amount']?.toDouble() ?? 0.0,
    );
  }
}

class Nutrient {
  final String name;

  Nutrient({
    required this.name,
  });

  factory Nutrient.fromJson(Map<String, dynamic>? json) {
    return Nutrient(
      name: json?['name'] ?? '',
    );
  }
}

class LabelNutrients {
  final NutrientValue fat;
  final NutrientValue saturatedFat;
  final NutrientValue transFat;
  final NutrientValue cholesterol;
  final NutrientValue sodium;
  final NutrientValue carbohydrates;
  final NutrientValue fiber;
  final NutrientValue sugars;
  final NutrientValue protein;
  final NutrientValue calcium;
  final NutrientValue iron;
  final NutrientValue potassium;
  final NutrientValue calories;

  LabelNutrients({
    required this.fat,
    required this.saturatedFat,
    required this.transFat,
    required this.cholesterol,
    required this.sodium,
    required this.carbohydrates,
    required this.fiber,
    required this.sugars,
    required this.protein,
    required this.calcium,
    required this.iron,
    required this.potassium,
    required this.calories,
  });

  factory LabelNutrients.fromJson(Map<String, dynamic>? json) {
    return LabelNutrients(
      fat: NutrientValue.fromJson(json?['fat']),
      saturatedFat: NutrientValue.fromJson(json?['saturatedFat']),
      transFat: NutrientValue.fromJson(json?['transFat']),
      cholesterol: NutrientValue.fromJson(json?['cholesterol']),
      sodium: NutrientValue.fromJson(json?['sodium']),
      carbohydrates: NutrientValue.fromJson(json?['carbohydrates']),
      fiber: NutrientValue.fromJson(json?['fiber']),
      sugars: NutrientValue.fromJson(json?['sugars']),
      protein: NutrientValue.fromJson(json?['protein']),
      calcium: NutrientValue.fromJson(json?['calcium']),
      iron: NutrientValue.fromJson(json?['iron']),
      potassium: NutrientValue.fromJson(json?['potassium']),
      calories: NutrientValue.fromJson(json?['calories']),
    );
  }
}

class NutrientValue {
  final double value;

  NutrientValue({
    required this.value,
  });

  factory NutrientValue.fromJson(Map<String, dynamic>? json) {
    return NutrientValue(
      value: json?['value']?.toDouble() ?? 0.0,
    );
  }
}
