import 'package:flutter/material.dart';
import 'package:test_app_webview/ui/mock/sport_food_mock/weight_goal.dart';

class UserDataWidget extends StatefulWidget {
  const UserDataWidget({super.key});

  @override
  State<UserDataWidget> createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget>
    with AutomaticKeepAliveClientMixin {
  // Переменные для хранения данных пользователя
  Genders? _gender;
  int? _years;
  int? _height;
  double? _weight;
  ActivityLevels? _activityLevel;

  // Контроллеры полей ввода
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _yearsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Enter your parameters'),
      ),
      body: Container(
        decoration: calcBackDecoration,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              // Поле ввода пола
              DropdownButtonFormField<Genders>(
                value: _gender,
                decoration: const InputDecoration(
                  label: Text(
                    'Gender',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                style: const TextStyle(fontSize: 25),
                items: Genders.values.map((gender) {
                  return DropdownMenuItem<Genders>(
                    value: gender,
                    child: Text(
                      gender.toString().split('.').last,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),

              // Поле ввода возраста
              TextField(
                controller: _yearsController,
                decoration: const InputDecoration(
                  labelText: 'Age (years)',
                ),
                style: const TextStyle(fontSize: 25),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _years = int.tryParse(value) ?? 0;
                  });
                },
              ),

              // Поле ввода роста
              TextField(
                controller: _heightController,
                decoration: const InputDecoration(
                  labelText: 'Height (cm)',
                ),
                style: const TextStyle(fontSize: 25),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _height = int.tryParse(value) ?? 0;
                  });
                },
              ),

              // Поле ввода веса
              TextField(
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight (kgs)',
                ),
                style: const TextStyle(fontSize: 25),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  setState(() {
                    _weight = double.tryParse(value) ?? 0.0;
                  });
                },
              ),

              // Поле ввода уровня активности
              DropdownButtonFormField<ActivityLevels>(
                value: _activityLevel,
                decoration: const InputDecoration(
                  label: Text(
                    'Activity Level',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                style: const TextStyle(fontSize: 25, color: Colors.black),
                items: ActivityLevels.values.map((level) {
                  return DropdownMenuItem<ActivityLevels>(
                    value: level,
                    child: Text(level.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _activityLevel = value;
                  });
                },
              ),

              // Кнопка сохранения данных
              ElevatedButton(
                onPressed: () {
                  UserData userData = UserData(
                    gender: _gender ?? Genders.male,
                    years: _years ?? 30,
                    height: _height ?? 0,
                    weight: _weight ?? 0.0,
                    activityLevel:
                        _activityLevel ?? ActivityLevels.lightlyActive,
                  );

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WeightGoal(userData: userData),
                    ),
                  );
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// Класс для хранения данных пользователя
class UserData {
  final Genders gender;
  final int years;
  final int height;
  final double weight;
  final ActivityLevels activityLevel;

  UserData({
    required this.gender,
    required this.years,
    required this.height,
    required this.weight,
    required this.activityLevel,
  });
}

enum Genders {
  male,
  female,
}

enum ActivityLevels {
  sedentary,
  lightlyActive,
  veryActive,
}
