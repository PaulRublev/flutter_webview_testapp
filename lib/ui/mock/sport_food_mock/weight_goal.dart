import 'package:flutter/material.dart';
import 'package:test_app_webview/ui/mock/sport_food_mock/user_data_widget.dart';

const calcBackDecoration = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/calc_back.jpg'),
    fit: BoxFit.none,
    scale: 1.3,
    alignment: Alignment.topCenter,
    repeat: ImageRepeat.repeatY,
    colorFilter: ColorFilter.mode(
      Colors.white30,
      BlendMode.colorDodge,
    ),
  ),
);

class WeightGoal extends StatefulWidget {
  const WeightGoal({super.key, required this.userData});

  final UserData userData;

  @override
  State<WeightGoal> createState() => _WeightGoalState();
}

class _WeightGoalState extends State<WeightGoal> {
  double _goalWeight = 0.0;
  bool _isCalculated = false;
  String _text = '';

  final _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Enter your goal weight'),
      ),
      body: SafeArea(
        child: Container(
          decoration: calcBackDecoration,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // Поле ввода желаемого веса
                      TextField(
                        controller: _weightController,
                        decoration: const InputDecoration(
                          label: Text(
                            'Goal weight (kgs)',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        style: const TextStyle(fontSize: 25),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          setState(() {
                            _goalWeight = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),

                      // Кнопка рассчета
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _calculate(widget.userData);
                            _isCalculated = true;
                          });
                        },
                        child: const Text('Calculate'),
                      ),
                      _isCalculated
                          ? Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _text,
                                textScaleFactor: 1.7,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: OutlinedButton(
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 35,
                            child: Text(
                              _getGender(widget.userData),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blue,
                            child: Text(
                              widget.userData.years.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          CircleAvatar(
                            radius: 43,
                            backgroundColor: Colors.blue,
                            child: Text(
                              '${widget.userData.height.toString()} cm',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blue,
                            child: Text(
                              '${widget.userData.weight.toString()} kgs',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.blue,
                            child: Text(
                              _getActivityLvl(widget.userData),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _calculate(UserData userData) {
// минимальная граница калорий в день
    const int minMaleCal = 1800;
    const int minFemaleCal = 1200;

    // базальная скорость метаболизма
    double? bmr;
    if (userData.gender == Genders.male) {
      bmr = 88.36 +
          (13.4 * userData.weight) +
          (4.8 * userData.height) -
          (5.7 * userData.years);
    } else {
      {
        bmr = 447.6 +
            (9.2 * userData.weight) +
            (3.1 * userData.height) -
            (4.3 * userData.years);
      }
    }
    switch (userData.activityLevel) {
      case ActivityLevels.sedentary:
        bmr *= 1.2;
        break;
      case ActivityLevels.lightlyActive:
        bmr *= 1.375;
        break;
      default:
        bmr *= 1.725;
    }

    double kgs = _goalWeight - userData.weight; // < 0, если нужно худеть
    double cal = 0;
    int months = 0;
    if (kgs < 0) {
      cal = kgs * 10000;
      months = cal ~/
          (30 *
              (bmr -
                  (userData.gender == Genders.male
                      ? minMaleCal
                      : minFemaleCal)));
      months = months.abs() + 1;
    } else {
      cal = kgs * 10000;
      months = cal ~/ (30 * bmr);
    }
    if (months <= 0) months = 1;
    double calories = (bmr + (cal / months) / 30);

    if (months > 12 ||
        (calories <
            (userData.gender == Genders.male ? minMaleCal : minFemaleCal))) {
      _text = 'Your diet is ineffective or data is incorrect';
    } else {
      _text =
          'You must consume ${calories.toInt()} calories in a day for a $months months';
    }
  }

  String _getActivityLvl(UserData userData) {
    switch (userData.activityLevel) {
      case ActivityLevels.sedentary:
        return 'S';
      case ActivityLevels.lightlyActive:
        return 'M';
      case ActivityLevels.veryActive:
        return 'L';
      default:
        return 'L';
    }
  }

  String _getGender(UserData userData) {
    switch (userData.gender) {
      case Genders.male:
        return 'M';
      case Genders.female:
        return 'W';
      default:
        return 'N';
    }
  }
}
