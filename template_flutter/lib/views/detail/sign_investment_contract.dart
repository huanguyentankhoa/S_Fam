import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/model/deal.dart';
import 'package:youreal/routes/ui_pages.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/views/detail/full_payment.dart';

import 'event_stream/event_stream.dart';
import 'widget/popup_approval.dart';
import 'widget/popup_change_leader.dart';


class SignInvestmentContract extends StatefulWidget {
  final Deal deal;
  const SignInvestmentContract({Key? key, required this.deal}) : super(key: key);

  @override
  _SignInvestmentContractState createState() => _SignInvestmentContractState();
}

class _SignInvestmentContractState extends State<SignInvestmentContract> {
  @override
  Widget build(BuildContext context) {
    AppModel _appModel = Provider.of<AppModel>(context);
    return Scaffold(
      backgroundColor: yrColor1,
      appBar: AppBar(
        backgroundColor: yrColor1,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80.w,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Icon(
                Icons.chevron_left,
                color: yrColor4,
                size: 38.w,
              ),
              Container(
                  margin: EdgeInsets.only(left: 28.w),
                  child: Text(
                    "Back",
                    style: kText18_3,
                  ))
            ],
          ),
        ),
        title: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 5),
          child: Text(
            "Nhà riêng",
            style: kText18Bold_3,
          ),
        ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  var result = await showDialog(
                    context: context, builder: (_) => ChangeLeader(),);
                  if(result){
                    await showDialog(
                      context: context, builder: (_) => Approval(),);
                  }
                },
                child: Container(
                  height: 30.h,
                  width: 110.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: BoxDecoration(
                      color: yrColor4,
                      borderRadius: BorderRadius.circular(15.h)),
                  child: Text(
                    "CHUYỂN QUYỀN LEADER",
                    style: kText10_5,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: Column(
            children: [
              SizedBox(
                height: 26.h,
              ),
              Container(
                height: 35.h,
                child: Row(
                  children: [
                    Container(
                      height: 35.h,
                      alignment: Alignment.center,
                      child: Text(
                        "Giai đoạn:",
                        style: kText14_3,
                      ),
                    ),
                    Container(
                      height: 35.h,
                      width: 193.w,
                      margin: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                        color: yrColor13,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ĐẦU TƯ",
                        style: kText14_1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 38.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: _eventStreamBuild(),
              ),
              SizedBox(
                height: 42.h,
              ),
              Container(
                height: 204.h,
                width: MediaQuery.of(context).size.width,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12.h)),
                child: getImage(
                  "image_1.png",
                  fit: BoxFit.fill,
                ),
              ),

              SizedBox(
                height: 12.h,
              ),

              ///header
              Column(
                children: [
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "Ngôi nhà của A",
                      style: kText20Bold_4,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          child: Icon(
                            Icons.my_location_outlined,
                            color: yrColor3,
                            size: 10,
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Container(
                          child: Text(
                            "43 Ngô Gia Tư, P.4, Q.10, TP.Hồ Chí Minh",
                            style: kText12_3,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Cách xa 1.2 KM",
                              style: kText12_3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      "Xem chi tiết thông tin",
                      style: kText12Bold_4,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Column(
                children: [
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "GIÁ TRỊ BĐS",
                      style: kText14Bold_4,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 18.w),
                        child: Text(
                          "3,210,000,000 VNĐ",
                          style: kText24Bold_13,
                        ),
                      ),
                      SizedBox(width: 50.w,),
                      Container(
                        height: 52.h,
                        width: 52.h,
                        decoration: BoxDecoration(
                            color: yrColor4,
                            shape: BoxShape.circle
                        ),
                        alignment: Alignment.center,
                        child: Text("100%",style: kText16_1,),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),

              Column(
                children: [
                  Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: RichText(
                        text: TextSpan(
                            text: "Tổng tiền đầu tư ",
                            style: kText20Bold_4,
                            children: [
                              TextSpan(
                                text: "3,210,000,000",
                                style: kText20Bold_13,
                              )
                            ]),
                      )),
                  SizedBox(
                    height: 18.h,
                  ),
                  Container(
                    height: 18.h,
                    padding: EdgeInsets.only(left: 12.w),
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8.h)),
                    child: Stack(
                      children: [
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 80,
                          lineHeight: 20.h,
                          percent: 1,
                          backgroundColor: yrColor3,
                          progressColor: yrColor13,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 24.w, top: 2.h),
                          child: Text(
                            "3,210,000,000",
                            style: kText12_1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 35.w, top: 2.h),
                    child: Text(
                      "6 người đầu tư",
                      style: kText12_3,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 15.w),
                      alignment: AlignmentDirectional.centerStart,
                      child: RichText(
                        text: TextSpan(
                          text: "Số tiền đầu tư",
                          style: kText18_3,
                        ),
                      )),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.w),
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    alignment: AlignmentDirectional.centerStart,
                    height: 24.h,
                    width: MediaQuery.of(context).size.width - 80,
                    color: Colors.white30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "802,000,000",
                          style: kText12_13,
                        ),
                        Text(
                          "VNĐ",
                          style: kText12_13,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),

              Container(
                height: 230.h,
                width: MediaQuery.of(context).size.width,
                color: yrColor9,
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text("Danh sách NĐT",style: kText16Bold_1,),
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Text("Nhà đầu tư chính:",style: kText16Bold_5,),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 24.w),
                          margin: EdgeInsets.only(top: 12.h),
                          child: Row(
                            children: [
                              Container(
                                height: 4,
                                width: 4,
                                margin: EdgeInsets.only(right: 12.w),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: yrColor1
                                ),
                              ),
                              RichText(text: TextSpan(
                                  text: "Nguyễn Văn A   ",
                                  style: kText16Bold_1,
                                  children: [
                                    TextSpan(
                                        text: " (25%)",
                                        style: kText16_1
                                    )
                                  ]
                              ),),

                              Container(
                                height: 24.h,
                                width: 105.w,
                                margin: EdgeInsets.only(left: 12.w),
                                decoration: BoxDecoration(
                                  color: yrColor1,
                                  borderRadius: BorderRadius.circular(12.h),
                                ),
                                alignment: Alignment.center,
                                child: Text("LEADER nhóm",style: kText16_3,),
                              ),

                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 24.w),
                          child: Row(
                            children: [
                              Container(
                                height: 4,
                                width: 4,
                                margin: EdgeInsets.only(right: 12.w),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: yrColor1
                                ),
                              ),
                              RichText(text: TextSpan(
                                  text: "Trần An M   ",
                                  style: kText16Bold_1,
                                  children: [
                                    TextSpan(
                                        text: " (22%)",
                                        style: kText16_1
                                    )
                                  ]
                              ),),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 24.w),
                          child: Row(
                            children: [
                              Container(
                                height: 4,
                                width: 4,
                                margin: EdgeInsets.only(right: 12.w),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: yrColor1
                                ),
                              ),
                              RichText(text: TextSpan(
                                  text: "Phạm Y   ",
                                  style: kText16Bold_1,
                                  children: [
                                    TextSpan(
                                        text: " (24%)",
                                        style: kText16_1
                                    )
                                  ]
                              ),),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h,),

                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: Text("Nhà đầu tư phụ:",style: kText16Bold_1,),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 24.w),
                          child: Row(
                            children: [
                              Container(
                                height: 4,
                                width: 4,
                                margin: EdgeInsets.only(right: 12.w),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: yrColor1
                                ),
                              ),
                              RichText(text: TextSpan(
                                  text: "Nguyễn Văn A   ",
                                  style: kText16Bold_1,
                                  children: [
                                    TextSpan(
                                        text: " (12%)",
                                        style: kText16_1
                                    )
                                  ]
                              ),),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 24.w),
                          child: Row(
                            children: [
                              Container(
                                height: 4,
                                width: 4,
                                margin: EdgeInsets.only(right: 12.w),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: yrColor1
                                ),
                              ),
                              RichText(text: TextSpan(
                                  text: "Trần An M   ",
                                  style: kText16Bold_1,
                                  children: [
                                    TextSpan(
                                        text: " (10%)",
                                        style: kText16_1
                                    )
                                  ]
                              ),),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 24.w),
                          child: Row(
                            children: [
                              Container(
                                height: 4,
                                width: 4,
                                margin: EdgeInsets.only(right: 12.w),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: yrColor1
                                ),
                              ),
                              RichText(text: TextSpan(
                                  text: "Hoàng Thị T   ",
                                  style: kText16Bold_1,
                                  children: [
                                    TextSpan(
                                        text: " (7%)",
                                        style: kText16_1
                                    )
                                  ]
                              ),),
                            ],
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap:(){

              },
                      child: Container(
                        height: 62.h,
                        width:MediaQuery.of(context).size.width/2-25,
                        decoration: BoxDecoration(
                            color: yrColor4,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        alignment: Alignment.center,
                        child: Text("XEM HỢP ĐỒNG",style: kText16Bold_1,),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        // _appModel.currentAction = PageAction(
                        //     state: PageState.addWidget,
                        //     widget: FullPayment(
                        //       deal: widget.deal,
                        //     ),
                        //     page: DetailPage4Config);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullPayment(deal: widget.deal,),
                          ),
                        );
                      },
                      child: Container(
                        height: 62.h,
                        width:MediaQuery.of(context).size.width/2-25,
                        decoration: BoxDecoration(
                            color: yrColor13,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        alignment: Alignment.center,
                        child: Text("KÝ HĐ VÀ ĐẶT CỌC",style: kText16Bold_1,),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _eventStreamBuild() {
    return Column(
      children: [
        timelineStartBuild("12/05", "Ký hợp đồng đầu tư và đặt cọc"),
        timelineBuild("10/05", "Chốt danh sách nhà đầu tư"),
        timelineBuild("04/05", "Gửi đề xuất cho các nhà đầu tư"),
        timelineBuild("30/04", "Đã ký hợp đồng môi giới"),
        timelineBuild("26/04", "Đã thẩm định xong"),
        timelineBuild("24/04", "Hệ thống thẩm định deal bán"),
        timelineEndBuild("20/04", "Tạo deal bán thành công")
      ],
    );
  }
}
