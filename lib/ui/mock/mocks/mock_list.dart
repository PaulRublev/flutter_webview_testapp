import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_app_webview/ui/mock/mocks/flutter_logo_view.dart';

class MockList {
  static final List<Widget> _mockList = <Widget>[
    const FlutterLogoView(),
  ];

  static Widget getMockWidget() {
    if (_mockList.isEmpty) return Container();
    int rand = Random().nextInt(_mockList.length);
    return _mockList[rand];
  }
}
