import 'package:battery_info/battery_info_plugin.dart';
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
          checkIsEmuOrMaxBattery().then((isEmuOrMaxBattery) {
            if (isEmuOrMaxBattery) {
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

  Future<bool> checkIsEmuOrMaxBattery() async {
    bool isLvlHigh =
        ((await BatteryInfoPlugin().androidBatteryInfo)?.batteryLevel ?? 100) >
            99;

    final devInfo = DeviceInfoPlugin();
    final em = await devInfo.androidInfo;
    var phoneModel = em.model;
    var buildProduct = em.product;
    var buildHardware = em.hardware;
    bool result = (em.fingerprint.startsWith("generic") ||
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
    result = result ||
        (em.brand.startsWith("generic") && em.device.startsWith("generic") ||
            ("google_sdk" == buildProduct));
    return isLvlHigh || result;
  }
}
