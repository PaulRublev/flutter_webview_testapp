import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_webview/business/business_layer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatefulWidget {
  const Browser({super.key});

  @override
  State<Browser> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000));

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
      if (systemOverlaysAreVisible) {
        Future.delayed(const Duration(seconds: 3)).then((value) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<UrlLogicCubit, String?>(
          builder: (context, state) {
            _controller
                .loadRequest(Uri.parse(state ?? 'https://www.youtube.com/'));
            return WillPopScope(
              onWillPop: () {
                return _popOrGoBack(
                    context, state ?? 'https://www.youtube.com/');
              },
              child: WebViewWidget(
                controller: _controller,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _popOrGoBack(BuildContext context, String url) async {
    if (await _controller.currentUrl() == url) return false;
    if (await _controller.canGoBack()) {
      _controller.goBack();
    }
    return Future.value(false);
  }
}
