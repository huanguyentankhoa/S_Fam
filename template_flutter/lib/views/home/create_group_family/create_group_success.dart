import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/view_models/user_provider.dart';

import '../../main_screen.dart';

class CreateGroupSuccess extends StatefulWidget {
  final codeFamily;

  const CreateGroupSuccess({Key? key, this.codeFamily}) : super(key: key);

  @override
  _CreateGroupSuccessState createState() => _CreateGroupSuccessState();
}

class _CreateGroupSuccessState extends State<CreateGroupSuccess> {
  ButtonStatus stateOnlyText = ButtonStatus.idle;
  late UserProvider _user;

  void onPressedCustomButton() async {
    try {
      if (stateOnlyText == ButtonStatus.idle) {
        setState(() {
          stateOnlyText = ButtonStatus.loading;
        });
        Future.delayed(Duration(seconds: 2), () async {
          _user.joinFamily(
              key: widget.codeFamily,
              success: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    settings: RouteSettings(name: "/main"),
                    builder: (context) => MainScreen(),
                  ),
                );
                setState(() {
                  stateOnlyText = ButtonStatus.success;
                });
                setState(() {
                  stateOnlyText = ButtonStatus.idle;
                });
              },
              fail: (statusCode) {
                setState(() {
                  stateOnlyText = ButtonStatus.fail;
                });
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    stateOnlyText = ButtonStatus.idle;
                  });
                });
              });
        });
      }
    } catch (e) {
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
  Widget build(BuildContext context) {
    _user = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
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
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Mã gia đình của bạn là",
                  style: kText20BlueBold,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Vui lòng copy và gửi cho thành viên để tham gia vào gia đình của bạn",
                  textAlign: TextAlign.center,
                  style: kSubText16Black,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                height: 58,
                margin: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFE8EAED),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          widget.codeFamily,
                          style: kText16Black,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FlutterClipboard.copy(widget.codeFamily).then((value) {
                          const snackBar = SnackBar(
                            content: Text("Đã sao chép mã gia đình"),
                            duration: Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        margin: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.copy,
                          color: Color(0xFF272729),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                    child: Container(
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
                            "Hoàn tất",
                            style: kText16WhiteBold,
                          ),
                          ButtonStatus.fail: Text(
                            "Xảy ra lỗi",
                            style: kText14White,
                          ),
                          ButtonStatus.success: Text(
                            "Hoàn tất",
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
