import 'package:flutter/material.dart';
import 'package:test_app_webview/ui/mock/mocks/mock_list.dart';

class MockWidget extends StatelessWidget {
  const MockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MockList.getMockWidget();
  }
}
