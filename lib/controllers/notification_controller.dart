import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
    super.onInit();
  }

  void flameNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: "Flame Channel",
        title: "Flame Detected!",
        body: "There is flame detected in the house!!",
      ),
    );
  }

  void gasNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 2,
          channelKey: "Gas Channel",
          title: "Gas Detected!",
          body:
              "There is gas detected in the kitchen!! ${Emojis.activites_balloon}"),
    );
  }

  void rainNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 3,
          channelKey: "Raindrop Channel",
          title: "Raindrop Detected!",
          body:
              "Raindrop detected on the sensor. Perfoming required tasks in the house."),
    );
  }
}
