import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';
import 'package:s_fam/view_models/app_provider.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/map/follow_position.dart';
import 'package:s_fam/views/person/person_screen.dart';
import 'package:s_fam/views/welcome_screen.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int tabSelected = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Drawer(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Menu",
                  style: kText28BlackBold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PersonScreen()));
                },
                child: Container(
                  height: 42,
                  child: Row(
                    children: [
                      Container(
                        height: 41,
                        width: 41,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: primaryMain)),
                        child: ClipOval(
                          child: user.userCurrentLogin.avatarUrl != null &&
                                  user.userCurrentLogin.avatarUrl != ""
                              ? Tools().getImage(
                                  "https://testfam.herokuapp.com/api/v1/image/${user.userCurrentLogin.email}/avt/download")
                              : Image.asset(
                                  "assets/icons/logo.png",
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.userCurrentLogin.name!,
                            style: kText16BlackBold,
                          ),
                          Text(
                            "Xem trang cá nhân của bạn",
                            style: kSubText14Black,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  app.tabMainSelected = 0;
                },
                child: Container(
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color:
                          tabSelected == 0 ? Color(0xFFE9F4FE) : Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      tabSelected == 0
                          ? SvgPicture.asset(
                              "assets/icons/home.svg",
                              width: 22,
                              height: 22,
                              color: primaryMain,
                            )
                          : SvgPicture.asset(
                              "assets/icons/home.svg",
                              width: 22,
                              height: 22,
                              color: Colors.black,
                            ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Trang chủ",
                        style: tabSelected == 0 ? kText16Blue : kText16Black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  app.tabMainSelected = 1;
                },
                child: Container(
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color:
                          tabSelected == 1 ? Color(0xFFE9F4FE) : Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      tabSelected == 1
                          ? SvgPicture.asset(
                              "assets/icons/calendar.svg",
                              width: 22,
                              height: 22,
                              color: primaryMain,
                            )
                          : SvgPicture.asset(
                              "assets/icons/calendar.svg",
                              width: 22,
                              height: 22,
                              color: Colors.black,
                            ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Lịch",
                        style: tabSelected == 1 ? kText16Blue : kText16Black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  app.tabMainSelected = 3;
                },
                child: Container(
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color:
                          tabSelected == 2 ? Color(0xFFE9F4FE) : Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      tabSelected == 2
                          ? SvgPicture.asset(
                              "assets/icons/save.svg",
                              width: 22,
                              height: 22,
                              color: primaryMain,
                            )
                          : SvgPicture.asset(
                              "assets/icons/save.svg",
                              width: 22,
                              height: 22,
                              color: Colors.black,
                            ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Vật dụng",
                        style: tabSelected == 2 ? kText16Blue : kText16Black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  app.tabMainSelected = 4;
                },
                child: Container(
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color:
                          tabSelected == 3 ? Color(0xFFE9F4FE) : Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      tabSelected == 3
                          ? SvgPicture.asset(
                              "assets/icons/map.svg",
                              width: 22,
                              height: 22,
                              color: primaryMain,
                            )
                          : SvgPicture.asset(
                              "assets/icons/map.svg",
                              width: 22,
                              height: 22,
                              color: Colors.black,
                            ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Vị trí",
                        style: tabSelected == 3 ? kText16Blue : kText16Black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  app.tabMainSelected = 3;
                },
                child: Container(
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color:
                          tabSelected == 4 ? Color(0xFFE9F4FE) : Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      tabSelected == 4
                          ? SvgPicture.asset(
                              "assets/icons/note.svg",
                              width: 22,
                              height: 22,
                              color: primaryMain,
                            )
                          : SvgPicture.asset(
                              "assets/icons/note.svg",
                              width: 22,
                              height: 22,
                              color: Colors.black,
                            ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Ghi chú tài khoản",
                        style: tabSelected == 4 ? kText16Blue : kText16Black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  app.tabMainSelected = 3;
                },
                child: Container(
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color:
                          tabSelected == 5 ? Color(0xFFE9F4FE) : Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      tabSelected == 5
                          ? SvgPicture.asset(
                              "assets/icons/album.svg",
                              width: 22,
                              height: 22,
                              color: primaryMain,
                            )
                          : SvgPicture.asset(
                              "assets/icons/album.svg",
                              width: 22,
                              height: 22,
                              color: Colors.black,
                            ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Album ảnh",
                        style: tabSelected == 5 ? kText16Blue : kText16Black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  user.logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ),
                      (route) => false);
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFfB6B6BA),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Đăng xuất",
                        style: kText14BlackBold,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.login_outlined,
                        size: 25,
                        color: Colors.black87,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
