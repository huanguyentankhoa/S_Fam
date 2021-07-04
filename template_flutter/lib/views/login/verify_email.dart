import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/general.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/login/change_password.dart';
import 'package:s_fam/views/signIn/infoAccount.dart';
import 'package:s_fam/widgets/app_bar.dart';

class VerifyEmail extends StatefulWidget {
  final String? screenNext;
  final String? email;
  final String? code;
  const VerifyEmail({Key? key, this.screenNext,this.email,this.code}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final _formKey = GlobalKey<FormState>();
  bool isDone = false;
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  late StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  int _start = 59;
  late Timer _timer;
  late UserProvider _user;

  ButtonStatus stateOnlyText = ButtonStatus.idle;

  void onPressedCustomButton() async {
    if (stateOnlyText == ButtonStatus.idle) {
      setState(() {
        stateOnlyText = ButtonStatus.loading;
      });
      Future.delayed(Duration(seconds: 2), () async {
        if(_formKey.currentState!.validate()){
          bool result = await _user.confirmEmail(textEditingController.text);
          if(result){

            switch (widget.screenNext){
              case "changePass":
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePassword(),
                  ),
                );
                break;
              case "continueSignIn":
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoAccount(
                        email: widget.email
                    ),
                  ),
                );
                break;
            }
            setState(() {
              stateOnlyText = ButtonStatus.success;
            });
            setState(() {
              stateOnlyText = ButtonStatus.idle;
            });
          }else{
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
  void initState() {
    // TODO: implement initState
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
    setState(() {
      isDone = false;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    errorController.close();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserProvider>(context);
    print(widget.code);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGenerated(),
      body: SingleChildScrollView(
        child: Form(
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
                    "Xác thực Email",
                    style: kText20BlueBold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  width: 295,
                  child:  Text.rich(
                    TextSpan(
                      text: 'Mã xác thực đã được gửi tới email: ',
                      style:kSubText14Black,
                      children: <TextSpan>[
                        TextSpan(
                            text: '******23@gmail.com',
                            style:kText14Black),
                        // can add more TextSpans here...
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 40,
                ),
                Container(
                  width: 250,
                  child: PinCodeTextField(
                    length: 4,
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
                      if (v!.length == 4 && v != widget.code) {
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
                      fieldHeight: 50,
                      fieldWidth: 46,
                      activeColor: isDone ? Colors.greenAccent : Colors.redAccent,
                      inactiveFillColor: Colors.transparent,
                      inactiveColor: Color(0xFFCCCCCC),
                      activeFillColor: Color(0xffF8F8FA),
                      selectedColor: Color(0xff0FAFDA),
                      selectedFillColor: Colors.transparent,
                    ),
                    onChanged: (value) {
                      if (value == widget.code) {
                        setState(() {
                          isDone = true;
                          currentText = value;
                        });
                      } else {
                        setState(() {
                          isDone = false;
                          currentText = value;
                        });
                      }
                    },
                  ),
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
                  child:ProgressButtonAnimation(
                    onPressed: onPressedCustomButton,
                    state: stateOnlyText,
                    height: 52,
                    maxWidth: MediaQuery.of(context).size.width,
                    stateWidgets: {
                      ButtonStatus.idle: Text(
                        "Xác thực",
                        style: kText16WhiteBold,
                      ),
                      ButtonStatus.fail: Text(
                        "Xác thực không thành công",
                        style: kText14White,
                      ),
                      ButtonStatus.success: Text(
                        "Xác thực thành công",
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
                SizedBox(
                  height: 28,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text( _start < 10
                      ?  "00:0${_start}s"
                      :  "00:${_start}s",style: kText16Black,),),
                SizedBox(
                  height: 28,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Gửi lại mã",
                      style: kText16Blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
