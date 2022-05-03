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
[√] Flutter (Channel stable, 2.10.5, on Microsoft Windows [Version 10.0.19044.1645], locale en-IN)
    • Flutter version 2.10.5 at D:\flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 5464c5bac7 (2 weeks ago), 2022-04-18 09:55:37 -0700
    • Engine revision 57d3bac3dd
    • Dart version 2.16.2
    • DevTools version 2.9.2

[√] Android toolchain - develop for Android devices (Android SDK version 30.0.2)
    • Android SDK at D:\androidsdks
    • Platform android-31, build-tools 30.0.2
    • ANDROID_SDK_ROOT = D:\androidsdks
    • Java binary at: D:\Program Files\JetBrains\apps\AndroidStudio\ch-0\193.6626763\jre\bin\java
    • Java version OpenJDK Runtime Environment (build 1.8.0_242-release-1644-b01)
    • All Android licenses accepted.

[√] Chrome - develop for the web
    • Chrome at C:\Program Files (x86)\Google\Chrome\Application\chrome.exe

[√] Visual Studio - develop for Windows (Visual Studio Community 2019 16.8.3)
    • Visual Studio at D:\Program Files\Visual Studio
    • Visual Studio Community 2019 version 16.8.30804.86
    • Windows 10 SDK version 10.0.18362.0

[√] Android Studio (version 4.0)
    • Android Studio at D:\Program Files\JetBrains\apps\AndroidStudio\ch-0\193.6626763
    • Flutter plugin version 51.0.1
    • Dart plugin version 193.7547
    • Java version OpenJDK Runtime Environment (build 1.8.0_242-release-1644-b01)

[√] IntelliJ IDEA Ultimate Edition (version 2020.2)
    • IntelliJ at D:\Program Files\JetBrains\apps\IDEA-U\ch-0\202.6397.94
    • Flutter plugin can be installed from:
       https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
       https://plugins.jetbrains.com/plugin/6351-dart

[√] VS Code (version 1.66.2)
    • VS Code at C:\Users\dhi13man\AppData\Local\Programs\Microsoft VS Code
    • Flutter extension version 3.40.0

[√] Connected device (3 available)
    • Windows (desktop) • windows • windows-x64    • Microsoft Windows [Version 10.0.19044.1645]
    • Chrome (web)      • chrome  • web-javascript • Google Chrome 100.0.4896.127
    • Edge (web)        • edge    • web-javascript • Microsoft Edge 101.0.1210.32

[√] HTTP Host Availability
    • All required HTTP hosts are available

• No issues found!
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
