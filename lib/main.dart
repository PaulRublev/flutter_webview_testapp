import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:test_app_webview/business/business_layer.dart';
import 'package:test_app_webview/ui/main_app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await DataLayerInitializer.instance.initialize();
  FlutterNativeSplash.remove();
  runApp(MainApp());
}
