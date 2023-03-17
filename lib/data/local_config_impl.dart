import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app_webview/data/local_config_api.dart';

class LocalConfigImpl implements LocalConfigApi {
  final _prefs = SharedPreferences.getInstance();

  @override
  Future<String?> getUrlLocal() async {
    return (await _prefs).getString('url');
  }

  @override
  void setUrlLocal(String url) async {
    await (await _prefs).setString('url', url);
  }
}
