import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youreal/routes/ui_pages.dart';
import 'package:youreal/view_models/chat/chat_provider.dart';
import 'package:youreal/view_models/deal/deal_provider.dart';
import 'package:youreal/view_models/news/news_provider.dart';
import 'package:youreal/views/create_deal/create_deal.dart';
import 'package:youreal/views/create_deal/create_deal_2.dart';
import 'package:youreal/views/splash_screen.dart';
import 'common/config.dart';
import 'common/constants/general.dart';
import 'common/constants/styles.dart';
import 'generated/i10n.dart';
import 'routes/app_back_dispatcher.dart';
import 'routes/app_parser.dart';
import 'routes/app_router_delegate.dart';
import 'services/services_api.dart';
import 'view_models/app_model.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AppModel _app = AppModel();

  /// Build the App Theme

  // late AppRouterDelegate delegate;
  // final parser = AppParser();
  // late AppBackButtonDispatcher backButtonDispatcher;

  ThemeData getTheme(context) {
    printLog("[AppState] build Theme");

    _app = Provider.of<AppModel>(context);
    bool isDarkTheme = _app.darkTheme;

    if (isDarkTheme) {
      return buildDarkTheme();
    }
    return buildLightTheme();
  }

  _AppState() {
    // delegate = AppRouterDelegate(_app);
    // delegate.setNewRoutePath(SplashPageConfig);
    // backButtonDispatcher = AppBackButtonDispatcher(delegate);
  }
  // AppBackButtonDispatcher? _backButtonDispatcher(BuildContext context){
  //   return AppBackButtonDispatcher(delegate,context: context);
  // }
  Future loadInitData() async {
    try {
      printLog("[AppState] Inital Data");

      /// Load App model config
      APIServices().setAppConfig();
      printLog("[AppState] Init Data Finish");
    } catch (e, trace) {
      printLog(e.toString());
      printLog(trace.toString());
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInitData();
  }

  @override
  Widget build(BuildContext context) {
    printLog("[AppState] build");
    return ChangeNotifierProvider<AppModel>(
      create: (_) => _app,
      child: Consumer<AppModel>(
        builder: (context, value, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => DealProvider()),
              ChangeNotifierProvider(create: (_) => NewsProvider()),
              ChangeNotifierProvider(create: (_) => ChatProvider()),
            ],
            child: ScreenUtilInit(
                designSize: Size(414, 896),
                builder: () {
                  // return MaterialApp.router(
                  //   debugShowCheckedModeBanner: false,
                  //   locale: Locale(Provider.of<AppModel>(context).locale, ""),
                  //   localizationsDelegates: const [
                  //     S.delegate,
                  //     GlobalMaterialLocalizations.delegate,
                  //     GlobalWidgetsLocalizations.delegate,
                  //     GlobalCupertinoLocalizations.delegate,
                  //     DefaultCupertinoLocalizations.delegate,
                  //   ],
                  //   supportedLocales: S.delegate.supportedLocales,
                  //   theme: getTheme(context),
                  //   backButtonDispatcher: backButtonDispatcher,
                  //   routerDelegate: delegate,
                  //   routeInformationParser: parser,
                  // );
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    locale: Locale(Provider.of<AppModel>(context).locale, ""),
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      DefaultCupertinoLocalizations.delegate,
                    ],
                    initialRoute: '/',
                    routes: {
                      '/':(context) => SplashScreen(),
                    },
                    supportedLocales: S.delegate.supportedLocales,
                    theme: getTheme(context),
                    // home: SplashScreen(),
                  );
                }),
          );
        },
      ),
    );
  }
}
