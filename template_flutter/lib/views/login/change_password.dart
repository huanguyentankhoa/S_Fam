import 'package:flutter/material.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/views/login/login_screen.dart';
import 'package:s_fam/widgets/app_bar.dart';
import 'package:s_fam/widgets/text_input.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _password = TextEditingController();
  TextEditingController _rePassword = TextEditingController();
  bool showPass = false;
  bool showRePass = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGenerated(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  "Thiết lập lại mật khẩu",
                  style: kText20BlueBold,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                width: 295,
                child: Text(
                  "Vui lòng nhập mật khẩu mới và xác nhận mật khẩu của bạn ở đây:",
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
                  return value!.isEmpty ? "Không được bỏ trống" : null;
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
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryMain,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Đổi mật khẩu",
                    style: kText16WhiteBold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
