import 'package:youreal/view_models/app_model.dart';

const String SplashPath = '/splash';
const String LoginPath = '/login';
const String Login1Path = '/login1';
const String Login2Path = '/login2';
const String Login3Path = '/login3';
const String Login4Path = '/login4';
const String SignInPath = '/signIn';
const String HomePath = '/home';
const String MainPagePath = '/mainPage';
const String SetupGroupPath = '/setupGroup';
const String DetailPath = '/detail';
const String Detail1Path = '/detail1';
const String Detail2Path = '/detail2';
const String Detail3Path = '/detail3';
const String Detail4Path = '/detail4';
const String Detail5Path = '/detail5';
const String Detail6Path = '/detail6';
const String CreateDealPath = '/createDeal';
const String CreateDeal_2Path = '/CreateDeal_2';
const String CreateDealCompletePath = '/createDealComplete';
enum Pages {
  Splash,
  Login,
  Login1,
  Login2,
  Login3,
  Login4,
  SignIn,
  Home,
  MainPage,
  SetupGroup,
  Detail,
  Detail1,
  Detail2,
  Detail3,
  Detail4,
  Detail5,
  Detail6,
  CreateDeal,
  CreateDeal_2,
  CreateDealComplete
}

class PageConfiguration {
  final String key;
  final String path;
  final Pages uiPage;
  PageAction? currentPageAction;

  PageConfiguration(
      {required this.key,
      required this.path,
      required this.uiPage,
      this.currentPageAction});
}

PageConfiguration SplashPageConfig = PageConfiguration(
    key: 'Splash',
    path: SplashPath,
    uiPage: Pages.Splash,
    currentPageAction: null);
PageConfiguration LoginPageConfig = PageConfiguration(
    key: 'Login',
    path: LoginPath,
    uiPage: Pages.Login,
    currentPageAction: null);
PageConfiguration LoginPage1Config = PageConfiguration(
    key: 'Login1',
    path: Login1Path,
    uiPage: Pages.Login1,
    currentPageAction: null);
PageConfiguration LoginPage2Config = PageConfiguration(
    key: 'Login2',
    path: Login2Path,
    uiPage: Pages.Login2,
    currentPageAction: null);
PageConfiguration LoginPage3Config = PageConfiguration(
    key: 'Login3',
    path: Login3Path,
    uiPage: Pages.Login3,
    currentPageAction: null);
PageConfiguration LoginPage4Config = PageConfiguration(
    key: 'Login4',
    path: Login4Path,
    uiPage: Pages.Login4,
    currentPageAction: null);
PageConfiguration SignInPageConfig = PageConfiguration(
    key: 'SignIn',
    path: SignInPath,
    uiPage: Pages.SignIn,
    currentPageAction: null);
PageConfiguration HomePageConfig = PageConfiguration(
  key: 'Home',
  path: HomePath,
  uiPage: Pages.Home,
);

PageConfiguration MainPageConfig = PageConfiguration(
    key: 'MainPage',
    path: MainPagePath,
    uiPage: Pages.MainPage,
    currentPageAction: null);
PageConfiguration SetupGroupConfig = PageConfiguration(
    key: 'SetupGroup',
    path: SetupGroupPath,
    uiPage: Pages.SetupGroup,
    currentPageAction: null);
PageConfiguration DetailPageConfig = PageConfiguration(
    key: 'DetailPage',
    path: DetailPath,
    uiPage: Pages.Detail,
    currentPageAction: null);
PageConfiguration DetailPage1Config = PageConfiguration(
    key: 'DetailPage1',
    path: Detail1Path,
    uiPage: Pages.Detail1,
    currentPageAction: null);
PageConfiguration DetailPage2Config = PageConfiguration(
    key: 'DetailPage2',
    path: Detail2Path,
    uiPage: Pages.Detail2,
    currentPageAction: null);
PageConfiguration DetailPage3Config = PageConfiguration(
    key: 'DetailPage3',
    path: Detail3Path,
    uiPage: Pages.Detail4,
    currentPageAction: null);
PageConfiguration DetailPage4Config = PageConfiguration(
    key: 'DetailPage4',
    path: Detail4Path,
    uiPage: Pages.Detail4,
    currentPageAction: null);
PageConfiguration DetailPage5Config = PageConfiguration(
    key: 'DetailPage5',
    path: Detail5Path,
    uiPage: Pages.Detail5,
    currentPageAction: null);
PageConfiguration DetailPage6Config = PageConfiguration(
    key: 'DetailPage6',
    path: Detail6Path,
    uiPage: Pages.Detail6,
    currentPageAction: null);
PageConfiguration CreateDealConfig = PageConfiguration(
    key: 'CreateDeal',
    path: CreateDealPath,
    uiPage: Pages.CreateDeal,
    currentPageAction: null);
PageConfiguration CreateDeal_2Config = PageConfiguration(
    key: 'CreateDeal_2',
    path: CreateDeal_2Path,
    uiPage: Pages.CreateDeal_2,
    currentPageAction: null);
PageConfiguration DealCompleteConfig = PageConfiguration(
    key: 'CreateDealComplete',
    path: CreateDealCompletePath,
    uiPage: Pages.CreateDealComplete,
    currentPageAction: null);