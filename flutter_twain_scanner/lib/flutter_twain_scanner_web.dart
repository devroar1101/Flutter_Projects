// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'flutter_twain_scanner_platform_interface.dart';

/// A web implementation of the FlutterTwainScannerPlatform of the FlutterTwainScanner plugin.
class FlutterTwainScannerWeb extends FlutterTwainScannerPlatform {
  /// Constructs a FlutterTwainScannerWeb
  FlutterTwainScannerWeb();

  static void registerWith(Registrar registrar) {
    FlutterTwainScannerPlatform.instance = FlutterTwainScannerWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = web.window.navigator.userAgent;
    return version;
  }
}
