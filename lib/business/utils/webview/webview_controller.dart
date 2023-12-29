import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

WebViewController createWebViewController({
  required String webviewURL,
  void Function(String)? onPageStarted,
  void Function(String)? onPageFinished,
  void Function(WebResourceError)? onWebResourceError,
}) {
  // Create Platform specific Webview creation params.
  late final PlatformWebViewControllerCreationParams controllerCreationParams;
  if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    controllerCreationParams = WebKitWebViewControllerCreationParams(
      allowsInlineMediaPlayback: true,
      mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    );
  } else {
    controllerCreationParams = const PlatformWebViewControllerCreationParams();
  }

  // Create WebViewController from the Platform specific creation params.
  final String baseUrl = Uri.parse(webviewURL).origin;
  final WebViewController webviewController =
      WebViewController.fromPlatformCreationParams(controllerCreationParams)
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {},
            onPageStarted: onPageStarted,
            onPageFinished: onPageFinished,
            onWebResourceError: onWebResourceError,
            onNavigationRequest: (NavigationRequest request) {
              if (!request.url.startsWith(baseUrl)) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(webviewURL));

  if (!(webviewController.platform is AndroidWebViewController)) {
    return webviewController;
  }

// Android specific settings
  final AndroidWebViewController androidController =
      webviewController.platform as AndroidWebViewController;
  androidController.setMediaPlaybackRequiresUserGesture(false);
  return webviewController;
}
