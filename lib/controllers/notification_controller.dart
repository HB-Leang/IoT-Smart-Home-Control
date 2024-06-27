import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    _resetBadgeCount();
    super.onInit();
  }

  void flameNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: "Flame Channel",
        title: "Flame Detected! 🔥🔥🔥",
        body: "There is flame detected in the house!!🧯🧯",
      ),
    );
  }

  void gasNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: createUniqueId(),
          channelKey: "Gas Channel",
          title: "Gas Detected! ⚠️ ⚠️",
          body: "There is gas detected in the kitchen!!"),
    );
  }

  void rainNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: createUniqueId(),
          channelKey: "Raindrop Channel",
          title: "Raindrop Detected! 🌧️🌧️🌧️",
          body:
              "Raindrop detected on the sensor.💧\nPerfoming required tasks in the house."),
    );
  }

  int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(10000);
  }

  void _resetBadgeCount() {
    AwesomeNotifications().resetGlobalBadge();
  }
}
