import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';
import 'package:s_fam/view_models/app_provider.dart';
import 'package:s_fam/view_models/user_provider.dart';

import '../welcome_screen.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _mail = TextEditingController();
  TextEditingController _pinCode = TextEditingController(text: "123456");
  TextEditingController _password = TextEditingController(text: "123456");
  File? _image;
  late UserProvider _user;

  getImageSuccess(File? image) async {
    if (image != null) {
      setState(() {
        _image = image;
      });
      var fileImg = await MultipartFile.fromFile(_image!.path,
          filename: _image!.path.split('/').last);

      FormData data = FormData.fromMap({"files": fileImg});
      _user.uploadAvtUser(data: data);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var member =
        Provider.of<UserProvider>(context, listen: false).userCurrentLogin;
    setState(() {
      _name.text = member.name!;
      _mail.text = member.email!;
      _dob.text = Tools().getDate(member.dob!);
    });
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserProvider>(context);
    final _app = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 40),
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 42,
              ),
              Text(
                "Chào mừng",
                style: kSubText14Black,
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  _user.userCurrentLogin.name!,
                  style: kText16BlackBold,
                ),
              ),
              Stack(
                children: [
                  ClipOval(
                    child: Container(
                      height: 98,
                      width: 98,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryMain)),
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.fill,
                            )
                          : _user.userCurrentLogin.avatarUrl != null &&
                                  _user.userCurrentLogin.avatarUrl != ""
                              ? Tools()
                                  .getImage(_user.userCurrentLogin.avatarUrl!)
                              : Container(
                                  child: Image.asset(
                                    "assets/icons/logo.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _app.showPicker(
                          context: context, success: getImageSuccess);
                    },
                    child: Container(
                      height: 28,
                      width: 28,
                      margin: EdgeInsets.only(top: 70, left: 70),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFD4D7DB)),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),

              ///Họ tên
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5, top: 5),
                      child: Text(
                        "Họ và tên",
                        style: kText14BlackBold,
                      ),
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                          border: Border.all(color: textSecondary),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        controller: _name,
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.center,
                        style: kSubText16Black,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            border: InputBorder.none,
                            suffixIcon: InkWell(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => EditText(
                                      name: "Họ và tên",
                                      text: _name.text,
                                      onChange: (value) {
                                        setState(() {
                                          _name.text = value;
                                        });
                                      }),
                                );
                              },
                              child: Container(
                                child: Icon(
                                  Icons.edit,
                                  color: textSecondary,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              ///Ngày sinh
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5, top: 5),
                      child: Text(
                        "Ngày sinh",
                        style: kText14BlackBold,
                      ),
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                          border: Border.all(color: textSecondary),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        controller: _dob,
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.center,
                        style: kSubText16Black,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            border: InputBorder.none,
                            suffixIcon: InkWell(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => EditText(
                                      name: "Ngày Sinh",
                                      text: _dob.text,
                                      onChange: (value) {
                                        setState(() {
                                          _dob.text = value;
                                        });
                                      }),
                                );
                              },
                              child: Container(
                                child: Icon(
                                  Icons.edit,
                                  color: textSecondary,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              ///Gmail
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5, top: 5),
                      child: Text(
                        "Gmail",
                        style: kText14BlackBold,
                      ),
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                          border: Border.all(color: textSecondary),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        controller: _mail,
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.center,
                        style: kSubText16Black,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            border: InputBorder.none,
                            suffixIcon: InkWell(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => EditText(
                                      name: "Gmail",
                                      text: _mail.text,
                                      onChange: (value) {
                                        setState(() {
                                          _mail.text = value;
                                        });
                                      }),
                                );
                              },
                              child: Container(
                                child: Icon(
                                  Icons.edit,
                                  color: textSecondary,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              ///Mã pin
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5, top: 5),
                      child: Text(
                        "Mã pin",
                        style: kText14BlackBold,
                      ),
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                          border: Border.all(color: textSecondary),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        controller: _pinCode,
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.center,
                        style: kSubText16Black,
                        obscureText: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            border: InputBorder.none,
                            suffixIcon: InkWell(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => EditText(
                                      name: "Mã pin",
                                      isChangePass: true,
                                      text: _pinCode.text,
                                      onChange: (value) {
                                        setState(() {
                                          _pinCode.text = value;
                                        });
                                      }),
                                );
                              },
                              child: Container(
                                child: Icon(
                                  Icons.edit,
                                  color: textSecondary,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              ///Mật khẩu
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5, top: 5),
                      child: Text(
                        "Mật khẩu",
                        style: kText14BlackBold,
                      ),
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                          border: Border.all(color: textSecondary),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        controller: _password,
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.center,
                        style: kSubText16Black,
                        obscureText: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            border: InputBorder.none,
                            suffixIcon: InkWell(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => EditText(
                                      name: "Mật khẩu",
                                      isChangePass: true,
                                      text: _password.text,
                                      onChange: (value) {
                                        setState(() {
                                          _password.text = value;
                                        });
                                      }),
                                );
                              },
                              child: Container(
                                child: Icon(
                                  Icons.edit,
                                  color: textSecondary,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              InkWell(
                onTap: () {
                  _user.logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ),
                      (route) => false);
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: 25,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Đăng xuất",
                        style: kText16BlackBold,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditText extends StatefulWidget {
  final String name;
  final String text;
  final bool? isChangePass;
  final Function(String) onChange;

  const EditText({
    Key? key,
    required this.name,
    required this.text,
    required this.onChange,
    this.isChangePass = false,
  }) : super(key: key);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _reController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!widget.isChangePass!)
      setState(() {
        _controller.text = widget.text;
      });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(left: 10, right: 10),
      content: Container(
        height: widget.isChangePass! ? 180 : 90,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Text(
                      widget.isChangePass! ? "${widget.name} mới" : widget.name,
                      style: kText14BlackBold,
                    ),
                  ),
                  TextFormField(
                    controller: _controller,
                    obscureText: widget.isChangePass!,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.isChangePass!)
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5, top: 5),
                      child: Text(
                        widget.isChangePass!
                            ? "Nhập lại ${widget.name}"
                            : widget.name,
                        style: kText14BlackBold,
                      ),
                    ),
                    TextFormField(
                      controller: _reController,
                      obscureText: widget.isChangePass!,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: InkWell(
              onTap: () {
                widget.onChange(_controller.text);
                Navigator.pop(context);
              },
              child: Text(
                "CHỈNH SỬA",
                style: kText16BlueBold,
              )),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "HỦY",
                style: kText16BlackBold,
              )),
        )
      ],
    );
  }
}
