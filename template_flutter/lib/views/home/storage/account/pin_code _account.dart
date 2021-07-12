import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/view_models/user_provider.dart';
class PinCodeAccount extends StatefulWidget {
  const PinCodeAccount({Key? key}) : super(key: key);

  @override
  _PinCodeAccountState createState() => _PinCodeAccountState();
}

class _PinCodeAccountState extends State<PinCodeAccount> {
  bool isDone = false;
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  late StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    errorController = StreamController<ErrorAnimationType>();
    setState(() {
      isDone = false;
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    errorController.close();
    textEditingController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.only(left: 10, right: 10),
      titlePadding: EdgeInsets.zero,
      content: Container(
        height: 158,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text("Vui lòng nhập mã pin để truy cập",style: kText18BlueBold,),
            ),
            SizedBox(
              height: 20,
            ),
            PinCodeTextField(
              length: 6,
              appContext: context,
              controller: textEditingController,
              errorAnimationController: errorController,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              // focusNode: _focusNode,
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              validator: (v) {
                if (v!.length == 6 && v != user.userCurrentLogin.pinCode) {
                  return "";
                } else {
                  return null;
                }
              },
              hintWidget: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.circle
                ),
              ),
              animationDuration: Duration(milliseconds: 300),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                borderWidth: 1,
                fieldHeight: 38,
                fieldWidth: 42,
                activeColor: isDone ? Colors.greenAccent : Colors.redAccent,
                inactiveFillColor: Colors.transparent,
                inactiveColor: Color(0xFFCCCCCC),
                activeFillColor: Color(0xffF8F8FA),
                selectedColor: Color(0xff0FAFDA),
                selectedFillColor: Colors.transparent,
              ),
              onChanged: (value) {
                if (value == user.userCurrentLogin.pinCode) {
                  setState(() {
                    isDone = true;
                    currentText = value;
                    // _focusNode.unfocus();
                  });
                } else {
                  setState(() {
                    isDone = false;
                    currentText = value;
                  });
                }
              },
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 24),
            //   child: Text("Quên mật khẩu",style: kSubText14Black,),
            // ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(bottom: 22),
      actions: [
        InkWell(
          onTap: () {
            Navigator.pop(context,false);
          },
          child: Container(
            height: 52,
            width: MediaQuery.of(context).size.width/2-50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              "Hủy bỏ",
              style: kText16BlueBold,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context,true);
          },
          child: Container(
            height: 52,
            width: MediaQuery.of(context).size.width/2-50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isDone?primaryMain:textSecondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              "Tiếp tục",
              style: kText16WhiteBold,
            ),
          ),
        ),

      ],
    );
  }
}
