// export 'package:test_app_webview/data/remote_config_impl.dart';
export 'package:test_app_webview/data/firebase_config.dart';

abstract class RemoteConfigApi {
  Future<String?> getUrlRemote();
}
