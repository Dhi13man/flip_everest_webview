# flip_everest

Flutter Cross-Platform Webview Application made for a client, with custom Splash Screen, App Logo, and OneSignal Push Notifications, configured to trigger on Wordpress Site Update.

The [Original Website](https://flipeverest.com/) has been converted to a Flutter Webview Application. The UI consists of:

1. A Native Splash Screen
2. `WebViewAppPage:` WebView Screen, which loads the web app that the application has been made for.
3. `LoadingScreen:` Loading Screen, to be shown while the WebView loads.

A OneSignal Notification Handler `NotificationHandler` is also provided, which handles the push notifications sent from OneSignal.

## App Releases

1. [Google Play Store](https://play.google.com/store/apps/details?id=com.dhi13man.flip_everest)
2. [Apple Play Store](https://itunes.apple.com/us/app/flip-everest/id1489749074?mt=8)

## Screenshots

| Loading Screen | WebView Screen |
|:---:|:---:|
| ![Loading Screen](https://raw.githubusercontent.com/dhi13man/flip_everest_webview/main/screenshots/LoadingScreen.jpg) | ![WebView Screen](https://raw.githubusercontent.com/dhi13man/flip_everest_webview/main/screenshots/WebView.jpg) |

| Push Notifications |
|:---:|
| ![Push Notifications](https://raw.githubusercontent.com/dhi13man/flip_everest_webview/main/screenshots/PushNotification.jpg) |

### Dependencies

1. [webview_flutter](https://pub.dev/webview_flutter), used to render the WebView on Flutter.

2. [onesignal_flutter](https://pub.dev/onesignal_flutter), used to handle push notifications recieved from Wordpress Website Update.

3. [flutter_native_splash](https://pub.dev/flutter_native_splash), used to easily generate the Native Splash Screen.

### Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
