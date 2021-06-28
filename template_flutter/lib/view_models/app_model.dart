import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youreal/common/constants/general.dart';
import 'package:youreal/model/user.dart';
import 'package:youreal/routes/ui_pages.dart';
import 'package:youreal/services/services_api.dart';

const String SavedAccountKey = 'SavedAccount';
const String UserSavedKey = "UserSaved";
const String StorageName = 'YOUREAL';
enum PageState { none, addPage, addAll, addWidget, pop, replace, replaceAll }

class PageAction {
  PageState state;
  PageConfiguration? page;
  List<PageConfiguration>? pages;
  Widget? widget;

  PageAction({this.state = PageState.none, this.page, this.pages, this.widget});
}

class AppModel with ChangeNotifier {
  String locale = kAdvanceConfig['DefaultLanguage'].toString();
  bool darkTheme = false;
  bool isInit = false;
  bool _hideNavBar = false;
  APIServices _services = APIServices();

  late User _user;
  bool loggedIn = false;

  bool _splashFinished = false;

  bool get splashFinished => _splashFinished;
  PageAction _currentAction = PageAction();

  PageAction get currentAction => _currentAction;

  set currentAction(PageAction action) {
    _currentAction = action;
    notifyListeners();
  }

  User get user => _user;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  bool get hideNavBar => _hideNavBar;

  set hideNavBar(bool value) {
    _hideNavBar = value;
    notifyListeners();
  }

  Map<String, dynamic> appConfig = {};

  AppModel() {
    getConfig();
    getLoggedInState();
  }

  Future<bool> getConfig() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      locale = prefs.getString("language") ??
          kAdvanceConfig['DefaultLanguage'].toString();
      darkTheme = prefs.getBool("darkTheme") ?? false;
      isInit = true;
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> changeLanguage(String country, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      locale = country;
      await prefs.setString("language", country);

      notifyListeners();
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<void> updateTheme(bool theme) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      darkTheme = theme;
      await prefs.setBool("darkTheme", theme);
      notifyListeners();
    } catch (error) {
      printLog('[_getFacebookLink] error: ${error.toString()}');
    }
  }

  Future<bool> loginWithPhoneNumber(String phoneNumber, String password,
      {bool? saveLogin}) async {
    try {
      var u = await _services.loginWithPhoneNumber(
          phoneNumber.replaceFirst("0", "+84"), password);
      if (u != null) {
        _user = u;
        loggedIn = true;
        if (saveLogin!) {
          saveLoginState();
        }
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> sendCriteria(
      {required position,
      required soilType,
      required investmentLimit,
      Function? success,
      Function? fail}) async {
    try {
      bool result = await _services.sendCriteria(
          position: position,
          soilType: soilType,
          investmentLimit: investmentLimit);

      if (result)
        success!();
      else
        fail!();
    } catch (e) {
      fail!();
    }
  }

  void logout() {
    loggedIn = false;
    notifyListeners();
  }

  void saveLoginState() async {
    final LocalStorage storage = LocalStorage(StorageName);
    try {
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem(UserSavedKey, user);
      }
    } catch (e) {
      print(e);
    }
  }

  void getLoggedInState() async {
    final prefs = await SharedPreferences.getInstance();
    final LocalStorage storage = LocalStorage(StorageName);
    try {
      final ready = await storage.ready;
      loggedIn = prefs.getBool(UserSavedKey)!;
      if (ready) {
        final json = await storage.getItem(UserSavedKey);
        _user = User.formLocalJason(json);
        final userInfo = await _services.getUserInfo(token: _user.token);
        if (userInfo != null) {
          loggedIn = true;
          notifyListeners();
        } else {
          loggedIn = false;
          notifyListeners();
        }
      } else {
        loggedIn = false;
        notifyListeners();
      }
    } catch (e) {
      loggedIn = false;
      notifyListeners();
    }
  }
}
