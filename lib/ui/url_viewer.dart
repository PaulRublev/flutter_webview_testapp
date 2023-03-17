import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app_webview/business/business_layer.dart';

class UrlViewer extends StatefulWidget {
  const UrlViewer({super.key});

  @override
  State<UrlViewer> createState() => _UrlViewerState();
}

class _UrlViewerState extends State<UrlViewer> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UrlLogicCubit>(context, listen: false)
        .searchUrl()
        .then((url) {
      if (url != null && url.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          context.go('/mock');
        });
      } else if (url != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          context.go('/browser');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
