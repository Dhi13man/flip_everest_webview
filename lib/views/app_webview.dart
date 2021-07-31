import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flip_everest/services/notification_handler.dart';
import 'package:flip_everest/views/loading_screen.dart';

/// The main app screen displaying the Web app screens as a Webview.
class WebViewAppPage extends StatefulWidget {
  const WebViewAppPage({Key? key, required String webviewURL})
      : webviewURL = webviewURL,
        super(key: key);

  final String webviewURL;

  @override
  _WebViewAppPageState createState() => _WebViewAppPageState();
}

class _WebViewAppPageState extends State<WebViewAppPage> {
  /// Manages Webview
  late WebViewController webViewController;

  /// Initially True. Will become false once the first page of Webview is ready.
  late bool isWebViewLoading;

  /// Initally True. True every time any page is loading.
  late bool isPageLoading;

  /// True when error occurs. False otherwise
  late bool errorOccured;

  /// Handles OneSignal functioanlity
  late NotificationHandler notificationHandler;

  @override
  void initState() {
    // OneSignal Service Setup
    if (Platform.isAndroid || Platform.isIOS) {
      notificationHandler = NotificationHandler(appID: 'ONESIGNAL_APP_ID');
      if (!Platform.isAndroid)
        notificationHandler.getPermission().then(
          (bool wasPermissionGiven) {
            if (!wasPermissionGiven)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Notification permission not given!'),
                ),
              );
          },
        );
      notificationHandler.establishCallbacks(context);
    }

    // Enable hybrid composition WebView.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // WebView initial states.
    isWebViewLoading = true;
    isPageLoading = true;
    errorOccured = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color stackItemsColor = Color(0xFF02ACB0);
    print(errorOccured);
    return Scaffold(
      backgroundColor: stackItemsColor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            allowsInlineMediaPlayback: true,
            initialUrl: widget.webviewURL,
            onPageStarted: (String url) => setState(
              () {
                isPageLoading = true;
                errorOccured = false;
              },
            ),
            onWebViewCreated: (WebViewController c) {
              webViewController = c;
              errorOccured = false;
            },
            onPageFinished: (String url) => setState(
              () {
                isWebViewLoading = false;
                isPageLoading = false;
              },
            ),
            onWebResourceError: (WebResourceError error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'URL load failed: ${error.failingUrl}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: stackItemsColor,
                ),
              );
              setState(
                () {
                  isWebViewLoading = false;
                  isPageLoading = false;
                  errorOccured = true;
                },
              );
            },
          ),
          if (isPageLoading)
            const Center(
              child: CircularProgressIndicator(color: stackItemsColor),
            ),
          if (errorOccured)
            PageButtons(
              buttonColor: stackItemsColor,
              webViewController: webViewController,
            ),
          if (isWebViewLoading)
            const LoadingScreen(loadingScreenBackgroundColor: stackItemsColor),
        ],
      ),
    );
  }
}

/// Page Buttons that show up only when there is an Error in loading Webview.
///
/// When there is no error, the Web App itself can be used for navigation
/// so these are not needed. Pass in the [webViewController] and [buttonColor].
class PageButtons extends StatelessWidget {
  const PageButtons({
    Key? key,
    required this.buttonColor,
    required this.webViewController,
  }) : super(key: key);

  final Color buttonColor;
  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      child: Column(
        children: <Widget>[
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Reload'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
            ),
            onPressed: () => webViewController.reload(),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_back_rounded),
            label: const Text('Back'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
            onPressed: () => webViewController.goBack(),
          ),
        ],
      ),
    );
  }
}
