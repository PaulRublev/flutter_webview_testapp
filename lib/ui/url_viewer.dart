import 'package:device_info_plus/device_info_plus.dart';
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
          checkIsEmu().then((value) {
            if (value) {
              context.go('/mock');
            } else {
              context.go('/browser');
            }
          });
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          context.go('/');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }

  Future<bool> checkIsEmu() async {
    final devInfo = DeviceInfoPlugin();
    final em = await devInfo.androidInfo;
    var phoneModel = em.model;
    var buildProduct = em.product;
    var buildHardware = em.hardware;
    var result = (em.fingerprint.startsWith("generic") ||
        phoneModel.contains("google_sdk") ||
        phoneModel.contains("droid4x") ||
        phoneModel.contains("Emulator") ||
        phoneModel.contains("Android SDK built for x86") ||
        em.manufacturer.contains("Genymotion") ||
        buildHardware == "goldfish" ||
        buildHardware == "vbox86" ||
        buildProduct == "sdk" ||
        buildProduct == "google_sdk" ||
        buildProduct == "sdk_x86" ||
        buildProduct == "vbox86p" ||
        em.brand.contains('google') ||
        em.board.toLowerCase().contains("nox") ||
        em.bootloader.toLowerCase().contains("nox") ||
        buildHardware.toLowerCase().contains("nox") ||
        !em.isPhysicalDevice ||
        buildProduct.toLowerCase().contains("nox"));
    if (result) return true;
    result = result ||
        (em.brand.startsWith("generic") && em.device.startsWith("generic"));
    if (result) return true;
    result = result || ("google_sdk" == buildProduct);
    return result;
  }
}
