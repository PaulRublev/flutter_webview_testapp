import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:go_router/go_router.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late final StreamController<ConnectivityResult> _controller =
      StreamController();
  final Widget loading = const Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: EdgeInsets.only(top: 10),
      child: CircularProgressIndicator(),
    ),
  );
  final Widget offline = const Center(
    child: Text('Network connection required to continue'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addStream(Connectivity().onConnectivityChanged);
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
                // todo check local url -> go wView
                // or request url from Firebase RemConf -> save local, go wView
                // or go mockWidget
                // body = const Browser();
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  context.go('/browser');
                });
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
