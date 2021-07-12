import 'package:flutter/material.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/widgets/text_input.dart';

class CreatePinCode extends StatefulWidget {
  final Function(String)? success;

  const CreatePinCode({Key? key, this.success}) : super(key: key);

  @override
  _CreatePinCodeState createState() => _CreatePinCodeState();
}

class _CreatePinCodeState extends State<CreatePinCode> {
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
          var result = await _user.createPinCode(pinCode: _password.text);
          if (result) {
            widget.success!(_password.text);
            setState(() {
              stateOnlyText = ButtonStatus.idle;
            });
            Navigator.pop(context);
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
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.only(left: 10, right: 10),
      titlePadding: EdgeInsets.zero,
      content: Container(
        height: 400,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Form(
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
                      "Tạo mã pin",
                      style: kText20BlueBold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    width: 295,
                    child: Text(
                      "Vui lòng nhập mã pin và xác nhận mã của bạn ở đây:",
                      style: kSubText14Black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextInput(
                    height: 48,
                    labelText: "Mã pin mới",
                    obscureText: !showPass,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Không được bỏ trống";
                      }
                      if( value.length!=6){
                        return "Mã pin phải có 6 ký tự";
                      }
                      return null;
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  TextInput(
                    height: 48,
                    labelText: "Nhập lại mã pin",
                    obscureText: !showRePass,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Không được bỏ trống";
                      }
                      if( value.length!=6){
                        return "Mã pin phải có 6 ký tự";
                      }
                      return null;
                    },
                    controller: _rePassword,
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
                    )),
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
                          "Tạo mã pin",
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
      ),
    );
  }
}
