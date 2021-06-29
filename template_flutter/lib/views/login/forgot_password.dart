import 'package:flutter/material.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/views/login/verify_email.dart';
import 'package:s_fam/widgets/app_bar.dart';
import 'package:s_fam/widgets/text_input.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGenerated(),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Text(
                "Quên mật khẩu",
                style: kText20BlueBold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              width: 295,
              child: Text(
                "Vui lòng nhập email cá nhân của bạn ở đây:",
                style: kSubText14Black,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextInput(
              height: 48,
              labelText: "Email",
              validator: (value) {
                return value!.isEmpty ? "Không được bỏ trống" : null;
              },
              controller: _email,
            ),

            SizedBox(
              height: 32,
            ),

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerifyEmail(screenNext: "changePass",),
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
                  "Đăng Ký",
                  style: kText16WhiteBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
