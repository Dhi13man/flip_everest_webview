import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
