import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:test_app_webview/data/data_layer.dart';
import 'firebase_options.dart';

class FirebaseConfig implements RemoteConfigApi {
  static final instance = FirebaseConfig._();
  late final FirebaseRemoteConfig _remoteConfig;
  FirebaseConfig._();

  @override
  Future<String?> getUrlRemote() async {
    await _firebaseInit();
    await _fetchRemoteConfig();
    return _remoteConfig.getString('url');
  }

  Future<void> _fetchRemoteConfig() async {
    _remoteConfig = FirebaseRemoteConfig.instance;
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 5),
    ));

    await _remoteConfig.fetchAndActivate();
  }

  Future<void> _firebaseInit() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
