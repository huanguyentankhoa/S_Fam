
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

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

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
    } catch (e) {
     print(e.toString());
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInitData();
  }

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

}
