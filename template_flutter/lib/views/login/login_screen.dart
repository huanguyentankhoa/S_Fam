import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/views/login/login_with_phone_number.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _key = GlobalKey<ScaffoldState>();
  late AppModel appModel;

  // _loginSuccess(BuildContext context) {
  //   appModel.currentAction = PageAction(
  //     state: PageState.addPage,
  //     page: SetupGroupConfig,
  //   );
  // }

  // void _loginFail(context) {
  //   const snackBar = SnackBar(
  //     content: Text("Đăng nhập không thành công"),
  //     duration: Duration(seconds: 3),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  @override
  Widget build(BuildContext context) {
    appModel = Provider.of<AppModel>(context);
    return Scaffold(
      key: _key,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: getImage(
                "background_login.png",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 21.h),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        //appModel.currentAction = PageAction(state: PageState.addPage, page: LoginPage1Config);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginWithPhoneNumber(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: yrColor12,
                            borderRadius: BorderRadius.circular(80.h)),
                        child: Text(
                          "ĐĂNG NHẬP VỚI SỐ ĐIỆN THOẠI",
                          style: kText18_3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              height: 1,
                              color: yrColor3,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11.h),
                            child: Text(
                              "or",
                              style: kText18_3,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              height: 1,
                              color: yrColor3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: yrColor5,
                          borderRadius: BorderRadius.circular(80.h)),
                      child: Row(
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.h,
                            decoration: BoxDecoration(
                              color: yrColor3,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(80.h),
                                bottomLeft: Radius.circular(80.h),
                              ),
                            ),
                            child: Container(
                              height: 35.h,
                              width: 35.h,
                              alignment: Alignment.center,
                              child: Image.asset(
                                getIcon("google_logo.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "GOOGLE",
                                style: kText18_3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: yrColor10,
                          borderRadius: BorderRadius.circular(80.h)),
                      child: Row(
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.h,
                            decoration: BoxDecoration(
                              color: yrColor3,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(80.h),
                                bottomLeft: Radius.circular(80.h),
                              ),
                            ),
                            child: Container(
                              height: 35.h,
                              width: 35.h,
                              alignment: Alignment.center,
                              child: Image.asset(
                                getIcon("fb_logo.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "FACEBOOK",
                                style: kText18_3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: yrColor2,
                          borderRadius: BorderRadius.circular(80.h)),
                      child: Row(
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.h,
                            decoration: BoxDecoration(
                              color: yrColor3,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(80.h),
                                bottomLeft: Radius.circular(80.h),
                              ),
                            ),
                            child: Container(
                              height: 35.h,
                              width: 35.h,
                              alignment: Alignment.center,
                              child: Image.asset(
                                getIcon("apple_logo.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "APPLE",
                                style: kText18_3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
