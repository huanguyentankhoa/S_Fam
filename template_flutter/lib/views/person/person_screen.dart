import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/config.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';
import 'package:s_fam/models/group.dart';
import 'package:s_fam/view_models/app_provider.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/home/storage/account/create_pin_code.dart';
import 'package:s_fam/views/login/change_password.dart';

import '../welcome_screen.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  TextEditingController _name = TextEditingController();
  // TextEditingController _dob = TextEditingController();
  String dob = "";
  TextEditingController _mail = TextEditingController();
  TextEditingController _pinCode = TextEditingController();
  TextEditingController _password = TextEditingController(text: "123456");
  String codeFamily = "";
  String? _imagePath;
  late UserProvider _user;

  getImageSuccess(String? path) async {
    if (path != null) {
      setState(() {
        _imagePath = path;
      });
      _user.uploadAvtUser(
          imagePath: _imagePath!,
          success: () {
            _user.getUserInfo(_mail.text);
          },
          fail: () {});
    }
  }

  getImageGallerySuccess(List<Asset> resultList) async {
    await FlutterAbsolutePath.getAbsolutePath(resultList.first.identifier!)
        .then((value) async {
      setState(() {
        _imagePath = value;
      });
      _user.uploadAvtUser(
          imagePath: _imagePath!,
          success: () {
            _user.getUserInfo(_mail.text);
          },
          fail: () {});
    });
  }

  Group? _group;

  @override
  void initState() {
    super.initState();
    var member =
        Provider.of<UserProvider>(context, listen: false).userCurrentLogin;
    loadInit();
    print(member.dob);
    setState(() {
      _name.text = member.name!;
      _mail.text = member.email!;
      dob =member.dob!;
      _pinCode.text = member.pinCode ?? "";
    });
  }

  loadInit() async {
    _group = await Provider.of<UserProvider>(context, listen: false)
        .getDataMyGroup();
    setState(() {});
  }

  editInfo() async {
    await Provider.of<UserProvider>(context, listen: false).editInfoUser(
      email: _mail.text,
      dob: dob,
      fullName: _name.text,
    );
    Provider.of<UserProvider>(context, listen: false).getUserInfo(_mail.text);
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
                      child: _user.userCurrentLogin.avatarUrl != null &&
                              _user.userCurrentLogin.avatarUrl != ""
                          ? Tools().getImage("${serverConfig["url"]}" +
                              "api/v1/image/download?path=${_mail.text}&name=${_user.userCurrentLogin.avatarUrl}")
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
                          context: context,
                          successCamera: getImageSuccess,
                          successGallery: (result) {
                            getImageGallerySuccess(result);
                          });
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

              ///Email
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5, top: 5),
                      child: Text(
                        "Email",
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
                            suffixIcon: Container(
                              height: 20,
                              width: 20,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
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
                                        editInfo();
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

                    InkWell(
                      onTap: () async {
                        DateTime? newDateTime = await showRoundedDatePicker(
                          context: context,
                          theme: ThemeData(primarySwatch: Colors.blue),
                          height: 350,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 100),
                          lastDate: DateTime(DateTime.now().year + 5),
                          borderRadius: 16,
                        );
                        if (newDateTime != null) {
                          setState(() {
                            dob = newDateTime.toString();
                          });
                          editInfo();
                        }
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 12, right: 12),
                        decoration: BoxDecoration(
                            border: Border.all(color: textSecondary),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Tools().getDate(dob),
                              style: kSubText16Black,
                            ),
                            Container(
                              height: 24,
                              width: 24,
                              child: SvgPicture.asset(
                                "assets/icons/calendar_date.svg",
                                color: textSecondary,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
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
                                  builder: (context) => CreatePinCode(
                                    success: (newPinCode) {
                                      setState(() {
                                        _pinCode.text = newPinCode;
                                      });
                                    },
                                  ),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangePassword(
                                      email: _mail.text,
                                      fromMenu: true,
                                    ),
                                  ),
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

              ///Mã gia đình
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5, top: 5),
                      child: Text(
                        "Mã gia đình: ${_group != null ? _group!.name : ""}",
                        style: kText14BlackBold,
                      ),
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                          border: Border.all(color: textSecondary),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width - 80,
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                _group != null ? _group!.key : "",
                                style: kSubText16Black,
                              )),
                          InkWell(
                            onTap: _group != null
                                ? () {
                                    FlutterClipboard.copy(_group!.key)
                                        .then((value) {
                                      const snackBar = SnackBar(
                                        content:
                                            Text("Đã sao chép mã gia đình"),
                                        duration: Duration(seconds: 3),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    });
                                  }
                                : () {},
                            child: Container(
                              child: Icon(
                                Icons.copy,
                                color: textSecondary,
                              ),
                            ),
                          )
                        ],
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
                    style: kText14Black,
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
                      style: kText14Black,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
            // if (widget.isChangePass!)
            //   TextInput(
            //     height: 50,
            //     controller: _reController,
            //     labelText: widget.isChangePass!
            //         ? "Nhập lại ${widget.name}"
            //         : widget.name,
            //     obscureText: widget.isChangePass!,
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(8)),
            //     ),
            //   )
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
