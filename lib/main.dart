import 'package:flutter/material.dart';

import 'package:flip_everest/views/app_webview.dart';

void main() => runApp(const WebViewApp());

/// Main App that runs the WebView.
class WebViewApp extends StatelessWidget {
  const WebViewApp({Key? key}) : super(key: key);

  /// URL of the WebView App's Home Page.
  static const String _homePageURL = 'https://flipeverest.com';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flipeverest App',
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: (settings) {
        // Put other routes (if any) above this if condition
        // Deep Linking here if valid route
        if (Uri.tryParse(_homePageURL + (settings.name ?? '')) != null)
          return MaterialPageRoute(
            builder: (context) => WebViewAppPage(
              webviewURL: _homePageURL + (settings.name ?? ''),
            ),
          );

        // Invalid route, return Home Page.
        else return MaterialPageRoute(
          builder: (context) => const WebViewAppPage(webviewURL: _homePageURL),
        );
      },
      home: const WebViewAppPage(webviewURL: _homePageURL),
    );
  }
}
