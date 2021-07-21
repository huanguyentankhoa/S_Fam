import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/view_models/app_provider.dart';

import '../user_provider.dart';

class NotificationHandler {
  static final flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  static late BuildContext myContext;

  static void initNotification(BuildContext context) {
    myContext = context;
    var initAndroid = AndroidInitializationSettings("@mipmap/appicon");
    var initIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initSetting =
        InitializationSettings(android: initAndroid, iOS: initIOS);
    flutterLocalNotificationPlugin.initialize(initSetting,
        onSelectNotification: (title) {
      if (title == "Yêu cầu trợ giúp") {
        Provider.of<AppProvider>(context, listen: false).tabMainSelected = 3;
      }
      if (title == "Khẩn cấp") {
        Provider.of<AppProvider>(context, listen: false).tabMainSelected = 3;
        Provider.of<UserProvider>(context, listen: false).haveWarning = false;
      }
      return onSelectNotification(title);
    });
  }

  static Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    showDialog(
        context: myContext,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title!),
              content: Text(body!),
              actions: [
                CupertinoDialogAction(
                  child: Text("OK"),
                  isDefaultAction: true,
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                ),
              ],
            ));
  }

  static Future onSelectNotification(String? payload) async {
    if (payload != null) print("Get payload: $payload");
    FlutterRingtonePlayer.stop();
  }
}
