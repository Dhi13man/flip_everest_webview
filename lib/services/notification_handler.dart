import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:flip_everest/views/app_webview.dart';

/// Class having methods to handle all the OneSignal Functionality
/// listening to all Notification triggers in the background with callbacks.
/// 
/// Pass in the OneSignal [appID]
class NotificationHandler {
  NotificationHandler({required String appID}) {
    OneSignal.shared.setAppId(appID);
  }

  /// Gets Location permission from Users on IoS if not already given
  Future<bool> getPermission() async =>
      await OneSignal.shared.promptUserForPushNotificationPermission();

  /// Establishes all the background notification callbacks 
  /// telling app how to react.
  void establishCallbacks(BuildContext context) {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent notification) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
    });

    // Called when Notification opened by user.
    OneSignal.shared.setNotificationOpenedHandler(
      (OSNotificationOpenedResult result) {
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
    //(relevant only for iPhones)
    OneSignal.shared.setPermissionObserver(
      (OSPermissionStateChanges changes) {
        // Will be called whenever the permission changes
        // (ie. user taps Allow on the permission prompt in iOS)
        if (changes.to.status == OSNotificationPermission.denied ||
            changes.to.status == OSNotificationPermission.notDetermined)
          getPermission().then(
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
