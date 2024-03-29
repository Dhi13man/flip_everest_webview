import 'package:flip_everest/view/screens/app_webview.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

/// Class having methods to handle all the OneSignal Functionality
/// listening to all Notification triggers in the background with callbacks.
///
/// Pass in the OneSignal [appID]
class NotificationHandler {
  NotificationHandler({required String appID}) {
    OneSignal.initialize(appID);
  }

  /// Gets Location permission from Users on IoS if not already given
  Future<bool> getPermission() async =>
      await OneSignal.Notifications.requestPermission(true);

  /// Establishes all the background notification callbacks telling app how to
  /// react.
  void establishCallbacks(BuildContext context) {
    OneSignal.Notifications.addForegroundWillDisplayListener(
      (OSNotificationWillDisplayEvent notification) {
        // Will be called whenever a notification is received in foreground
        // Display Notification, pass null param for not displaying the notification
      },
    );

    // Called when Notification opened by user.
    OneSignal.Notifications.addClickListener(
      (OSNotificationClickEvent result) {
        final String postURL = result.notification.additionalData?['url'] ?? '';
        // Will be called whenever a notification is opened/button pressed.
        if (Uri.tryParse(postURL) != null)
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WebViewAppPage(webviewURL: postURL),
            ),
          );
      },
    );

    // Called any time Notification permission status changes
    // (relevant only for iPhones)
    OneSignal.Notifications.addPermissionObserver(
      (bool permissionState) {
        // Will be called whenever the permission changes
        // (ie. user taps Allow on the permission prompt in iOS)
        if (permissionState) {
          return;
        }

        OneSignal.Notifications.requestPermission(true).then(
          (bool wasPermissionGiven) {
            if (!wasPermissionGiven)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Notification permission not given!'),
                ),
              );
          },
        );
      },
    );
  }
}
