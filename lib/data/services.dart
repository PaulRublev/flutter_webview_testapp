import 'package:test_app_webview/data/data_layer.dart';

class Services {
  static final instance = Services();
  late RemoteConfigApi remoteConfig;
  late LocalConfigApi localConfig;

  void initialize({
    RemoteConfigApi? remoteConfig,
    LocalConfigApi? localConfig,
  }) {
    // this.remoteConfig = remoteConfig ?? RemoteConfigImpl();
    this.remoteConfig = remoteConfig ?? FirebaseConfig.instance;
    this.localConfig = localConfig ?? LocalConfigImpl();
  }
}
