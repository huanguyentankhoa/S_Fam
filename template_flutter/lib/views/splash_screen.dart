import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/views/login/login_screen.dart';
import 'package:youreal/views/setup_group/setup_group.dart';

import 'home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? animation;

  startTime() async {
    var _duration = const Duration(seconds: 3);

    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    bool result = Provider.of<AppModel>(context,listen: false).loggedIn;
    if(result){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SetupGroup()));
    }else{
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }

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

  @override
  Widget build(BuildContext context) {
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
                  height: animation!.value * 250,
                  alignment: Alignment.center,
                  child: Text(
                    "YOUREAL",
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: yrColor2,
                        fontFamily: fontFamily),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
