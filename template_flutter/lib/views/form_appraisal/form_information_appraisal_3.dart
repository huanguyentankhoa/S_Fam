import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/model/deal.dart';
import 'package:youreal/views/form_appraisal/form_information_appraisal_4.dart';
import 'package:youreal/views/form_appraisal/widget/item_survey.dart';

class FormInformationAppraisal_3 extends StatefulWidget {
  Deal? deal;
   FormInformationAppraisal_3({Key? key,this.deal}) : super(key: key);

  @override
  _FormInformationAppraisal_3State createState() =>
      _FormInformationAppraisal_3State();
}

class _FormInformationAppraisal_3State
    extends State<FormInformationAppraisal_3> {
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
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "III. Phương pháp thẩm định".toUpperCase(),
                    style: kText16_2,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "1. Thông tin khảo sát",
                    style: kText14Bold_2,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Nguồn thông tin',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Trạng thái thông tin',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Thời điểm thu thập',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Số nhà',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Tên đường, phường, quận',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Pháp lý',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Thời hạn sử dụng còn lại',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Nguồn gốc sử dụng đất',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Diện tích',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Chiều dài',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Chiều rộng',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Diện tích đất thổ cư',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Diện tích đất nông nghiệp',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Diện tích đất SXKD',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Diện tích nhà',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Kết cấu',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Giá rao bán',
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Giá thương lượng, giá giao dịch thành công',
                  heightName: 40.h,
                ),
                SizedBox(
                  height: 15.h,
                ),
                ItemSurvey(
                  nameSurvey: 'Giá trị xây dựng',
                ),
                SizedBox(
                  height: 15.h,
                ),
                   ItemSurvey(
                  nameSurvey: 'Đơn giá xây dựng',
                ),
                SizedBox(
                  height: 15.h,
                ),
                   ItemSurvey(
                  nameSurvey: 'Đơn giá đất nông nghiệp',
                ),
                SizedBox(
                  height: 15.h,
                ),
                   ItemSurvey(
                  nameSurvey: 'Đơn giá đất SXKD',
                ),
                SizedBox(
                  height: 15.h,
                ),

                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormInformationAppraisal_4(),
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
                      color: yrColor1,
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
