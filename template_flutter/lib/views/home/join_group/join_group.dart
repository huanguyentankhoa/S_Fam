import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/main_screen.dart';
import 'package:s_fam/widgets/text_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinGroup extends StatefulWidget {
  Function? onBack;

  JoinGroup({Key? key, this.onBack}) : super(key: key);

  @override
  _JoinGroupState createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  TextEditingController _codeFamily = TextEditingController();
  TextEditingController _codeFamilyJoined = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late UserProvider _user;

  ButtonStatus stateOnlyText = ButtonStatus.idle;

  String? nameGroupJoined;

  void onPressedCustomButton() async {
    if (stateOnlyText == ButtonStatus.idle) {
      setState(() {
        stateOnlyText = ButtonStatus.loading;
      });
      Future.delayed(Duration(seconds: 2), () async {
        if (_formKey.currentState!.validate()) {
          _user.joinFamily(
              key: _codeFamily.text,
              success: () {
                Navigator.push(
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
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInit();
  }

  loadInit() async {
    await Provider.of<UserProvider>(context, listen: false)
        .getDataMyGroup()
        .then((value) {
      setState(() {
        nameGroupJoined = value!.name;
        _codeFamilyJoined.text = value.key;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.only(left: 10, right: 10),
      titlePadding: EdgeInsets.zero,
      content: Form(
        key: _formKey,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                widget.onBack!();
              },
              child: Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Center(
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width - 20,
                color: Colors.white,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        "Vui lòng nhập code để tham gia",
                        style: kText18BlueBold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextInput(
                      height: 58,
                      labelText: "Mã tham gia",
                      validator: (value) {
                        return value!.isEmpty ? "Không được bỏ trống" : null;
                      },
                      controller: _codeFamily,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nhóm đã tham gia",
                        style: kText12blackBold,
                      ),
                    ),

                    if (nameGroupJoined != null)
                      TextInput(
                        height: 48,
                        labelText: nameGroupJoined!,
                        controller: _codeFamilyJoined,
                        enable: true,
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10, top: 10),
                            suffixIcon: Container(
                              width: 20,
                              padding: EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  FlutterClipboard.copy(_codeFamilyJoined.text).then((value) {
                                    const snackBar = SnackBar(
                                      content: Text("Đã sao chép mã gia đình"),
                                      duration: Duration(seconds: 3),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  });
                                },
                                child: Icon(
                                  Icons.copy,
                                  size: 21,
                                  color: Color(0xFF272729),
                                ),
                              ),
                            )),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(bottom: 22),
      actions: [
        Container(
          height: 52,
          width: MediaQuery.of(context).size.width - 20,
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
                "Tiếp tục",
                style: kText16WhiteBold,
              ),
              ButtonStatus.fail: Text(
                "Xảy ra lỗi",
                style: kText14White,
              ),
              ButtonStatus.success: Text(
                "Tiếp tục",
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
        )
      ],
    );
  }
}
