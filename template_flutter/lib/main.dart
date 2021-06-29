import 'dart:async';
import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/view_models/notification/firebase_notification_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'app.dart';
import 'common/constants/general.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  printLog('[main] ============== main.dart START ==============');
await Firebase.initializeApp();
FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  /// enable network traffic logging
  HttpClient.enableTimelineLogging = false;
  await AndroidAlarmManager.initialize();
  runZoned(() {
    runApp(App());
  });
  AssetPicker.registerObserve();
}

Future<void> _backgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
  print("Handle background service $message");
  dynamic data = message.data["data"];
  FirebaseNotification.showNotification(data["title"], data["body"]);
}
