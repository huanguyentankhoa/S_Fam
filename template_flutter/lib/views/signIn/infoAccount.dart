import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';
import 'package:s_fam/models/member.dart';

import 'package:s_fam/views/signIn/create_password.dart';
import 'package:s_fam/widgets/app_bar.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:s_fam/widgets/text_input.dart';

class InfoAccount extends StatefulWidget {
  final String? email;

  const InfoAccount({Key? key, required this.email}) : super(key: key);

  @override
  _InfoAccountState createState() => _InfoAccountState();
}

class _InfoAccountState extends State<InfoAccount> {
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _fullName = TextEditingController();
  String gender = "Nam";
  String dob = "";

  List<String> listGender = [
    "Nam",
    "Nữ",
  ];

  late Member member;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dob = DateTime.now().toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGenerated(),
      body: SingleChildScrollView(
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
              Container(
                margin: EdgeInsets.only(top: 8),
                width: 295,
                child: Text(
                  "Vui lòng nhập thông tin cá nhân của bạn ở đây:",
                  style: kSubText14Black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextInput(
                height: 48,
                labelText: "Họ và tên",
                validator: (value) {
                  return value!.isEmpty ? "Không được bỏ trống" : null;
                },
                controller: _fullName,
              ),
              SizedBox(
                height: 40,
              ),
              TextInput(
                height: 48,
                labelText: "Số điện thoại",
                validator: (value) {
                  return value!.isEmpty ? "Không được bỏ trống" : null;
                },
                controller: _phoneNumber,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    padding: EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                        border: Border.all(color: textSecondary),
                        borderRadius: BorderRadius.circular(8)),
                    child: DropdownButton<String>(
                      value: gender,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 1,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                          member.gender = value;
                        });
                      },
                      items: listGender
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      padding: EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: textSecondary),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Tools().getDate(dob),
                            style: kText16Black,
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePassword(
                        gender: gender,
                        name: _fullName.text,
                        dob: dob,
                        email: widget.email!,
                        phoneNumber: _phoneNumber.text,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryMain,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Tiếp tục",
                    style: kText16WhiteBold,
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
