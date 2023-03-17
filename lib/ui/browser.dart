import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_webview/business/business_layer.dart';

class Browser extends StatelessWidget {
  const Browser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<UrlLogicCubit, String?>(
          builder: (context, state) {
            return Text('webview\n$state');
          },
        ),
      ),
    );
  }
}
