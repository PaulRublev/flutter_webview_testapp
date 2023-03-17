import 'package:flutter/material.dart';
import 'package:test_app_webview/business/business_layer.dart';
import 'package:test_app_webview/ui/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataLayerInitializer.instance.initialize();
  runApp(MainApp());
}
