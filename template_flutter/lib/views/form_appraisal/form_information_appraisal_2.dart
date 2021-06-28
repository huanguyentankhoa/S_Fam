import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/model/deal.dart';

import 'form_information_appraisal_3.dart';


class FormInformationAppraisal_2 extends StatefulWidget {
  Deal? deal;
   FormInformationAppraisal_2({Key? key,this.deal}) : super(key: key);

  @override
  _FormInformationAppraisal_2State createState() =>
      _FormInformationAppraisal_2State();
}

class _FormInformationAppraisal_2State
    extends State<FormInformationAppraisal_2> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _proposer = TextEditingController();
  TextEditingController _origin = TextEditingController();
  TextEditingController _expiryDate = TextEditingController();
  TextEditingController _lengthReality1 = TextEditingController();
  TextEditingController _widthReality1 = TextEditingController();
  TextEditingController _lengthReality2 = TextEditingController();
  TextEditingController _widthReality2 = TextEditingController();
  TextEditingController _lengthRecognized1 = TextEditingController();
  TextEditingController _widthRecognized1 = TextEditingController();
  TextEditingController _lengthRecognized2 = TextEditingController();
  TextEditingController _widthRecognized2 = TextEditingController();
  TextEditingController _acreage1 = TextEditingController();
  TextEditingController _acreage2 = TextEditingController();
  TextEditingController _constructionItems = TextEditingController();
  TextEditingController _yearBuilt = TextEditingController();
  TextEditingController _convenient = TextEditingController();
  TextEditingController _numberFloors = TextEditingController();
  TextEditingController _wall = TextEditingController();
  TextEditingController _roof = TextEditingController();
  TextEditingController _floor = TextEditingController();
  TextEditingController _lengthReality3 = TextEditingController();
  TextEditingController _widthReality3 = TextEditingController();
  TextEditingController _lengthGCNQSH = TextEditingController();
  TextEditingController _widthGCNQSH = TextEditingController();
  TextEditingController _lengthGPXD = TextEditingController();
  TextEditingController _widthGPXD = TextEditingController();
  TextEditingController _lengthOverGPXD = TextEditingController();
  TextEditingController _widthOverGPXD = TextEditingController();
  TextEditingController _currentUserStatus = TextEditingController();
  TextEditingController _relationship = TextEditingController();

  int soilType = 1;

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
                  padding: EdgeInsets.only(left: 8.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "3. Đặc điểm về đất",
                    style: kText14Bold_2,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "3.1. Về đất",
                    style: kText14_15,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                /// Mục đích sử dụng
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mục đích sử dụng đất:",
                        style: kText14_2,
                      ),
                      TextFormField(
                        style: kText14_2,
                        controller: _proposer,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Nguồn gốc sử dụng
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nguồn gốc sử dụng đất:",
                        style: kText14_2,
                      ),
                      TextFormField(
                        style: kText14_2,
                        controller: _origin,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Thời hạn sự dụng
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Thời gian sử dụng đất:",
                        style: kText14_2,
                      ),
                      TextFormField(
                        style: kText14_2,
                        controller: _expiryDate,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Diện tích sử dụng thực tế
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Diện tích sử dụng thực tế",
                        style: kText14_2,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Chiều dài 1",
                                  style: kText14_2,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Container(
                                  height: 20.h,
                                  width: 54.w,
                                  color: yrColor17,
                                  child: TextFormField(
                                    style: kText14_2,
                                    controller: _lengthReality1,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                Text(
                                  " m²",
                                  style: kText14_2,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Chiều rộng 1",
                                  style: kText14_2,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Container(
                                  height: 20.h,
                                  width: 54.w,
                                  color: yrColor17,
                                  child: TextFormField(
                                    style: kText14_2,
                                    controller: _widthReality1,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                Text(
                                  " m²",
                                  style: kText14_2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Chiều dài 2",
                                  style: kText14_2,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Container(
                                  height: 20.h,
                                  width: 54.w,
                                  color: yrColor17,
                                  child: TextFormField(
                                    style: kText14_2,
                                    controller: _lengthReality2,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                Text(
                                  " m²",
                                  style: kText14_2,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Chiều rộng 2",
                                  style: kText14_2,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Container(
                                  height: 20.h,
                                  width: 54.w,
                                  color: yrColor17,
                                  child: TextFormField(
                                    style: kText14_2,
                                    controller: _widthReality2,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                Text(
                                  " m²",
                                  style: kText14_2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Diện tích sử dụng được công nhận
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Diện tích sử dụng được công nhận",
                        style: kText14_2,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Chiều dài 1",
                                  style: kText14_2,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Container(
                                  height: 20.h,
                                  width: 54.w,
                                  color: yrColor17,
                                  child: TextFormField(
                                    style: kText14_2,
                                    controller: _lengthRecognized1,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                Text(
                                  " m²",
                                  style: kText14_2,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Chiều rộng 1",
                                  style: kText14_2,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Container(
                                  height: 20.h,
                                  width: 54.w,
                                  color: yrColor17,
                                  child: TextFormField(
                                    style: kText14_2,
                                    controller: _widthRecognized1,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                Text(
                                  " m²",
                                  style: kText14_2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Chiều dài 2",
                                  style: kText14_2,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Container(
                                  height: 20.h,
                                  width: 54.w,
                                  color: yrColor17,
                                  child: TextFormField(
                                    style: kText14_2,
                                    controller: _lengthRecognized2,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                Text(
                                  " m²",
                                  style: kText14_2,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Chiều rộng 2",
                                  style: kText14_2,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Container(
                                  height: 20.h,
                                  width: 54.w,
                                  color: yrColor17,
                                  child: TextFormField(
                                    style: kText14_2,
                                    controller: _widthRecognized2,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                Text(
                                  " m²",
                                  style: kText14_2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Loại đất sử dụng
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Loại đất sử dụng:",
                        style: kText14_2,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  soilType = 1;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 20.h,
                                    width: 20.h,
                                    decoration: BoxDecoration(
                                        color: soilType == 1
                                            ? yrColor14
                                            : yrColor4,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: yrColor14)),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    " Đất thổ cư",
                                    style: kText14_2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  soilType = 2;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 20.h,
                                    width: 20.h,
                                    decoration: BoxDecoration(
                                        color: soilType == 2
                                            ? yrColor14
                                            : yrColor4,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: yrColor14)),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    " Đất nông nghiệp",
                                    style: kText14_2,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  soilType = 3;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 20.h,
                                    width: 20.h,
                                    decoration: BoxDecoration(
                                        color: soilType == 3
                                            ? yrColor14
                                            : yrColor4,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: yrColor14)),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    " SXKD",
                                    style: kText14_2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "DT thuộc LG",
                                        style: kText14_2,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 54.w,
                                        color: yrColor17,
                                        child: TextFormField(
                                          style: kText14_2,
                                          controller: _acreage1,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Text(
                                        " m²",
                                        style: kText14_2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "DT không thuộc LG",
                                        style: kText14_2,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 54.w,
                                        color: yrColor17,
                                        child: TextFormField(
                                          style: kText14_2,
                                          controller: _acreage2,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Text(
                                        " m²",
                                        style: kText14_2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "3.2. Về tài sản trên đất",
                    style: kText14_15,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                /// Hạng muc công trình
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hạng muc công trình",
                        style: kText14_2,
                      ),
                      TextFormField(
                        style: kText14_2,
                        controller: _constructionItems,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Năm xây dựng
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Năm xây dụng",
                        style: kText14_2,
                      ),
                      TextFormField(
                        style: kText14_2,
                        controller: _yearBuilt,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Tiện nghi
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tiện nghi",
                        style: kText14_2,
                      ),
                      TextFormField(
                        style: kText14_2,
                        controller: _convenient,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Cấu trúc
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cấu trúc",
                        style: kText14_2,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Số tầng",
                                    style: kText14_2,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Container(
                                    height: 20.h,
                                    width: 54.w,
                                    color: yrColor17,
                                    child: TextFormField(
                                      style: kText14_2,
                                      controller: _numberFloors,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tường",
                                    style: kText14_2,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Container(
                                    height: 20.h,
                                    width: 54.w,
                                    color: yrColor17,
                                    child: TextFormField(
                                      style: kText14_2,
                                      controller: _wall,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Mái",
                                    style: kText14_2,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Container(
                                    height: 20.h,
                                    width: 54.w,
                                    color: yrColor17,
                                    child: TextFormField(
                                      style: kText14_2,
                                      controller: _roof,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Nền",
                                    style: kText14_2,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Container(
                                    height: 20.h,
                                    width: 54.w,
                                    color: yrColor17,
                                    child: TextFormField(
                                      style: kText14_2,
                                      controller: _floor,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Diện tích sử dung thực tế
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Diện tích sử dụng thực tế",
                        style: kText14_2,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Chiều dài 1",
                                        style: kText14_2,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 54.w,
                                        color: yrColor17,
                                        child: TextFormField(
                                          style: kText14_2,
                                          controller: _lengthReality3,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Text(
                                        " m²",
                                        style: kText14_2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Chiều rộng 1",
                                        style: kText14_2,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 54.w,
                                        color: yrColor17,
                                        child: TextFormField(
                                          style: kText14_2,
                                          controller: _widthReality3,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Text(
                                        " m²",
                                        style: kText14_2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Diện tích được cấp GCN QSH
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Diện tích được cấp GCN QSH",
                        style: kText14_2,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Chiều dài 1",
                                        style: kText14_2,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 54.w,
                                        color: yrColor17,
                                        child: TextFormField(
                                          style: kText14_2,
                                          controller: _lengthGCNQSH,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Text(
                                        " m²",
                                        style: kText14_2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Chiều rộng 1",
                                        style: kText14_2,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 54.w,
                                        color: yrColor17,
                                        child: TextFormField(
                                          style: kText14_2,
                                          controller: _widthGCNQSH,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Text(
                                        " m²",
                                        style: kText14_2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Diện tích xây dựng phù hợp GPXD
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Diện tích xây dựng phù hợp GPXD",
                        style: kText14_2,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Chiều dài 1",
                                        style: kText14_2,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 54.w,
                                        color: yrColor17,
                                        child: TextFormField(
                                          style: kText14_2,
                                          controller: _lengthGPXD,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Text(
                                        " m²",
                                        style: kText14_2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Chiều rộng 1",
                                        style: kText14_2,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 54.w,
                                        color: yrColor17,
                                        child: TextFormField(
                                          style: kText14_2,
                                          controller: _widthGPXD,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Text(
                                        " m²",
                                        style: kText14_2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Diện tích xây dựng không phù hợp/ vượt GPXD
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Diện tích xây dựng không phù hợp/ vượt GPXD",
                        style: kText14_2,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Chiều dài 1",
                                        style: kText14_2,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 54.w,
                                        color: yrColor17,
                                        child: TextFormField(
                                          style: kText14_2,
                                          controller: _lengthOverGPXD,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Text(
                                        " m²",
                                        style: kText14_2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Chiều rộng 1",
                                        style: kText14_2,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Container(
                                        height: 20.h,
                                        width: 54.w,
                                        color: yrColor17,
                                        child: TextFormField(
                                          style: kText14_2,
                                          controller: _widthOverGPXD,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Text(
                                        " m²",
                                        style: kText14_2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Hiện trạng sử dụng của BĐS
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "4. Hiện trạng sử dụng của bất động sản",
                        style: kText14Bold_2,
                      ),
                      TextFormField(
                        style: kText14_2,
                        controller: _currentUserStatus,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                ///Mối quan hệ giữa người đang sử dụng tài sản (BĐS) và CSH
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "5. Mối quan hệ giữa người đang sử dụng tài sản (BĐS) và CSH",
                        style: kText14Bold_2,
                      ),
                      TextFormField(
                        style: kText14_2,
                        controller: _relationship,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormInformationAppraisal_3(),
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
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

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
