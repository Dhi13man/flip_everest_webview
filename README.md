# flip_everest

Flutter Cross-Platform Webview Application made for a client, with custom Splash Screen, App Logo, and OneSignal Push Notifications, configured to trigger on Wordpress Site Update.

The [Original Website](https://flipeverest.com/) has been converted to a Flutter Webview Application. The UI consists of:

1. A Native Splash Screen
2. `WebViewAppPage` WebView Screen, which loads the web app that the application has been made for.
3. `LoadingScreen` Loading Screen, to be shown while the WebView loads.

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

## Dependencies

1. [webview_flutter](https://pub.dev/webview_flutter), used to render the WebView on Flutter.

2. [onesignal_flutter](https://pub.dev/onesignal_flutter), used to handle push notifications recieved from Wordpress Website Update.

3. [flutter_native_splash](https://pub.dev/flutter_native_splash), used to easily generate the Native Splash Screen.

---

## Flutter Doctor Output

```out
[✓] Flutter (Channel stable, 3.16.5, on macOS 13.4.1 22F770820d darwin-arm64, locale en-IN)
    • Flutter version 3.16.5 on channel stable at /Users/dhimanseal/Desktop/sdks/flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 78666c8dc5 (10 days ago), 2023-12-19 16:14:14 -0800
    • Engine revision 3f3e560236
    • Dart version 3.2.3
    • DevTools version 2.28.4

[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
    • Android SDK at /Users/dhimanseal/Library/Android/sdk
    • Platform android-34, build-tools 34.0.0
    • Java binary at: /Applications/Android Studio.app/Contents/jbr/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 17.0.7+0-17.0.7b1000.6-10550314)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 14.3.1)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Build 14E300c
    • CocoaPods is installed.

[✓] Chrome - develop for the web
    • Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 2023.1)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 17.0.7+0-17.0.7b1000.6-10550314)

[✓] IntelliJ IDEA Community Edition (version 2023.2.5)
    • IntelliJ at /Applications/IntelliJ IDEA CE.app
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart

[✓] VS Code (version 1.85.1)
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension version 3.80.0

[✓] Connected device (3 available)
    • sdk gphone64 arm64 (mobile) • emulator-5554 • android-arm64  • Android 14 (API 34) (emulator)
    • macOS (desktop)             • macos         • darwin-arm64   • macOS 13.4.1 22F770820d darwin-arm64
    • Chrome (web)                • chrome        • web-javascript • Google Chrome 120.0.6099.129

[✓] Network resources
    • All expected network resources are available.
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

See [LICENSE](LICENSE).
