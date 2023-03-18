import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineText extends StatefulWidget {
  const OfflineText({super.key});

  @override
  State<OfflineText> createState() => _OfflineTextState();
}

class _OfflineTextState extends State<OfflineText> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        side: MaterialStateProperty.resolveWith<BorderSide?>(
          (Set<MaterialState> states) {
            return const BorderSide(
              color: Color.fromARGB(0, 0, 0, 0),
            );
          },
        ),
      ),
      onPressed: () {},
      onLongPress: () {
        SharedPreferences.getInstance()
            .then((value) => value.clear()); // clear shared pref
      },
      child: const Text('Network connection required to continue'),
    );
  }
}
