import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/general.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/models/group.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/login/forgot_password.dart';
import 'package:s_fam/views/login/login_success.dart';
import 'package:s_fam/views/signIn/signIn_screen.dart';
import 'package:s_fam/widgets/app_bar.dart';
import 'package:s_fam/widgets/text_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _password = TextEditingController();
  TextEditingController _account = TextEditingController();
  bool showPass = false;
  ButtonStatus stateOnlyText = ButtonStatus.idle;
  late UserProvider _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAccountSaved();
  }

  loadAccountSaved() async {
    final prefs = await SharedPreferences.getInstance();
    var dataUser = convert.jsonDecode(prefs.getString("account")!);
    if (dataUser != null) {
      setState(() {
        _account.text = dataUser["email"];
        _password.text = dataUser["password"];
      });
    }
  }

  void onPressedCustomButton() async {
    if (stateOnlyText == ButtonStatus.idle) {
      setState(() {
        stateOnlyText = ButtonStatus.loading;
      });
      Future.delayed(Duration(seconds: 2), () async {
        if (_formKey.currentState!.validate()) {
          _user.login(
              email: _account.text,
              password: _password.text,
              success: () async {
                Group? group = await _user.getDataMyGroup(email: _account.text);
                if (group != null && group.key.isNotEmpty) {
                  _user.joinFamily(
                    key: group.key,
                    success: () {
                    },
                    fail: (statusCode) {
                    },
                  );
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          settings: RouteSettings(name: "/main"),
                          builder: (context) => MainScreen()));
                  setState(() {
                    stateOnlyText = ButtonStatus.success;
                  });
                  setState(() {
                    stateOnlyText = ButtonStatus.idle;
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginSuccess(),
                    ),
                  );
                }
              },
              fail: (error) {
                setState(() {
                  stateOnlyText = ButtonStatus.fail;
                });
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    stateOnlyText = ButtonStatus.idle;
                  });
                });
                print("Đăng nhập không thành công");
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGenerated(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "Đăng nhập",
                    style: kText20BlueBold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextInput(
                  height: 48,
                  labelText: "Email/Username",
                  validator: (value) {
                    return value!.isEmpty ? "Không được bỏ trống" : null;
                  },
                  controller: _account,
                ),
                SizedBox(
                  height: 27,
                ),
                TextInput(
                  height: 48,
                  labelText: "Mật khẩu",
                  obscureText: !showPass,
                  validator: (value) {
                    return value!.isEmpty ? "Không được bỏ trống" : null;
                  },
                  controller: _password,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10, top: 10),
                      suffixIcon: Container(
                        width: 20,
                        padding: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                          child: Icon(
                            showPass
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: textSecondary,
                            size: 21,
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  height: 48,
                  alignment: Alignment.center,
                  child: ProgressButtonAnimation(
                    onPressed: onPressedCustomButton,
                    state: stateOnlyText,
                    height: 52,
                    maxWidth: MediaQuery.of(context).size.width,
                    stateWidgets: {
                      ButtonStatus.idle: Text(
                        "ĐĂNG NHẬP",
                        style: kText16WhiteBold,
                      ),
                      ButtonStatus.fail: Text(
                        "Đăng nhập không thành công",
                        style: kText14White,
                      ),
                      ButtonStatus.success: Text(
                        "Đăng nhập thành công",
                        style: kText14White,
                      ),
                    },
                    stateColors: {
                      ButtonStatus.idle: primaryMain,
                      ButtonStatus.loading: primaryMain,
                      ButtonStatus.fail: Colors.red,
                      ButtonStatus.success: Colors.green,
                    },
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPassword(),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Quên mật khẩu?",
                      style: kText16Blue,
                    ),
                  ),
                ),
                Expanded(
                    child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 24),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Chưa có tài khoản?",
                        style: kText16BlueUnderLine,
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
