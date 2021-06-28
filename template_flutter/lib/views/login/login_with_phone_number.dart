import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:youreal/views/setup_group/setup_group.dart';

import '../../routes/ui_pages.dart';
import '../../view_models/app_model.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  _LoginWithPhoneNumberState createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool showPass = false;
  bool saveLogin = false;
  late AppModel appModel;
  ButtonStatus stateOnlyText = ButtonStatus.idle;

  void onPressedCustomButton() async {
    savedAccount();
    setState(() {
      stateOnlyText = ButtonStatus.loading;
    });
    if (_formKey.currentState!.validate()) {
      var result = await appModel.loginWithPhoneNumber(
          _phoneNumber.text, _password.text,
          saveLogin: saveLogin);
      if (result == true) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SetupGroup(),
            ),
          );
        });
      } else {
        setState(() {
          stateOnlyText = ButtonStatus.fail;
        });
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            stateOnlyText = ButtonStatus.idle;
          });
        });
      }
    } else {
      setState(() {
        stateOnlyText = ButtonStatus.fail;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          stateOnlyText = ButtonStatus.idle;
        });
      });
    }
  }

  @override
  void initState() {
    loadData();
  }

  loadData() async {
    super.initState();
    final prefs = await SharedPreferences.getInstance();
    try {
      setState(() {
        saveLogin = prefs.getBool(SavedAccountKey)!;
      });
      if (saveLogin) {
        final LocalStorage storage = LocalStorage(StorageName);
        final json = await storage.getItem(SavedAccountKey);

        setState(() {
          _phoneNumber.text = json["phoneNumber"];
          _password.text = json["password"];
        });
      }else{
        _phoneNumber.text = "";
        _password.text = "";
      }
    } catch (e) {
      print(e);
      saveLogin = false;
    }
  }
  savedAccount() async {
   if(saveLogin){
     final LocalStorage storage = LocalStorage(StorageName);
     await storage.setItem(SavedAccountKey, {
       "phoneNumber":_phoneNumber.text,
       "password":_password.text
     });
   }
  }
  @override
  Widget build(BuildContext context) {
    appModel = Provider.of<AppModel>(context);
    return Scaffold(
      backgroundColor: yrColor1,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: 215.h,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 50.h),
                  child: Text(
                    "YOUREAL",
                    style: kText48Bold_3,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(56.h),
                        topRight: Radius.circular(56.h),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 56.h, left: 12.w),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "ĐĂNG NHẬP",
                            style: kText28_1,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),

                        ///Số điện thoại
                        Container(
                          height: 75,
                          padding: EdgeInsets.symmetric(horizontal: 35.w),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 60),
                                child: Text(
                                  "Số Điện Thoại",
                                  style: kText18_8,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextFormField(
                                  controller: _phoneNumber,
                                  style: kText20_2,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Nhập số điện thoại';
                                    }
                                    // if (value.length != 10) {
                                    //   return "Số điện thoại không đúng";
                                    // }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15.h,
                        ),

                        ///Password
                        Container(
                          height: 75,
                          padding: EdgeInsets.symmetric(horizontal: 35.w),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 60),
                                child: Text(
                                  "Password",
                                  style: kText18_8,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextFormField(
                                  controller: _password,
                                  style: kText20_2,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  obscureText: !showPass,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Nhập mật khẩu';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          showPass = !showPass;
                                        });
                                      },
                                      child: Container(
                                        child: Icon(
                                          showPass
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 24.h,
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 35.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        saveLogin = !saveLogin;

                                      });
                                      final prefs = await SharedPreferences.getInstance();
                                      prefs.setBool(SavedAccountKey, saveLogin);
                                    },
                                    child: Container(
                                      height: 26.h,
                                      width: 26.h,
                                      margin: EdgeInsets.only(right: 7),
                                      color: Color(0xFFEFEFEF),
                                      alignment: Alignment.center,
                                      child: saveLogin
                                          ? Icon(
                                              Icons.check,
                                              color: yrColor1,
                                            )
                                          : Container(),
                                    ),
                                  ),
                                  Text(
                                    "Ghi nhớ đăng nhập",
                                    style: kText18_1,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Quên mật khẩu",
                                  style: kText18_1,
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 30.h,
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40.w),
                          child: ProgressButtonAnimation(
                            onPressed: onPressedCustomButton,
                            state: stateOnlyText,
                            height: 58.h,
                            maxWidth: MediaQuery.of(context).size.width,
                            stateWidgets: {
                              ButtonStatus.idle: Text(
                                "ĐĂNG NHẬP",
                                style: kText18_3,
                              ),
                              ButtonStatus.fail: Text(
                                "Đăng nhập không thành công",
                                style: kText18_3,
                              ),
                              ButtonStatus.success: Text(
                                "Đăng nhập thành công",
                                style: kText18_3,
                              ),
                            },
                            stateColors: {
                              ButtonStatus.idle: yrColor1,
                              ButtonStatus.loading: yrColor14,
                              ButtonStatus.fail: yrColor5,
                              ButtonStatus.success: yrColor16,
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
