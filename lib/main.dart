import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flip_everest/notification_handler.dart';

const String homePageURL = 'https://flipeverest.com';

void main() => runApp(WebViewApp());

class WebViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlipEverest App',
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: (settings) {
        //Put other routes (if any) above this if condition
        if (Uri.tryParse(homePageURL + (settings.name ?? '')) != null)
          return MaterialPageRoute(
            builder: (context) => WebViewAppPage(
              webviewURL: homePageURL + (settings.name ?? ''),
            ),
          );
        return MaterialPageRoute(builder: (context) => const WebViewAppPage());
      },
      home: const WebViewAppPage(),
    );
  }
}

class WebViewAppPage extends StatefulWidget {
  const WebViewAppPage({Key? key, String? webviewURL})
      : webviewURL = webviewURL ?? homePageURL,
        super(key: key);

  final String webviewURL;

  @override
  _WebViewAppPageState createState() => _WebViewAppPageState();
}

class _WebViewAppPageState extends State<WebViewAppPage> {
  late bool isWebViewLoading;
  late NotificationHandler notificationHandler;

  @override
  void initState() {
    // One Signal
    notificationHandler = NotificationHandler(
      appID: 'ed0f17f0-aef7-4557-a1c9-bbdc88869a50',
    );
    if (!Platform.isAndroid)
      notificationHandler.getPermission().then(
        (bool wasPermissionGiven) {
          if (!wasPermissionGiven)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: const Text('Notification permission not given!')),
            );
        },
      );
    notificationHandler.establishCallbacks(context);

    // Enable hybrid composition Webview.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    isWebViewLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color stackItemsColor = Color(0xFF02ACB0);
    return Scaffold(
      backgroundColor: stackItemsColor,
      body: Stack(
        children: <Widget>[
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            allowsInlineMediaPlayback: true,
            initialUrl: widget.webviewURL,
            onPageStarted: (String url) =>
                setState(() => isWebViewLoading = true),
            onPageFinished: (String url) =>
                setState(() => isWebViewLoading = false),
            onWebResourceError: (WebResourceError error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('URL load failed: ${error.failingUrl}')),
              );
              setState(() => isWebViewLoading = false);
            },
          ),
          if (isWebViewLoading)
            const LoadingItems(loadingScreenBackgroundColor: stackItemsColor),
        ],
      ),
    );
  }
}

class LoadingItems extends StatelessWidget {
  const LoadingItems({Key? key, required this.loadingScreenBackgroundColor})
      : super(key: key);

  final Color loadingScreenBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      alignment: Alignment.center,
      color: loadingScreenBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Padding(
            padding: const EdgeInsets.all(30),
            child: Image(
              height: 150,
              width: 250,
              image: AssetImage('assets/logobg.png')
            ),
          ),
          CircularProgressIndicator(color: Colors.white),
        ],
      ),
    );
  }
}
