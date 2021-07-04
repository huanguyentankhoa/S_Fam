import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:s_fam/services/services_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_handler.dart';

class FirebaseNotification {
  late FirebaseMessaging _messaging;
  late BuildContext myContext;

  void setupFirebase(BuildContext context, String email) {
    _messaging = FirebaseMessaging.instance;
    NotificationHandler.initNotification(context);
    firebaseCloudMessageListener(context, email);
    myContext = context;
  }

  void firebaseCloudMessageListener(BuildContext context, String email) async {
    final prefs = await SharedPreferences.getInstance();
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    print("Setting ${settings.authorizationStatus}");
    //get token
    //We will use token to receive notification
    _messaging.getToken().then((token) {
      APIServices().sendFirebaseToken(email: email, token: token);
      prefs.setString("TokenFirebase", token.toString());
    });

    //Subscribe to topic
    //we will send to topic for group notification
    _messaging
        .subscribeToTopic("template_notification")
        .whenComplete(() => print("Subscribe OK"));

    //Handle message
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      if (Platform.isAndroid)
        showNotification(remoteMessage.notification!.title,
            remoteMessage.notification!.body);
      else if (Platform.isIOS)
        showNotification(remoteMessage.notification!.title,
            remoteMessage.notification!.body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      print("Receive open app: $remoteMessage");
      if (Platform.isIOS)
        showDialog(
            context: myContext,
            builder: (context) => CupertinoAlertDialog(
                  title: Text(remoteMessage.notification!.title!),
                  content: Text(remoteMessage.notification!.body!),
                  actions: [
                    CupertinoDialogAction(
                      child: Text("OK"),
                      isDefaultAction: true,
                      onPressed: () => 
                          Navigator.of(context, rootNavigator: true).pop(),
                    ),
                  ],
                ));
    });
  }

  static void showNotification(String? title, String? body) async {
    var androidChannel = AndroidNotificationDetails(
        "com.honghm.s_fam", "My Channel", "Description",
        autoCancel: true,
        ongoing: true,
        importance: Importance.high,
        priority: Priority.high);

    var ios = IOSNotificationDetails();
    var platForm = NotificationDetails(android: androidChannel, iOS: ios);

    await NotificationHandler.flutterLocalNotificationPlugin
        .show(0, title, body, platForm, payload: "My Payload");
  }
}
