import 'package:flutter/material.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/models/member.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/login/login_screen.dart';
import 'package:s_fam/views/signIn/signIn_success.dart';
import 'package:s_fam/widgets/app_bar.dart';
import 'package:s_fam/widgets/text_input.dart';

class CreatePassword extends StatefulWidget {
  final String name;
  final String dob;
  final String email;
  final String phoneNumber;
  final String gender;

  const CreatePassword({
    Key? key,
    required this.name,
    required this.dob,
    required this.email,
    required this.phoneNumber,
    required this.gender,
  }) : super(key: key);

  @override
  _CreatePasswordState createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _password = TextEditingController();
  TextEditingController _rePassword = TextEditingController();
  bool showPass = false;
  bool showRePass = false;
  late UserProvider _user;
  ButtonStatus stateOnlyText = ButtonStatus.idle;

  void onPressedCustomButton() async {
    if (stateOnlyText == ButtonStatus.idle) {
      setState(() {
        stateOnlyText = ButtonStatus.loading;
      });
      Future.delayed(Duration(seconds: 2), () async {
        if (_formKey.currentState!.validate()) {
          register();
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

  Future<void> register() async {
    var data = {
      "email": widget.email,
      "password":_password.text,
      "gender":widget.gender,
      "dob":widget.dob,
      "fullName":widget.name,
      "phoneNumber":widget.phoneNumber
    };
    _user.registration(
      infoUser: data,
      success: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInSuccess(),
          ),
        );
        setState(() {
          stateOnlyText = ButtonStatus.success;
        });
        setState(() {
          stateOnlyText = ButtonStatus.idle;
        });
      },
      fail: (e) {
        setState(() {
          stateOnlyText = ButtonStatus.fail;
        });
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            stateOnlyText = ButtonStatus.idle;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGenerated(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "Tạo mật khẩu",
                    style: kText20BlueBold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  width: 295,
                  child: Text(
                    "Vui lòng nhập mật khẩu và xác nhận mật khẩu của bạn ở đây:",
                    style: kSubText14Black,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextInput(
                  height: 48,
                  labelText: "Mật khẩu mới",
                  obscureText: !showPass,
                  validator: (value) {
                    return value!.isEmpty ? "Không được bỏ trống" : null;
                  },
                  controller: _password,
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
                  ),
                ),
                SizedBox(
                  height: 27,
                ),
                TextInput(
                  height: 48,
                  labelText: "Nhập lại mật khẩu",
                  obscureText: !showRePass,
                  validator: (value) {
                    return value!.isEmpty
                        ? "Không được bỏ trống"
                        : value != _password.text
                            ? "Không khớp mật khẩu"
                            : null;
                  },
                  controller: _rePassword,
                  suffixIcon: Container(
                    width: 20,
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          showRePass = !showRePass;
                        });
                      },
                      child: Icon(
                        showRePass
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: textSecondary,
                        size: 21,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ProgressButtonAnimation(
                    onPressed: onPressedCustomButton,
                    state: stateOnlyText,
                    height: 52,
                    maxWidth: MediaQuery.of(context).size.width,
                    stateWidgets: {
                      ButtonStatus.idle: Text(
                        "Tạo mật khẩu",
                        style: kText16WhiteBold,
                      ),
                      ButtonStatus.fail: Text(
                        "Xảy ra lỗi",
                        style: kText14White,
                      ),
                      ButtonStatus.success: Text(
                        "Tạo thành công",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
