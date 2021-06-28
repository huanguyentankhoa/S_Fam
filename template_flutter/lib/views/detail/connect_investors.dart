import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/model/deal.dart';
import 'package:youreal/routes/ui_pages.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/views/detail/closing_investors.dart';
import 'package:youreal/views/detail/widget/popup_approval.dart';
import 'package:youreal/views/detail/widget/popup_change_leader.dart';

import 'event_stream/event_stream.dart';

class ConnectInvestors extends StatefulWidget {
  final Deal deal;
  final DateTime startTimeWaiting;

  const ConnectInvestors(
      {Key? key, required this.deal, required this.startTimeWaiting})
      : super(key: key);

  @override
  _ConnectInvestorsState createState() => _ConnectInvestorsState();
}

class _ConnectInvestorsState extends State<ConnectInvestors> {
  late Timer timer;
  String timeWaiting = "00:00:00";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_timer) {
      DateTime time = DateTime.now();
      widget.startTimeWaiting.add(Duration(hours: 4));
      var count = time.difference(widget.startTimeWaiting);
      setState(() {
        timeWaiting =
            "${(4 - (count.inHours % 24)).toString().padLeft(2, '0')}:" +
                "${(59 - (count.inMinutes % 60)).toString().padLeft(2, '0')}:" +
                "${(60 - (count.inSeconds % 60)).toString().padLeft(2, '0')}";
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

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
                      width: MediaQuery.of(context).size.width - 20.w,
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
                              color: yrColor2,
                              borderRadius: BorderRadius.circular(15.h),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "CHỐT DEAL ĐẦU TƯ",
                              style: kText14_3,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 48.h,
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text(
                                      "Thời gian giữ Deal",
                                      style: kText12_3,
                                    ),
                                    Text(
                                      timeWaiting,
                                      style: kText16_13,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                  widget.deal.imageSample,
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
                      widget.deal.name,
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
                            widget.deal.address,
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
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 18.w),
                    child: Text(
                      "3,210,000,000 VNĐ",
                      style: kText24Bold_13,
                    ),
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
                          percent: 0.7,
                          backgroundColor: yrColor3,
                          progressColor: yrColor13,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 24.w, top: 2.h),
                          child: Text(
                            "2,385,000,000",
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
                      "5 người đầu tư",
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

              GestureDetector(
                onTap: () {
                  // _appModel.currentAction = PageAction(
                  //     state: PageState.addWidget,
                  //     widget: ClosingInvestors(
                  //       deal: widget.deal,
                  //     ),
                  //     page: DetailPage2Config);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClosingInvestors(deal: widget.deal),
                    ),
                  );
                },
                child: Container(
                  height: 220.h,
                  width: MediaQuery.of(context).size.width,
                  color: yrColor9,
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          "Danh sách NĐT",
                          style: kText16Bold_1,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: Text(
                              "Nhà đầu tư chính:",
                              style: kText16Bold_5,
                            ),
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
                                      shape: BoxShape.circle, color: yrColor1),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Nguyễn Văn A   ",
                                      style: kText16Bold_1,
                                      children: [
                                        TextSpan(
                                            text: " (25%)", style: kText16_1)
                                      ]),
                                ),
                                Container(
                                  height: 24.h,
                                  width: 105.w,
                                  margin: EdgeInsets.only(left: 12.w),
                                  decoration: BoxDecoration(
                                    color: yrColor1,
                                    borderRadius: BorderRadius.circular(12.h),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "LEADER nhóm",
                                    style: kText16_3,
                                  ),
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
                                      shape: BoxShape.circle, color: yrColor1),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Trần An M   ",
                                      style: kText16Bold_1,
                                      children: [
                                        TextSpan(
                                            text: " (22%)", style: kText16_1)
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 8.h),
                            child: Text(
                              "Nhà đầu tư phụ:",
                              style: kText16Bold_1,
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
                                      shape: BoxShape.circle, color: yrColor1),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Nguyễn Văn A   ",
                                      style: kText16Bold_1,
                                      children: [
                                        TextSpan(
                                            text: " (12%)", style: kText16_1)
                                      ]),
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
                                      shape: BoxShape.circle, color: yrColor1),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Trần An M   ",
                                      style: kText16Bold_1,
                                      children: [
                                        TextSpan(
                                            text: " (10%)", style: kText16_1)
                                      ]),
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
                                      shape: BoxShape.circle, color: yrColor1),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Hoàng Thị T   ",
                                      style: kText16Bold_1,
                                      children: [
                                        TextSpan(
                                            text: " (7%)", style: kText16_1)
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
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
                    builder: (context) => Container(
                      height: 53.h,
                      decoration: BoxDecoration(
                          color: yrColor4,
                          borderRadius: BorderRadius.circular(10.h)),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: yrColor1),
                            child: Icon(
                              Icons.phone,
                              color: yrColor4,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "0901234567",
                                style: kText40Bold_1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                  _appModel.hideNavBar = false;
                },
                child: Container(
                  height: 42.h,
                  width: MediaQuery.of(context).size.width - 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: yrColor3,
                      borderRadius: BorderRadius.circular(8.h)),
                  child: Text(
                    "LIÊN HỆ MÔI GIỚI",
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

  Widget _eventStreamBuild() {
    return Column(
      children: [
        timelineStartBuild("04/05", "Gửi đề xuất cho các nhà đầu tư"),
        timelineBuild("26/04", "Đã thẩm định xong"),
        timelineBuild("24/04", "Hệ thống thẩm định deal bán"),
        timelineEndBuild("20/04", "Tạo deal bán thành công")
      ],
    );
  }
}
