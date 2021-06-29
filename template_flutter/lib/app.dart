
import 'package:after_layout/after_layout.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/view_models/events/event_provider.dart';
import 'package:s_fam/view_models/notification/firebase_notification_handler.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/splash_screen.dart';

import 'common/config.dart';
import 'common/constants/general.dart';
import 'common/constants/styles.dart';
import 'generated/i10n.dart';
import 'services/services_api.dart';
import 'view_models/app_provider.dart';
//import 'package:onesignal_flutter/onesignal_flutter.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with AfterLayoutMixin{
  //final _app = AppModel();

  String _debugLabelString = "";
  bool _enableConsentButton = false;

  // CHANGE THIS parameter to true if you want to test GDPR privacy consent
  bool _requireConsent = true;
  FirebaseNotification firebaseNotification = FirebaseNotification();
  final _app = AppProvider();

  /// Build the App Theme
  ThemeData getTheme(context) {
    printLog("[AppState] build Theme");

    AppProvider appModel = Provider.of<AppProvider>(context);
    bool isDarkTheme = appModel.darkTheme;

    if (isDarkTheme) {
      return buildDarkTheme();
    }
    return buildLightTheme();
  }
  Future<void> loadInitData() async {
    try {

      /// Load App model config
      APIServices().setAppConfig(serverConfig);
    } catch (e, trace) {
      printLog(e.toString());
      printLog(trace.toString());
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     //initPlatformState();
    loadInitData();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification!=null){
        print(message.notification!.title);
      }
    });
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      firebaseNotification.setupFirebase(context);
    });
  }

  // Future<void> initPlatformState() async {
  //   if (!mounted) return;
  //
  //   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  //
  //   OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);
  //
  //   OneSignal.shared
  //       .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //     print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
  //     this.setState(() {
  //       _debugLabelString =
  //       "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
  //     });
  //   });
  //
  //   OneSignal.shared
  //       .setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
  //     print('FOREGROUND HANDLER CALLED WITH: ${event}');
  //     /// Display Notification, send null to not display
  //     event.complete(null);
  //
  //     this.setState(() {
  //       _debugLabelString =
  //       "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
  //     });
  //   });
  //
  //   OneSignal.shared
  //       .setInAppMessageClickedHandler((OSInAppMessageAction action) {
  //     this.setState(() {
  //       _debugLabelString =
  //       "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}";
  //     });
  //   });
  //
  //   OneSignal.shared
  //       .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
  //     print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
  //   });
  //
  //   OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
  //     print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
  //   });
  //
  //   OneSignal.shared.setEmailSubscriptionObserver(
  //           (OSEmailSubscriptionStateChanges changes) {
  //         print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
  //       });
  //
  //   OneSignal.shared.setSMSSubscriptionObserver(
  //           (OSSMSSubscriptionStateChanges changes) {
  //         print("SMS SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
  //       });
  //
  //   // NOTE: Replace with your own app ID from https://www.onesignal.com
  //   await OneSignal.shared
  //       .setAppId("cf4f1249-e830-4362-86c0-0e0820d48ebd");
  //
  //   bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();
  //
  //   this.setState(() {
  //     _enableConsentButton = requiresConsent;
  //   });
  //
  //   OneSignal.shared.consentGranted(true);
  //   bool userProvidedPrivacyConsent = await OneSignal.shared.userProvidedPrivacyConsent();
  //   print("USER PROVIDED PRIVACY CONSENT: $userProvidedPrivacyConsent");
  // }



@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create:(_)=> _app,
      child: Consumer<AppProvider>(
        builder: (context, value, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: EventProvider()),
              ChangeNotifierProvider.value(value: UserProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: Locale(Provider.of<AppProvider>(context).locale, ""),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: getTheme(context),
              home: SplashScreen(),
            ),
          );
        },
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout

  }


}
