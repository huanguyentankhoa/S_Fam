import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/routes/app_back_dispatcher.dart';
import 'package:youreal/routes/app_router_delegate.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/views/chat/chat_screen.dart';
import 'package:youreal/views/deal/deal_screen.dart';
import 'package:youreal/views/news/news_screen.dart';
import 'package:youreal/views/setting/setting_screen.dart';

import '../common/config/text_config.dart';
import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with AutomaticKeepAliveClientMixin {
  late PersistentTabController _controller;
  late AppModel _appModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _controller.addListener(() {
      setState(() {});
    });
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      DealScreen(),
      NewsScreen(),
      ChatScreen(),
      SettingScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: _controller.index == 0
            ? SvgPicture.asset(getIcon("home.svg"), color: yrColor14)
            : SvgPicture.asset(getIcon("home.svg"), color: yrColor3),
        title: "Trang chủ",
        iconSize: 20,
        contentPadding: 10,
        activeColorPrimary: yrColor14,
        activeColorSecondary: yrColor14,
        textStyle: _controller.index == 0 ? kText12_14 : kText12_3,
      ),
      PersistentBottomNavBarItem(
        icon: _controller.index == 1
            ? SvgPicture.asset(getIcon("bolt.svg"), color: yrColor14)
            : SvgPicture.asset(getIcon("bolt.svg"), color: yrColor3),
        title: "Deal",
        iconSize: 20,
        contentPadding: 10,
        activeColorPrimary: yrColor14,
        activeColorSecondary: yrColor14,
        textStyle: _controller.index == 1 ? kText12_14 : kText12_3,
      ),
      PersistentBottomNavBarItem(
        icon: _controller.index == 2
            ? SvgPicture.asset(getIcon("website.svg"), color: yrColor14)
            : SvgPicture.asset(getIcon("website.svg"), color: yrColor3),
        title: "Tin tức",
        iconSize: 20,
        contentPadding: 10,
        activeColorPrimary: yrColor14,
        activeColorSecondary: yrColor14,
        textStyle: _controller.index == 2 ? kText12_14 : kText12_3,
      ),
      PersistentBottomNavBarItem(
        icon: _controller.index == 3
            ? SvgPicture.asset(getIcon("chat.svg"), color: yrColor14)
            : SvgPicture.asset(getIcon("chat.svg"), color: yrColor3),
        title: "Chat",
        activeColorPrimary: yrColor14,
        iconSize: 20,
        contentPadding: 10,
        activeColorSecondary: yrColor14,
        textStyle: _controller.index == 3 ? kText12_14 : kText12_3,
      ),
      PersistentBottomNavBarItem(
        icon: _controller.index == 4
            ? SvgPicture.asset(getIcon("options.svg"), color: yrColor14)
            : SvgPicture.asset(getIcon("options.svg"), color: yrColor3),
        title: "Cài đặt",
        iconSize: 20,
        contentPadding: 10,
        activeColorPrimary: yrColor14,
        activeColorSecondary: yrColor14,
        textStyle: _controller.index == 4 ? kText12_14 : kText12_3,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _appModel = Provider.of<AppModel>(context);
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        onWillPop: (context)async{
          bool result = await showDialog(
              context: context!,
              builder: (_) => AlertDialog(
                content: Container(
                    height: 60,
                    color: yrColor4,
                    alignment: Alignment.center,
                    child: Text(
                      "Bạn chắc chắn muốn thoát?",
                      style: kText16Bold_1,
                    )),
                actions: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Text(
                          "THOÁT",
                          style: kText16Bold_5,
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
                          "HỦY",
                          style: kText16Bold_1,
                        ),
                      )
                    ],
                  )
                ],
              ));
          return result;
        },
        backgroundColor: yrColor1,
        hideNavigationBar: _appModel.hideNavBar,
        decoration: NavBarDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
