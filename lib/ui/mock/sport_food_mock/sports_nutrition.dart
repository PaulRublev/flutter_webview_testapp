import 'package:flutter/material.dart';
import 'package:test_app_webview/ui/mock/sport_food_mock/user_data_widget.dart';

class SportsNutrition extends StatelessWidget {
  const SportsNutrition({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserDataWidget(),
    );
  }
}
