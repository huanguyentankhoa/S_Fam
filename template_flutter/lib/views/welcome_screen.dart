import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/view_models/app_provider.dart';
import 'package:s_fam/views/login/login_screen.dart';
import 'package:s_fam/views/signIn/signIn_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              height: 280,
              color: Colors.grey,
              child: Image.asset(
                "assets/images/welcome.png",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 42,
            ),
            Container(
              child: Text(
                "Chào mừng đến với S-Fam",
                style: kText20Blue,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.only(left: 25, right: 22),
              child: Text(
                "Nơi giúp bạn kết nối các thành viên trong gia đình và nhiều hơn thế nữa!",
                textAlign: TextAlign.center,
                style: kSubText16Black,
              ),
            ),
            SizedBox(
              height: 90,
            ),
            InkWell(
              onTap: () {

                Navigator.push(context, MaterialPageRoute(
                    settings: RouteSettings(name: '/login'),
                    builder: (context)=>LoginScreen()));
              },
              child: Container(
                height: 52,
                margin: EdgeInsets.only(left: 20, right: 20),
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
            SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {

                Navigator.push(context, MaterialPageRoute(
                    settings: RouteSettings(name: '/signIn'),
                    builder: (context)=>SignInScreen()));
              },
              child: Container(
                height: 52,
                margin: EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: primaryMain),
                ),
                child: Text(
                  "Đăng Ký",
                  style: kText16BlueBold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
