import 'package:flutter/material.dart';
import 'package:test_app_webview/ui/mock/sport_food_mock/food_database.dart';

const foodBackDecoration = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/food_back.jpg'),
    fit: BoxFit.none,
    scale: 0.85,
    alignment: Alignment.topCenter,
    repeat: ImageRepeat.repeatY,
    colorFilter: ColorFilter.mode(
      Colors.white30,
      BlendMode.colorDodge,
    ),
  ),
);

class FoodDetailsScreen extends StatelessWidget {
  final String id;
  final FoodDatabase foodDatabase;

  const FoodDetailsScreen({
    super.key,
    required this.id,
    required this.foodDatabase,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FoodItem>(
      future: foodDatabase.getFoodDetails(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final FoodItem foodItem = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(foodItem.description),
            ),
            body: SafeArea(
              maintainBottomViewPadding: true,
              child: Container(
                decoration: foodBackDecoration,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Brand: ${foodItem.brandOwner}',
                          textScaleFactor: 1.1,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Container(
                        color: Colors.white38,
                        child: Text(
                          'Ingredients: ${foodItem.ingredients}',
                          textScaleFactor: 1.1,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Nutrition Facts',
                          textScaleFactor: 1.1,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildNutrientList(foodItem),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            decoration: foodBackDecoration,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNutrientRow({
    required String nutrientName,
    required double nutrientValue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        color: Colors.white30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              nutrientName,
              style: const TextStyle(fontSize: 19.0),
            ),
            Text(
              '${nutrientValue.toStringAsFixed(1)} ${nutrientName == 'Calories' ? '' : 'g'}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNutrientList(FoodItem foodItem) {
    return [
      _buildNutrientRow(
        nutrientName: 'Calories',
        nutrientValue: foodItem.labelNutrients.calories.value,
      ),
      _buildNutrientRow(
        nutrientName: 'Total Fat',
        nutrientValue: foodItem.labelNutrients.fat.value,
      ),
      _buildNutrientRow(
        nutrientName: 'Saturated Fat',
        nutrientValue: foodItem.labelNutrients.saturatedFat.value,
      ),
      _buildNutrientRow(
        nutrientName: 'Trans Fat',
        nutrientValue: foodItem.labelNutrients.transFat.value,
      ),
      _buildNutrientRow(
        nutrientName: 'Cholesterol',
        nutrientValue: foodItem.labelNutrients.cholesterol.value,
      ),
      _buildNutrientRow(
        nutrientName: 'Sodium',
        nutrientValue: foodItem.labelNutrients.sodium.value,
      ),
      _buildNutrientRow(
        nutrientName: 'Total Carbohydrates',
        nutrientValue: foodItem.labelNutrients.carbohydrates.value,
      ),
      _buildNutrientRow(
        nutrientName: 'Dietary Fiber',
        nutrientValue: foodItem.labelNutrients.fiber.value,
      ),
      _buildNutrientRow(
        nutrientName: 'Sugars',
        nutrientValue: foodItem.labelNutrients.sugars.value,
      ),
      _buildNutrientRow(
        nutrientName: 'Protein',
        nutrientValue: foodItem.labelNutrients.protein.value,
      ),
    ];
  }
}
