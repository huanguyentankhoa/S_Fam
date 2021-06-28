import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/views/login/login_screen.dart';
import 'package:youreal/views/menu/menu.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _key = GlobalKey<ScaffoldState>();

  Widget imageContainer(String link) {
    if (link.contains('http://') || link.contains('https://')) {
      return Image.network(
        link,
        fit: BoxFit.fill,
      );
    }
    return Image.asset(
      "assets/$link",
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    return Scaffold(
      key: _key,
      backgroundColor: yrColor1,
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: yrColor1,
        leading: Container(),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Setting",
          style: kText18Bold_3,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 120.h,
                margin: EdgeInsets.only(top: 16.h),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 65.h,
                          width: 65.h,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: ClipOval(
                              child: getImage("avatar.png")),
                        ),
                        Container(
                          height: 15.h,
                          width: 15.h,
                          margin: EdgeInsets.only(top: 2, right: 2),
                          decoration: BoxDecoration(
                              color: yrColor16, shape: BoxShape.circle),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Nguyễn Thị B",
                      style: kText18_3,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                    color: yrColor4,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(56.h),
                      topLeft: Radius.circular(56.h),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 83.h,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 46.h,
                        decoration: BoxDecoration(
                            color: yrColor1,
                            borderRadius: BorderRadius.circular(30.h)),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Text(
                          "Thay đổi thông tin cá nhân",
                          style: kText16_3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46.h,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 56.h,
                        decoration: BoxDecoration(
                            color: yrColor1,
                            borderRadius: BorderRadius.circular(30.h)),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Text(
                          "Cài đặt thông báo",
                          style: kText16_3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46.h,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 56.h,
                        decoration: BoxDecoration(
                            color: yrColor1,
                            borderRadius: BorderRadius.circular(30.h)),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Text(
                          "Liên hệ",
                          style: kText16_3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46.h,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 56.h,
                        decoration: BoxDecoration(
                            color: yrColor1,
                            borderRadius: BorderRadius.circular(30.h)),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Text(
                          "Chính sách và điều khoản",
                          style: kText16_3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46.h,
                    ),
                    InkWell(
                      onTap: () {
                        appModel.hideNavBar = true;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      },
                      child: Container(
                        height: 56.h,
                        decoration: BoxDecoration(
                            color: yrColor1,
                            borderRadius: BorderRadius.circular(30.h)),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Text(
                          "Đăng xuất",
                          style: kText16_3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
