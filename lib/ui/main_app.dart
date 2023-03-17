import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app_webview/business/business_layer.dart';
import 'package:test_app_webview/ui/browser.dart';
import 'package:test_app_webview/ui/mock/mock_widget.dart';
import 'package:test_app_webview/ui/root.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Root(),
        routes: [
          GoRoute(
            path: 'mock',
            builder: (context, state) => const MockWidget(),
          ),
          GoRoute(
            path: 'browser',
            builder: (context, state) => const Browser(),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UrlLogicCubit(),
      lazy: false,
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Test app',
      ),
    );
  }
}
