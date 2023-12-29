import 'dart:io';

import 'package:flip_everest/business/utils/webview/webview_controller.dart';
import 'package:flip_everest/business/utils/notifications/notification_handler.dart';
import 'package:flip_everest/view/components/page_buttons.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flip_everest/view/screens/loading_screen.dart';

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
  static const Color stackItemsColor = Color(0xFF02ACB0);

  /// The Webview controller for the Webview.
  late WebViewController webviewController;

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
    super.initState();

    // OneSignal Service Setup
    _registerNotificationHandler();

    // Create WebViewController from the Platform specific creation params.
    webviewController = _bindWebViewControllerToState(stackItemsColor);

    // WebView initial states.
    isWebViewLoading = true;
    isPageLoading = true;
    errorOccured = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stackItemsColor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          WebViewWidget(controller: webviewController),
          if (isPageLoading)
            const Center(
              child: CircularProgressIndicator(color: stackItemsColor),
            ),
          if (errorOccured)
            PageButtons(
              buttonColor: stackItemsColor,
              webViewController: webviewController,
            ),
          if (isWebViewLoading)
            const LoadingScreen(loadingScreenBackgroundColor: stackItemsColor),
        ],
      ),
    );
  }

  void _registerNotificationHandler() {
    notificationHandler = NotificationHandler(appID: 'ONESIGNAL_APP_ID');
    if (!Platform.isAndroid)
      notificationHandler.getPermission().then(
        (bool wasPermissionGiven) {
          if (wasPermissionGiven) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Notification permission not given!'),
            ),
          );
        },
      );
    notificationHandler.establishCallbacks(context);
  }

  WebViewController _bindWebViewControllerToState(Color stackItemsColor) {
    return createWebViewController(
      webviewURL: widget.webviewURL,
      onPageStarted: (String url) => setState(
        () {
          isPageLoading = true;
          errorOccured = false;
        },
      ),
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
              'URL load failed: ${error.url}',
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
    );
  }
}
