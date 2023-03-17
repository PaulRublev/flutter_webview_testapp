import 'package:test_app_webview/data/data_layer.dart';

class DataLayerInitializer {
  static final instance = DataLayerInitializer();

  Future<void> initialize() async {
    Services.instance.initialize();
  }
}
