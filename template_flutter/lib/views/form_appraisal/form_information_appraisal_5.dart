import 'package:flutter/material.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/model/deal.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/views/create_deal/create_deal.dart';
import 'package:youreal/views/create_deal/create_deal_2.dart';
import 'package:youreal/views/deal/deal_screen.dart';
import 'package:youreal/views/form_appraisal/widget/images.dart';

class FormInformationAppraisal_5 extends StatefulWidget {
  Deal? deal;
   FormInformationAppraisal_5({Key? key,this.deal}) : super(key: key);

  @override
  _FormInformationAppraisal_5State createState() =>
      _FormInformationAppraisal_5State();
}

class _FormInformationAppraisal_5State
    extends State<FormInformationAppraisal_5> {
  ButtonStatus stateOnlyText = ButtonStatus.idle;
  late AppModel appModel;
  void onPressedCustomButton() async {
    setState(() {
      stateOnlyText = ButtonStatus.loading;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        stateOnlyText = ButtonStatus.idle;
      });
      appModel.hideNavBar = false;
      Navigator.popUntil(context, (route){
        return route.settings.name == "/createDeal2";
      });

    });
  }

  @override
  Widget build(BuildContext context) {
     appModel = Provider.of<AppModel>(context);
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
          child: Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "IV. Kết quả thẩm định".toUpperCase(),
                    style: kText16_2,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "1.Giá trị quyền sử dụng đất",
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
                    "1.1.Giá trị QSDĐ thổ cư",
                    style: kText14_2,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w,right: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextInput(
                        name: "Đơn giá UBND",
                        nameStyle: kText12_2,
                        input: TextFormField(
                          style: kText12_2,
                          keyboardType: TextInputType.number,
                          decoration:
                          InputDecoration(border: InputBorder.none),
                        ),
                        width: 95.w,
                        sub: " đồng/m²",
                        subStyle: kText10_2
                      ),
                      TextInput(
                          name: "Hệ số K",
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                          width: 91.w,),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextInput(
                          name: "Đơn giá thẩm định",
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 95.w,
                          sub: " đồng/m²",
                          subStyle: kText10_2
                      ),
                      TextInput(
                        name: "Diện tích",
                        nameStyle: kText12_2,
                        input: TextFormField(
                          style: kText12_2,
                          keyboardType: TextInputType.number,
                          decoration:
                          InputDecoration(border: InputBorder.none),
                        ),
                        width: 91.w,
                          sub: " m²",
                          subStyle: kText10_2
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextInput(
                          name: "Thành tiền",
                          nameAlign: Alignment.centerLeft,
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 143.w,
                          sub: " đồng",
                          subStyle: kText10_2
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "2. Giá trị tài sản trên đất",
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
                    "2.1 Đã được cấp GCN QSH nhà ở/ công trình",
                    style: kText14_2,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w,right: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextInput(
                          name: "Đơn giá UBND",
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 95.w,
                          sub: " đồng/m²",
                          subStyle: kText10_2
                      ),
                      TextInput(
                        name: "Hệ số K",
                        nameStyle: kText12_2,
                        input: TextFormField(
                          style: kText12_2,
                          keyboardType: TextInputType.number,
                          decoration:
                          InputDecoration(border: InputBorder.none),
                        ),
                        width: 91.w,),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextInput(
                          name: "Đơn giá thẩm định",
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 95.w,
                          sub: " đồng/m²",
                          subStyle: kText10_2
                      ),
                      TextInput(
                          name: "Diện tích",
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 91.w,
                          sub: " m²",
                          subStyle: kText10_2
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextInput(
                          name: "Thành tiền",
                          nameAlign: Alignment.centerLeft,
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 143.w,
                          sub: " đồng",
                          subStyle: kText10_2
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "2.2 Xây dựng phù hợp GPXD ",
                    style: kText14_2,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w,right: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextInput(
                          name: "Đơn giá UBND",
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 95.w,
                          sub: " đồng/m²",
                          subStyle: kText10_2
                      ),
                      TextInput(
                        name: "Hệ số K",
                        nameStyle: kText12_2,
                        input: TextFormField(
                          style: kText12_2,
                          keyboardType: TextInputType.number,
                          decoration:
                          InputDecoration(border: InputBorder.none),
                        ),
                        width: 91.w,),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextInput(
                          name: "Đơn giá thẩm định",
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 95.w,
                          sub: " đồng/m²",
                          subStyle: kText10_2
                      ),
                      TextInput(
                          name: "Diện tích",
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 91.w,
                          sub: " m²",
                          subStyle: kText10_2
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextInput(
                          name: "Thành tiền",
                          nameAlign: Alignment.centerLeft,
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 143.w,
                          sub: " đồng",
                          subStyle: kText10_2
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "2.3 Xây dựng không phép/ Vượt GPXD ",
                    style: kText14_2,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w,right: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextInput(
                          name: "Đơn giá UBND",
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 95.w,
                          sub: " đồng/m²",
                          subStyle: kText10_2
                      ),
                      TextInput(
                        name: "Hệ số K",
                        nameStyle: kText12_2,
                        input: TextFormField(
                          style: kText12_2,
                          keyboardType: TextInputType.number,
                          decoration:
                          InputDecoration(border: InputBorder.none),
                        ),
                        width: 91.w,),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextInput(
                          name: "Đơn giá thẩm định",
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 95.w,
                          sub: " đồng/m²",
                          subStyle: kText10_2
                      ),
                      TextInput(
                          name: "Diện tích",
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 91.w,
                          sub: " m²",
                          subStyle: kText10_2
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextInput(
                          name: "Thành tiền",
                          nameAlign: Alignment.centerLeft,
                          nameStyle: kText12_2,
                          input: TextFormField(
                            style: kText12_2,
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                          width: 143.w,
                          sub: " đồng",
                          subStyle: kText10_2
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "3.Tổng giá trị BĐS thẩm định",
                    style: kText14Bold_2,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 20.h,
                  padding: EdgeInsets.only(left: 12.w),
                  child: Row(
                    children: [
                      Container(
                        height: 20.h,
                        width: 320.w,
                        color: yrColor17,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text("15,700,000,000",style: kText14Bold_1,),
                      ),
                      Text("  đồng",style: kText10_2,)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                    padding: EdgeInsets.only(left: 12.w),
                  alignment: Alignment.centerLeft,
                    child: Text("Bằng chữ",style: kText12_2,)),
                SizedBox(height: 8.h,),
                Container(
                  height: 20.h,
                  padding: EdgeInsets.only(left: 12.w),
                  child: Row(
                    children: [
                      Container(
                        height: 20.h,
                        width: 320.w,
                        color: yrColor17,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text("Mười năm tỷ bảy trăm triệu",style: kText14Bold_1,),
                      ),
                      Text("  đồng",style: kText10_2,)
                    ],
                  ),
                ),

                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "3. Ảnh chụp tài sảng thẩm định",
                    style: kText14Bold_2,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 122.h,
                    padding: EdgeInsets.only(left: 12.w),
                    child: Images()),

                SizedBox(
                  height: 50.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 45.w),
                  height: 48.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.h),
                  ),
                  alignment: Alignment.center,
                  child: ProgressButtonAnimation(
                    onPressed: onPressedCustomButton,
                    state: stateOnlyText,
                    height: 58.h,
                    maxWidth: MediaQuery.of(context).size.width,
                    stateWidgets: {
                      ButtonStatus.idle: Text(
                        "Gửi thẩm định".toUpperCase(),
                        style: kText18_3,
                      ),
                      ButtonStatus.fail: Text(
                        "Gửi không thành công",
                        style: kText18_3,
                      ),
                      ButtonStatus.success: Text(
                        "Gửi thẩm định".toUpperCase(),
                        style: kText18_3,
                      ),
                    },
                    stateColors: {
                      ButtonStatus.idle: yrColor1,
                      ButtonStatus.loading: yrColor14,
                      ButtonStatus.fail: yrColor5,
                      ButtonStatus.success: yrColor16,
                    },
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),

                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
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
                        Icons.arrow_back,
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
                      color: yrColor1,
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
