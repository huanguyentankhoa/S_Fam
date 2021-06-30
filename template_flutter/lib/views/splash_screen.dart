import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/view_models/app_provider.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/home/join_group/join_group.dart';
import 'package:s_fam/views/main_screen.dart';
import 'package:s_fam/views/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? animation;
  late UserProvider user;
  late BuildContext _context;
  startTime() async {
    var _duration = const Duration(seconds: 5);

    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    final prefs = await SharedPreferences.getInstance();
    var result = user.loggedIn;
    if (result == true) {
      try {
        var joinedGroup = prefs.getBool("joinedGroup");
        if (joinedGroup != null && joinedGroup) {
          var codeFamily = prefs.getString("codeFamily");
          if (codeFamily != null) {
            user.joinFamily(
              key: codeFamily,
              success: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
              fail: (statusCode) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
            );
          }
        } else {
          await showDialog(
            context: _context,
            builder: (context) => JoinGroup(
              onBack: (){
                user.loggedIn = false;
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
            ),
          );
        }
      } catch (e) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      }
    } else
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    animation = CurvedAnimation(parent: _controller!, curve: Curves.easeOut);
    animation!.addListener(() => setState(() {}));
    _controller!.forward();

    startTime();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  // bool _initialized = false;
  late AppProvider app;

  @override
  Widget build(BuildContext context) {
    app = Provider.of<AppProvider>(context);
    user = Provider.of<UserProvider>(context);
    _context = context;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: animation!.value * 83,
                  height: animation!.value * 170,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icons/logo.png",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: animation!.value * 56,
                  alignment: Alignment.center,
                  child: Text(
                    "S-Fam",
                    style: kText37BlueBold,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              height: 45,
              child: Column(
                children: [
                  Text(
                    "Copyright ⓒ 2021 by S-Fam",
                    style: kText14Black,
                  ),
                  Text(
                    "S-Fam Version 1.0.0",
                    style: kSubText14Black,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
