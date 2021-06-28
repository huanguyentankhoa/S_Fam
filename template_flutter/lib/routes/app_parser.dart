import 'package:flutter/material.dart';
import 'ui_pages.dart';

class AppParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return SplashPageConfig;
    }

    final path = uri.pathSegments[0];
    switch (path) {
      case SplashPath:
        return SplashPageConfig;
      case LoginPath:
        return LoginPageConfig;
      case Login1Path:
        return LoginPage1Config;
      case Login2Path:
        return LoginPage2Config;
      case Login3Path:
        return LoginPage3Config;
      case Login4Path:
        return LoginPage4Config;
      case SetupGroupPath:
        return SetupGroupConfig;
      case SignInPath:
        return SignInPageConfig;
      case HomePath:
        return HomePageConfig;
      case DetailPath:
        return DetailPageConfig;
      case Detail1Path:
        return DetailPage1Config;
      case Detail2Path:
        return DetailPage2Config;
      case Detail3Path:
        return DetailPage3Config;
      case Detail4Path:
        return DetailPage4Config;
      case Detail5Path:
        return DetailPage5Config;
      case Detail6Path:
        return DetailPage6Config;
      default:
        return SplashPageConfig;
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.Splash:
        return const RouteInformation(location: SplashPath);
      case Pages.Login:
        return const RouteInformation(location: LoginPath);
      case Pages.Login1:
        return const RouteInformation(location: Login1Path);
      case Pages.Login2:
        return const RouteInformation(location: Login2Path);
      case Pages.Login3:
        return const RouteInformation(location: Login3Path);
      case Pages.Login4:
        return const RouteInformation(location: Login4Path);
      case Pages.SetupGroup:
        return const RouteInformation(location: SetupGroupPath);
      case Pages.MainPage:
        return const RouteInformation(location: MainPagePath);
      case Pages.SignIn:
        return const RouteInformation(location: SignInPath);
      case Pages.Home:
        return const RouteInformation(location: HomePath);
      case Pages.Detail:
        return const RouteInformation(location: DetailPath);
      case Pages.Detail1:
        return const RouteInformation(location: Detail1Path);
      case Pages.Detail2:
        return const RouteInformation(location: Detail2Path);
      case Pages.Detail3:
        return const RouteInformation(location: Detail3Path);
      case Pages.Detail4:
        return const RouteInformation(location: Detail4Path);
      case Pages.Detail5:
        return const RouteInformation(location: Detail5Path);
      case Pages.Detail6:
        return const RouteInformation(location: Detail6Path);
      case Pages.CreateDeal:
        return const RouteInformation(location: CreateDealPath);
      case Pages.CreateDeal_2:
        return const RouteInformation(location: CreateDeal_2Path);
      case Pages.CreateDealComplete:
        return const RouteInformation(location: CreateDealCompletePath);


      default: return const RouteInformation(location: SplashPath);

    }
  }
}