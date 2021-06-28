import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/model/deal.dart';
import 'package:youreal/views/form_appraisal/form_information_appraisal_5.dart';
import 'package:youreal/views/form_appraisal/widget/item_analysis.dart';

class FormInformationAppraisal_4 extends StatefulWidget {
  Deal? deal;
   FormInformationAppraisal_4({Key? key,this.deal}) : super(key: key);

  @override
  _FormInformationAppraisal_4State createState() =>
      _FormInformationAppraisal_4State();
}

class _FormInformationAppraisal_4State
    extends State<FormInformationAppraisal_4> {
  final GlobalKey<FormState> _formKey = GlobalKey();

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
                    "2. Bảng phân tích và điều chỉnh các BĐS so sánh về BĐS thẩm định",
                    style: kText14Bold_2,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "2.1. Bảng phân tích đất Thổ cư/ đất SXKD/ đất NN",
                    style: kText14_15,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Pháp lý".toUpperCase(),
                    nameItem: "BĐS so sánh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Quy mô, kích thước".toUpperCase(),
                    nameItem: "BĐS so sánh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Hình dáng".toUpperCase(),
                    nameItem: "BĐS so sánh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Giao thông".toUpperCase(),
                    nameItem: "BĐS so sánh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Lợi thế kinh doanh".toUpperCase(),
                    nameItem: "BĐS so sánh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Môi trường, an ninh".toUpperCase(),
                    nameItem: "BĐS so sánh"),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "2.2 Bảng điều chỉnh đất Thổ cư/ đất SXKD/ đất NN",
                    style: kText14_15,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis:
                        "Đơn giá đất Thổ cư trước khi điều chỉnh (đồng/m²)",
                    nameItem: "Tỉ lệ điều chỉnh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Pháp lý (%)", nameItem: "Tỉ lệ điều chỉnh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Quy mô, kích thước (%)",
                    nameItem: "Tỉ lệ điều chỉnh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Hình dáng (%)",
                    nameItem: "Tỉ lệ điều chỉnh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Giao thông (%)",
                    nameItem: "Tỉ lệ điều chỉnh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Lợi thế kinh doanh (%)",
                    nameItem: "Tỉ lệ điều chỉnh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Môi trường, an ninh (%)",
                    nameItem: "Tỉ lệ điều chỉnh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Tổng tỉ lệ điều chỉnh (%)",
                    nameItem: "Tỉ lệ điều chỉnh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Hệ số điều chỉnh (%)",
                    nameItem: "Tỉ lệ điều chỉnh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Đơn giá đấy sau khi điều chỉnh (đồng/m²)",
                    nameItem: "Tỉ lệ điều chỉnh"),
                SizedBox(
                  height: 15.h,
                ),
                ItemAnalysis(
                    nameAnalysis: "Đơn giá đất thẩm định bình quân (%)",
                    nameItem: "Tỉ lệ điều chỉnh"),
                SizedBox(
                  height: 15.h,
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
                          builder: (context) => FormInformationAppraisal_5(),
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
                    Container(
                      margin: EdgeInsets.only(right: 6.w),
                      height: 5.h,
                      width: 63.w,
                      color: yrColor1,
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
