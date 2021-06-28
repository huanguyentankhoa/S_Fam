import 'package:flutter/material.dart';
import 'app_router_delegate.dart';
import 'ui_pages.dart';

class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  final AppRouterDelegate routerDelegate;
  AppBackButtonDispatcher(this.routerDelegate)
      : super();

  @override
  Future<bool> didPopRoute() async {
    print("allo");
    if(routerDelegate.currentConfiguration.uiPage==Pages.MainPage) {
     // var result =  await showDialog(
     //    context: context!, builder: (_) {
     //      print("alo");
     //      return  AlertDialog(
     //        title: Text("hello"),
     //      );
     // },);
       return false;
      }
     return routerDelegate.popRoute();
  }
}
