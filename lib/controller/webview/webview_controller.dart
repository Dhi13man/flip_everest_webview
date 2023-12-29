import 'package:webview_flutter/webview_flutter.dart';

class CustomWebviewController extends WebViewController {
  CustomWebviewController({
    required String webviewURL,
    void Function(String)? onPageStarted,
    void Function(String)? onPageFinished,
    void Function(WebResourceError)? onWebResourceError,
  }) : super() {
    final String baseUrl = Uri.parse(webviewURL).origin;
    this
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
  }
}
