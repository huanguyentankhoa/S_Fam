import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/views/create_deal/create_deal.dart';
import 'package:youreal/views/create_deal/create_deal_complete.dart';
import 'package:youreal/views/create_deal/create_deal_2.dart';
import 'package:youreal/views/home/home_screen.dart';
import 'package:youreal/views/login/login_screen.dart';
import 'package:youreal/views/main_screen.dart';
import 'package:youreal/views/splash_screen.dart';

import '../views/detail/change_owner.dart';
import '../views/detail/close_deal.dart';
import '../views/detail/closing_investors.dart';
import '../views/detail/connect_investors.dart';
import '../views/detail/detail_deal.dart';
import '../views/detail/full_payment.dart';
import '../views/detail/sign_investment_contract.dart';
import '../views/login/login_with_phone_number.dart';
import '../views/setup_group/setup_group.dart';
import 'app_back_dispatcher.dart';
import 'ui_pages.dart';
import 'ui_pages.dart';
import 'ui_pages.dart';
import 'ui_pages.dart';

class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final List<Page> _pages = [];
  late AppBackButtonDispatcher backButtonDispatcher;

  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppModel appModel;

  AppRouterDelegate(this.appModel) : navigatorKey = GlobalKey() {
    appModel.addListener(() {
      notifyListeners();
    });
  }

  /// Getter for a list that cannot be changed
  List<MaterialPage> get pages => List.unmodifiable(_pages);

  /// Number of pages function
  int numPages() => _pages.length;

  @override
  PageConfiguration get currentConfiguration =>
      _pages.last.arguments as PageConfiguration;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: buildPages(),
    );
  }

  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  void _removePage(Page page) {
    _pages.remove(page);
  }

  void pop() {
    if (canPop()) {
      _removePage(_pages.last);
    }
  }

  bool canPop() {
    return _pages.length > 1;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(_pages.last);
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
        child: child,
        key: ValueKey(pageConfig.key),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    _pages.add(
      _createPage(child, pageConfig),
    );
  }

  void addPage(PageConfiguration pageConfig) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            pageConfig.uiPage;
    if (shouldAddPage) {
      switch (pageConfig.uiPage) {
        case Pages.Splash:
          _addPageData(SplashScreen(), SplashPageConfig);
          break;
        case Pages.Login:
          _addPageData(LoginScreen(), LoginPageConfig);
          break;
        case Pages.Login1:
          _addPageData(LoginWithPhoneNumber(), LoginPage1Config);
          break;
        case Pages.Login2:
          //_addPageData(LoginScreen(), LoginPageConfig);
          break;
        case Pages.Login3:
          //_addPageData(LoginScreen(), LoginPageConfig);
          break;
        case Pages.Login4:
          //_addPageData(LoginScreen(), LoginPageConfig);
          break;
        case Pages.SignIn:
          //_addPageData(SignInScreen(), SignInPageConfig);
          break;
          break;
        case Pages.MainPage:
          _addPageData(MainScreen(), MainPageConfig);
          break;
        case Pages.SetupGroup:
          _addPageData(SetupGroup(), SetupGroupConfig);
          break;
        case Pages.Home:
          _addPageData(HomeScreen(), HomePageConfig);
          break;
        case Pages.Detail:
        case Pages.Detail1:
        case Pages.Detail2:
        case Pages.Detail3:
        case Pages.Detail4:
        case Pages.Detail5:
        case Pages.Detail6:
          if (pageConfig.currentPageAction != null) {
            _addPageData(pageConfig.currentPageAction!.widget!, pageConfig);
          }
          break;

        case Pages.CreateDeal:
          _addPageData(CreateDealScreen(), CreateDealConfig);
          break;
        case Pages.CreateDeal_2:
          _addPageData(CreateDeal_2(), CreateDeal_2Config);
          break;
        case Pages.CreateDealComplete:
          _addPageData(CreateDealComplete(), CreateDealConfig);
          break;
        default:
          break;
      }
    }
  }

  void replace(PageConfiguration newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
  }

  void replaceAll(PageConfiguration newRoute) {
    setNewRoutePath(newRoute);
  }

  void push(PageConfiguration newRoute) {
    addPage(newRoute);
  }

  void pushWidget(Widget child, PageConfiguration newRoute) {
    _addPageData(child, newRoute);
  }

  void addAll(List<PageConfiguration> routes) {
    _pages.clear();
    routes.forEach((route) {
      addPage(route);
    });
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    // print((_pages.last.arguments as PageConfiguration).uiPage);
    // print(configuration.uiPage);

    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            configuration.uiPage;
    if (shouldAddPage) {
      _pages.clear();
      addPage(configuration);
    }
    return SynchronousFuture(null);
  }

  void _setPageAction(PageAction action) {
    switch (action.page!.uiPage) {
      case Pages.Splash:
        SplashPageConfig.currentPageAction = action;
        break;
      case Pages.Login:
        LoginPageConfig.currentPageAction = action;
        break;
      case Pages.Login1:
        LoginPage1Config.currentPageAction = action;
        break;
      case Pages.Login2:
        LoginPage2Config.currentPageAction = action;
        break;
      case Pages.Login3:
        LoginPage3Config.currentPageAction = action;
        break;
      case Pages.Login4:
        LoginPage4Config.currentPageAction = action;
        break;
      case Pages.SignIn:
        SignInPageConfig.currentPageAction = action;
        break;
      case Pages.SetupGroup:
        SetupGroupConfig.currentPageAction = action;
        break;
      case Pages.Home:
        HomePageConfig.currentPageAction = action;
        break;
      case Pages.Detail:
        DetailPageConfig.currentPageAction = action;
        break;
      case Pages.Detail1:
        DetailPage1Config.currentPageAction = action;
        break;
      case Pages.Detail2:
        DetailPage2Config.currentPageAction = action;
        break;
      case Pages.Detail3:
        DetailPage3Config.currentPageAction = action;
        break;
      case Pages.Detail4:
        DetailPage4Config.currentPageAction = action;
        break;
      case Pages.Detail5:
        DetailPage5Config.currentPageAction = action;
        break;
      case Pages.Detail6:
        DetailPage6Config.currentPageAction = action;
        break;
      case Pages.CreateDeal:
        CreateDealConfig.currentPageAction = action;
        break;
      case Pages.CreateDeal_2:
        CreateDeal_2Config.currentPageAction = action;
        break;
      case Pages.CreateDealComplete:
        CreateDealConfig.currentPageAction = action;
        break;
      default:
        break;
    }
  }

  List<Page> buildPages() {
    if (!appModel.splashFinished) {
      replaceAll(SplashPageConfig);
    } else {
      switch (appModel.currentAction.state) {
        case PageState.none:
          break;
        case PageState.addPage:
          _setPageAction(appModel.currentAction);
          addPage(appModel.currentAction.page!);
          break;
        case PageState.pop:
          pop();
          break;
        case PageState.replace:
          _setPageAction(appModel.currentAction);
          replace(appModel.currentAction.page!);
          break;
        case PageState.replaceAll:
          _setPageAction(appModel.currentAction);
          replaceAll(appModel.currentAction.page!);
          break;
        case PageState.addWidget:
          _setPageAction(appModel.currentAction);
          pushWidget(
              appModel.currentAction.widget!, appModel.currentAction.page!);
          break;
        case PageState.addAll:
          addAll(appModel.currentAction.pages!);
          break;
      }
    }
    // appModel.resetCurrentAction();
    return List.of(_pages);
  }

// void parseRoute(Uri uri) {
//
//   if (uri.pathSegments.isEmpty) {
//     setNewRoutePath(SplashPageConfig);
//     return;
//   }
//
//   // Handle navapp://deeplinks/details/#
//   if (uri.pathSegments.length == 2) {
//
//   } else if (uri.pathSegments.length == 1) {
//     final path = uri.pathSegments[0];
//     switch (path) {
//       case 'splash':
//         replaceAll(SplashPageConfig);
//         break;
//       case 'login':
//         replaceAll(LoginPageConfig);
//         break;
//       case 'signIn':
//         setPath([
//           _createPage(LoginScreen(), LoginPageConfig),
//           // _createPage(SignInScreen(), SignInPageConfig)
//         ]);
//         break;
//       case 'welcome':
//         setPath([
//           _createPage(LoginScreen(), LoginPageConfig),
//           // _createPage(SignInScreen(), SignInPageConfig)
//         ]);
//         break;
//       case 'home':
//         replaceAll(HomePageConfig);
//         break;
//
//     }
//   }
// }
}
