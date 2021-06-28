import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/model/deal.dart';

import 'form_information_appraisal_2.dart';


class FormInformationAppraisal_1 extends StatefulWidget {
  Deal? deal;

  FormInformationAppraisal_1({Key? key,this.deal}) : super(key: key);

  @override
  _FormInformationAppraisal_1State createState() =>
      _FormInformationAppraisal_1State();
}

class _FormInformationAppraisal_1State
    extends State<FormInformationAppraisal_1> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _proposer = TextEditingController();
  TextEditingController _owner = TextEditingController();
  TextEditingController _purpose = TextEditingController();
  TextEditingController _timeAcceptAppraisal = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _addressReal = TextEditingController();

  int _kindLicense = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yrColor4,
      appBar: AppBar(
        backgroundColor: yrColor4,
        elevation: 0,
        leading: Container(),
        leadingWidth: 0,
        centerTitle: true,
        title: Text(
          "Form nhập thông tin thẩm định".toUpperCase(),
          style: kText18Bold_1,
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 8.w),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.clear,
                  size: 30.h,
                  color: yrColor1,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "I. Các thông tin chung".toUpperCase(),
                      style: kText16_2,
                    )),
                SizedBox(
                  height: 21.h,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Khách hàng đề nghị thẩm định:",
                        style: kText14Bold_2,
                      ),
                      TextFormField(
                        controller: _proposer,
                        style: kText14_2,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chủ sở hữu tài khoản:",
                        style: kText14Bold_2,
                      ),
                      TextFormField(
                        controller: _owner,
                        style: kText14_2,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mục đích thẩm định:",
                        style: kText14Bold_2,
                      ),
                      TextFormField(
                        controller: _purpose,
                        style: kText14_2,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Thời gian chấp nhận đề nghị thẩm định:",
                        style: kText14Bold_2,
                      ),
                      TextFormField(
                        controller: _timeAcceptAppraisal,
                        style: kText14_2,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 29.h,
                ),

                ///Vị trí bất động sản
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "II. Mô tả về bất động sản".toUpperCase(),
                        style: kText16_2,
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8.w),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "1. Vị trí bất động sản",
                        style: kText14Bold_2,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Địa chỉ:",
                            style: kText14_15,
                          ),
                          TextFormField(
                            controller: _address,
                            style: kText14_2,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Vị trí BĐS tọa lạc:",
                            style: kText14_15,
                          ),
                          TextFormField(
                            controller: _addressReal,
                            style: kText14_2,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),

                ///Chứng từ pháp lý
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8.w),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "2. Chứng từ pháp lý",
                        style: kText14Bold_2,
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                _kindLicense = 1;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 20.h,
                                  width: 20.h,
                                  decoration: BoxDecoration(
                                      color: _kindLicense == 1 ? yrColor14 : yrColor4,
                                      border: Border.all(color: yrColor14),
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Text(
                                  "Chứng từ pháp lý",
                                  style: kText14_2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height -
                                        480.h,
                                    left: 12.w,
                                    right: 12.w,
                                  ),
                                  content: Container(
                                    height: 53.h,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                                    decoration: BoxDecoration(
                                      color: yrColor1,
                                      borderRadius: BorderRadius.circular(10.h),
                                    ),
                                    child: Text(
                                      "Các chứng từ thực hiện theo quy định/ quy trình của Ngân hàng",
                                      style: kText14_4,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                getIcon("note.svg"),
                                width: 10.h,
                                height: 10.h,
                                color: yrColor1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                _kindLicense = 2;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 20.h,
                                  width: 20.h,
                                  decoration: BoxDecoration(
                                      color: _kindLicense == 2 ? yrColor14 : yrColor4,
                                      border: Border.all(color: yrColor14),
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Text(
                                  "Chứng từ nội bộ",
                                  style: kText14_2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          InkWell(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height -
                                        400.h,
                                    left: 12.w,
                                    right: 12.w,
                                  ),
                                  content: Container(
                                    height: 53.h,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                                    decoration: BoxDecoration(
                                      color: yrColor1,
                                      borderRadius: BorderRadius.circular(10.h),
                                    ),
                                    child: Text(
                                      "Các chứng từ liên quan đến BĐS thẩm định do cơ quan Nhà nước cấp",
                                      style: kText14_4,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                getIcon("note.svg"),
                                width: 10.h,
                                height: 10.h,
                                color: yrColor1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),

                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormInformationAppraisal_2(),
                        ),
                      );
                    },
                    child: Container(
                      height: 42.h,
                      width: 42.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: yrColor1),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_forward,
                        size: 25.h,
                        color: yrColor1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 6.w),
                      height: 5.h,
                      width: 63.w,
                      color: yrColor1,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 6.w),
                      height: 5.h,
                      width: 63.w,
                      color: yrColor9,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 6.w),
                      height: 5.h,
                      width: 63.w,
                      color: yrColor9,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 6.w),
                      height: 5.h,
                      width: 63.w,
                      color: yrColor9,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
