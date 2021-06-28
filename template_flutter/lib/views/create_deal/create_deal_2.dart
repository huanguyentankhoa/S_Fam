import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/views/form_appraisal/form_information_appraisal_1.dart';
import 'package:youreal/views/create_deal/widget/popup_doc_of_owner.dart';
import 'package:youreal/views/create_deal/widget/popup_doc_of_real.dart';

import 'create_deal_complete.dart';

class CreateDeal_2 extends StatefulWidget {
  const CreateDeal_2({Key? key}) : super(key: key);
  @override
  _CreateDeal_2State createState() => _CreateDeal_2State();
}

class _CreateDeal_2State extends State<CreateDeal_2> {
  String _valueDoc1 = "Sổ đỏ";
  String _valueDoc2 = "Sổ hộ khẩu";
  List<String> listDocs = ["Sổ hộ khẩu", "Sổ đỏ"];

  bool isAppraisal = false;

  bool agreeRule = false;

  @override
  Widget build(BuildContext context) {
    final _appModel = Provider.of<AppModel>(context);

    return Scaffold(
      backgroundColor: yrColor1,
      appBar: AppBar(
        backgroundColor: yrColor1,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Khởi tạo Deal",
          style: kText18Bold_3,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: Column(
            children: [
              ///Hồ sơ liên quan đến Bất động sản
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hồ sơ liên quan đến Bất động sản",
                      style: kText16Bold_3,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            _appModel.hideNavBar = true;
                            await showMaterialModalBottomSheet(
                              context: context,
                              backgroundColor: yrColor3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.h),
                                topLeft: Radius.circular(15.h),
                              )),
                              builder: (context) => PopupDocOfReal(
                                onSelect: (result) {
                                  setState(() {
                                    _valueDoc1 = result;
                                  });
                                },
                              ),
                            );
                            _appModel.hideNavBar = false;
                          },
                          child: Container(
                            height: 35.h,
                            padding: EdgeInsets.only(left: 10.w, right: 5.w),
                            decoration: BoxDecoration(
                                border: Border.all(color: yrColor4),
                                borderRadius: BorderRadius.circular(10.h)),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _valueDoc1,
                                  style: kText16Bold_3,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: yrColor8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 35.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                              color: yrColor4,
                              borderRadius: BorderRadius.circular(8.h)),
                          alignment: Alignment.center,
                          child: Text(
                            "Upload hình",
                            style: kText14Bold_1,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hình ảnh: 4/10",
                      style: kText14_3,
                    ),
                  ),
                  Container(
                    height: 142.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          width: 108.w,
                          margin: EdgeInsets.only(right: 10.w),
                          child: getImage(
                            "sodo1.png",
                          ),
                        ),
                        Container(
                          width: 108.w,
                          margin: EdgeInsets.only(right: 10.w),
                          child: getImage(
                            "sodo1.png",
                          ),
                        ),
                        Container(
                          width: 108.w,
                          margin: EdgeInsets.only(right: 10.w),
                          child: getImage(
                            "sodo1.png",
                          ),
                        ),
                        Container(
                          width: 108.w,
                          margin: EdgeInsets.only(right: 10.w),
                          child: getImage(
                            "sodo1.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 50.h,
              ),

              ///Hồ sơ liên quan đến chủ bất động sản
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hồ sơ liên quan đến chủ bất động sản",
                      style: kText16Bold_3,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            _appModel.hideNavBar = true;
                            await showMaterialModalBottomSheet(
                              context: context,
                              backgroundColor: yrColor3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.h),
                                topLeft: Radius.circular(15.h),
                              )),
                              builder: (context) => PopupDocOfOwner(
                                onSelect: (result) {
                                  setState(() {
                                    _valueDoc2 = result;
                                  });
                                },
                              ),
                            );
                            _appModel.hideNavBar = false;
                          },
                          child: Container(
                            height: 35.h,
                            padding: EdgeInsets.only(left: 10.w, right: 5.w),
                            decoration: BoxDecoration(
                                border: Border.all(color: yrColor4),
                                borderRadius: BorderRadius.circular(10.h)),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _valueDoc2,
                                  style: kText16Bold_3,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: yrColor8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 35.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                              color: yrColor4,
                              borderRadius: BorderRadius.circular(8.h)),
                          alignment: Alignment.center,
                          child: Text(
                            "Upload hình",
                            style: kText14Bold_1,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hình ảnh: 3/10",
                      style: kText14_3,
                    ),
                  ),
                  Container(
                    height: 142.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          width: 206.w,
                          margin: EdgeInsets.only(right: 10.w),
                          child: getImage(
                            "sohokhau.png",
                          ),
                        ),
                        Container(
                          width: 206.w,
                          margin: EdgeInsets.only(right: 10.w),
                          child: getImage(
                            "sohokhau.png",
                          ),
                        ),
                        Container(
                          width: 206.w,
                          margin: EdgeInsets.only(right: 10.w),
                          child: getImage(
                            "sohokhau.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 32.h,
              ),

              ///Tổng quan
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TỔNG QUAN",
                          style: kText14Bold_4,
                        ),
                        Icon(
                          Icons.edit_outlined,
                          color: yrColor4,
                          size: 20.h,
                        )
                      ],
                    ),
                    Container(
                      height: 84.h,
                      width: MediaQuery.of(context).size.width,
                      decoration:
                          BoxDecoration(border: Border.all(color: yrColor14)),
                      padding: EdgeInsets.only(top: 12.h),
                      child: TextFormField(
                        maxLines: null,
                        expands: true,
                        initialValue:
                            "• Nhà đẹp mới sửa xong xách vali vào là ở.\n"
                            "• Vị trí gần chợ 200m, gần đại học kinh tế, y dược.\n "
                            "• Sổ hồng riêng.",
                        style: kText14_4,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12.w)),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 32.h,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tài sản đã được thẩm định chưa",
                  style: kText16_3,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isAppraisal = false;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 20.h,
                          width: 20.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isAppraisal ? yrColor4 : yrColor14,
                              border: Border.all(color: yrColor4, width: 2)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Chưa thẩm định",
                          style: kText14Bold_4,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isAppraisal = true;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 20.h,
                          width: 20.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isAppraisal ? yrColor14 : yrColor4,
                              border: Border.all(color: yrColor4, width: 2)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Đã được thẩm định",
                          style: kText14Bold_4,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        _appModel.hideNavBar = true;
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormInformationAppraisal_1(),
                          ),
                        );
                        _appModel.hideNavBar = false;
                      },
                      child: Container(
                        height: 41.h,
                        color: yrColor4,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        alignment: Alignment.center,
                        child: Text(
                          "FORM NHẬP THÔNG TIN THẨM ĐỊNH",
                          style: kText14_1,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    if (isAppraisal)
                      Row(
                        children: [
                          SvgPicture.asset(
                            getIcon("check1.svg"),
                            color: yrColor14,
                            height: 30.h,
                            width: 30.h,
                          ),
                          Text(
                            "Đã xác nhận thẩm định",
                            style: kText10_14,
                          ),
                        ],
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    agreeRule = !agreeRule;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 15.h,
                      width: 15.h,
                      decoration: BoxDecoration(
                        color: agreeRule ? yrColor4 : Colors.transparent,
                        border: Border.all(color: yrColor7),
                      ),
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    RichText(
                        text: TextSpan(
                            text: "Tôi đã đọc và hiểu nội dung ",
                            style: kText14_4,
                            children: [
                          TextSpan(
                            text: "thỏa thuận hợp đồng",
                            style: kText14Bold_4,
                          ),
                        ]))
                  ],
                ),
              ),

              SizedBox(
                height: 20.h,
              ),

              InkWell(
                onTap: agreeRule
                    ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateDealComplete()));
                      }
                    : null,
                child: Container(
                  height: 48.h,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  decoration: BoxDecoration(
                      color: agreeRule ? yrColor4 : yrColor7,
                      borderRadius: BorderRadius.circular(15.h)),
                  alignment: Alignment.center,
                  child: Text(
                    "NỘP HỒ SƠ",
                    style: kText16Bold_1,
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
