import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app_webview/ui/url_viewer.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late final StreamController<ConnectivityResult> _controller =
      StreamController();
  final Widget loading = const CircularProgressIndicator();
  final Widget offline = const Text('Network connection required to continue');

  @override
  void initState() {
    super.initState();
    _controller.addStream(Connectivity().onConnectivityChanged);
    // SharedPreferences.getInstance().then((value) => value.clear()); // todo remove
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ConnectivityResult>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          Widget body = loading;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              body = offline;
              break;
            case ConnectionState.none:
              break;
            case ConnectionState.done:
            case ConnectionState.active:
              if (snapshot.hasError ||
                  (snapshot.hasData &&
                      snapshot.data == ConnectivityResult.none)) {
                body = offline;
              } else {
                body = const UrlViewer();
              }
              break;
            default:
          }
          return body;
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
