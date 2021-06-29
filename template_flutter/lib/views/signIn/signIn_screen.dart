import 'package:flutter/material.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/services/services_api.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/login/verify_email.dart';
import 'package:s_fam/widgets/app_bar.dart';
import 'package:s_fam/widgets/text_input.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late UserProvider _user;
  ButtonStatus stateOnlyText = ButtonStatus.idle;

  void onPressedCustomButton() async {
    if (stateOnlyText == ButtonStatus.idle) {
      setState(() {
        stateOnlyText = ButtonStatus.loading;
      });
      Future.delayed(Duration(seconds: 2), () async {
        if (_formKey.currentState!.validate()) {
           await _user.checkEmail(_email.text,success: (code){
             setState(() {
               stateOnlyText = ButtonStatus.success;
             });
             setState(() {
               stateOnlyText = ButtonStatus.idle;
             });
             Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) => VerifyEmail(
                       email: _email.text,
                       code: code,
                       screenNext: "continueSignIn",
                     )));
           },
             fail: (){
               setState(() {
                 stateOnlyText = ButtonStatus.fail;
               });
               Future.delayed(Duration(seconds: 2), () {
                 setState(() {
                   stateOnlyText = ButtonStatus.idle;
                 });
               });
             }
           );

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
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  "Đăng ký",
                  style: kText20BlueBold,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextInput(
                height: 48,
                labelText: "Email",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Không được để trống";
                  }
                  if (!value.contains('@')) {
                    return "Email không hợp lệ";
                  }
                  return null;
                },
                controller: _email,
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                alignment: Alignment.center,
                child: ProgressButtonAnimation(
                  onPressed: onPressedCustomButton,
                  state: stateOnlyText,
                  height: 52,
                  maxWidth: MediaQuery.of(context).size.width,
                  stateWidgets: {
                    ButtonStatus.idle: Text(
                      "ĐĂNG KÝ",
                      style: kText16WhiteBold,
                    ),
                    ButtonStatus.fail: Text(
                      "Đăng ký không thành công",
                      style: kText14White,
                    ),
                    ButtonStatus.success: Text(
                      "Đăng ký thành công",
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
    );
  }
}
