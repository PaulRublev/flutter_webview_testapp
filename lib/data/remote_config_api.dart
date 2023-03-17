export 'package:test_app_webview/data/remote_config_impl.dart';

abstract class RemoteConfigApi {
  Future<String?> getUrlRemote();
}
