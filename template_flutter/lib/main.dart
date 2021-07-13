import 'dart:async';
import 'dart:io';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'app.dart';
import 'common/constants/general.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await FlutterDownloader.initialize(
  //     debug: false
  // );
  Provider.debugCheckInvalidValueType = null;
  printLog('[main] ============== main.dart START ==============');
await Firebase.initializeApp();
  /// enable network traffic logging
  HttpClient.enableTimelineLogging = false;
  runZoned(() {
    runApp(App());
  });
  AssetPicker.registerObserve();
}

