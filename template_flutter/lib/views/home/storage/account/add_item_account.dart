import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/widgets/text_input.dart';

class AddItemAccount extends StatefulWidget {
  const AddItemAccount({Key? key}) : super(key: key);

  @override
  _AddItemAccountState createState() => _AddItemAccountState();
}

class _AddItemAccountState extends State<AddItemAccount> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameItem = TextEditingController();
  TextEditingController note = TextEditingController();
  ButtonStatus stateOnlyText = ButtonStatus.idle;
  late UserProvider user;
  void onPressedCustomButton() async {
    Map<String, dynamic> data = {
      "name": nameItem.text,
      "detail": note.text,
    };
    if (stateOnlyText == ButtonStatus.idle) {
      setState(() {
        stateOnlyText = ButtonStatus.loading;
      });
      Future.delayed(Duration(seconds: 2), () async {
        if (_formKey.currentState!.validate()) {
          user.createListStorageAccount(
              data: data,
              email: user.userCurrentLogin.email,
              success: () {
                setState(() {
                  stateOnlyText = ButtonStatus.success;
                });
                Future.delayed(Duration(seconds: 2), () {
                  if(mounted)
                    setState(() {
                      stateOnlyText = ButtonStatus.idle;
                    });
                });
                Navigator.pop(context);
              },
              fail: () {
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
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                _appBarBuild(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(
                    height: 48,
                    labelText: "Tiêu đề",

                    validator: (value) {
                      return value!.isEmpty ? "Không được bỏ trống" : null;
                    },
                    controller: nameItem,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(
                    height: 223,
                    labelText: "Mô tả",
                    maxLine: 20,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      return value!.isEmpty ? "Không được bỏ trống" : null;
                    },
                    controller: note,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 20,left: 10,right: 10)
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 52,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      alignment: Alignment.center,
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
                            "Tạo ghi chú thành công",
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
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBarBuild() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 90,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/back.svg",
                  color: Colors.black,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Thêm ghi chú tài khoản mới",
                  style: kText20BlackBold,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
