import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_webview/data/data_layer.dart';

class UrlLogicCubit extends Cubit<String?> {
  UrlLogicCubit({
    LocalConfigApi? localConfig,
    RemoteConfigApi? remoteConfig,
  })  : _localConfig = localConfig ?? Services.instance.localConfig,
        _remoteConfig = remoteConfig ?? Services.instance.remoteConfig,
        super(null);

  final LocalConfigApi _localConfig;
  final RemoteConfigApi _remoteConfig;

  Future<String?> searchUrl() async {
    String? url = await _localConfig.getUrlLocal();
    url ??= await _remoteConfig.getUrlRemote().onError(
          (error, stackTrace) => null,
        );
    if (url != null && url.isNotEmpty) {
      _localConfig.setUrlLocal(url);
    }
    emit(url);
    return url;
  }
}
