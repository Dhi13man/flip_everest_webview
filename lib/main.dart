import 'package:flip_everest/view/screens/web_fallback_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flip_everest/view/screens/app_webview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const WebViewApp());
  FlutterNativeSplash.remove();
}

/// Main App that runs the WebView.
class WebViewApp extends StatelessWidget {
  const WebViewApp({Key? key}) : super(key: key);

  /// URL of the WebView App's Home Page.
  static const String _homePageURL = 'https://www.flipeverest.com/';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flipeverest App',
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: (settings) {
        // Put other routes (if any) above this if condition
        // Deep Linking here if valid route
        if (Uri.tryParse(_homePageURL + (settings.name ?? '')) != null) {
          return MaterialPageRoute(
            builder: (context) => WebViewAppPage(
              webviewURL: _homePageURL + (settings.name ?? ''),
            ),
          );
        }
        // Invalid route, return Home Page.
        else {
          return MaterialPageRoute(
            builder: (context) => _getHomeWidget(),
          );
        }
      },
      home: _getHomeWidget(),
    );
  }

  Widget _getHomeWidget() {
    return kIsWeb
        ? const WebFallbackScreen(
            homePageURL: _homePageURL,
            backgroundColor: Colors.deepPurple,
          )
        : const WebViewAppPage(webviewURL: _homePageURL);
  }
}
