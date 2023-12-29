import 'dart:io';

import 'package:flip_everest/controller/webview/webview_controller.dart';
import 'package:flip_everest/services/notification_handler.dart';
import 'package:flip_everest/view/components/page_buttons.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

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
    
    // Create Platform specific Webview creation params.
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    // Create WebViewController from the Platform specific creation params.
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    if (controller.platform is AndroidWebViewController) {
      final AndroidWebViewController androidController =
          controller.platform as AndroidWebViewController;
      AndroidWebViewController.enableDebugging(true);
      androidController.setMediaPlaybackRequiresUserGesture(false);
    }

    // WebView initial states.
    isWebViewLoading = true;
    isPageLoading = true;
    errorOccured = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WebViewController controller =
        createWebviewController(context, stackItemsColor);
    return Scaffold(
      backgroundColor: stackItemsColor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          WebViewWidget(controller: controller),
          if (isPageLoading)
            const Center(
              child: CircularProgressIndicator(color: stackItemsColor),
            ),
          if (errorOccured)
            PageButtons(
              buttonColor: stackItemsColor,
              webViewController: controller,
            ),
          if (isWebViewLoading)
            const LoadingScreen(loadingScreenBackgroundColor: stackItemsColor),
        ],
      ),
    );
  }

  CustomWebviewController createWebviewController(
    BuildContext context,
    Color stackItemsColor,
  ) {
    return CustomWebviewController(
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
