import 'package:test_app_webview/data/remote_config_api.dart';

class RemoteConfigImpl implements RemoteConfigApi {
  @override
  Future<String?> getUrlRemote() async {
    String url = '';
    await Future.delayed(const Duration(seconds: 1))
        .then((value) => url = 'https://google.com');
    return "";
  }
}
