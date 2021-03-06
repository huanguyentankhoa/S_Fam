import 'dart:async';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/view_models/app_provider.dart';
import 'package:s_fam/view_models/notification/firebase_notification_handler.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/home/calendar/calendar_screen.dart';
import 'package:s_fam/views/home/home_screen.dart';
import 'package:s_fam/views/home/storage/storage_screen.dart';
import 'package:s_fam/views/map/follow_position.dart';
import 'package:s_fam/views/welcome_screen.dart';

import 'welcome_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Timer _timer;
  FirebaseNotification firebaseNotification = FirebaseNotification();

  late AppProvider app;
  late UserProvider user;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CalendarScreen(),
    StorageScreen(),
    FollowPosition()
  ];
  void _onItemTap(int index) {
    setState(() {
      app.tabMainSelected = index;
    });
  }

  @override
  void initState() {
    super.initState();
    int a = Provider.of<AppProvider>(context,listen: false).tabMainSelected;
    print("run here $a");
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      firebaseNotification.setupFirebase(
          context,
          Provider.of<UserProvider>(context, listen: false)
              .userCurrentLogin
              .email!);
    });

  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    app = Provider.of<AppProvider>(context);
    user = Provider.of<UserProvider>(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          bool result = await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    content: Container(
                        height: 60,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text(
                          "B???n ??ang mu???n ????ng xu???t?",
                          style: kText16Black,
                        )),
                    actions: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WelcomeScreen()),
                                  (route) => false);
                            },
                            child: Text(
                              "????NG XU???T",
                              style: kText16BlueBold,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context, false);
                            },
                            child: Text(
                              "H???Y",
                              style: kText16BlackBold,
                            ),
                          )
                        ],
                      )
                    ],
                  ));
          return result;
        },
        child: Center(
          child: _widgetOptions.elementAt(app.tabMainSelected),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        items: [
          CustomNavigationBarItem(
            icon: app.tabMainSelected == 0
                ? SvgPicture.asset(
                    "assets/icons/home.svg",
                    color: primaryMain,
                  )
                : SvgPicture.asset(
                    "assets/icons/home.svg",
                    color: textSecondary,
                  ),
            title: Text(
              "Trang ch???",
              style: app.tabMainSelected == 0 ? kText10Blue : kSubText10Black,
            ),
          ),
          CustomNavigationBarItem(
            icon: app.tabMainSelected == 1
                ? SvgPicture.asset(
                    "assets/icons/calendar.svg",
                    color: primaryMain,
                  )
                : SvgPicture.asset(
                    "assets/icons/calendar.svg",
                    color: textSecondary,
                  ),
            title: Text(
              "L???ch",
              style: app.tabMainSelected == 1 ? kText10Blue : kSubText10Black,
            ),
          ),
          CustomNavigationBarItem(
            icon: app.tabMainSelected == 2
                ? SvgPicture.asset(
                    "assets/icons/save.svg",
                    color: primaryMain,
                  )
                : SvgPicture.asset(
                    "assets/icons/save.svg",
                    color: textSecondary,
                  ),
            title: Text(
              "L??u tr???",
              style: app.tabMainSelected == 2 ? kText10Blue : kSubText10Black,
            ),
          ),
          CustomNavigationBarItem(
            icon: app.tabMainSelected == 3
                ? SvgPicture.asset(
                    "assets/icons/map.svg",
                    color: primaryMain,
                  )
                : SvgPicture.asset(
                    "assets/icons/map.svg",
                    color: textSecondary,
                  ),
            title: Text(
              "V??? tr??",
              style: app.tabMainSelected == 3 ? kText10Blue : kSubText10Black,
            ),
          ),
        ],
        strokeColor: primaryMain,
        currentIndex: app.tabMainSelected,
        onTap: _onItemTap,
      ),
    );
  }

}
