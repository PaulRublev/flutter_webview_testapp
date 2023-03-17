export 'package:test_app_webview/data/local_config_impl.dart';

abstract class LocalConfigApi {
  Future<String?> getUrlLocal();

  void setUrlLocal(String url);
}
