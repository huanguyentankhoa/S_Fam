import 'package:flutter/material.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/views/login/login_screen.dart';

class SignInSuccess extends StatelessWidget {
  const SignInSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Container(
              height: 287,
              child: Image.asset(
                "assets/images/signin_success.png",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                "Tạo tài khoản thành công",
                style: kText20BlueBold,
              ),
            ),
            SizedBox(
              height: 12,
            ),

            Expanded(
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (route) => false);
                  },
                  child: Container(
                    height: 52,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryMain,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      "Đăng Nhập",
                      style: kText16WhiteBold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
