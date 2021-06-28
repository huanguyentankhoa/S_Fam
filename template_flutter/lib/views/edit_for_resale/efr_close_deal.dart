import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/model/deal.dart';
import 'package:youreal/views/detail/event_stream/event_stream.dart';
import 'package:youreal/views/detail/widget/popup_evaluate.dart';
class EfrCloseDeal extends StatefulWidget {
  final Deal deal;
  const EfrCloseDeal({Key? key, required this.deal}) : super(key: key);

  @override
  _EfrCloseDealState createState() => _EfrCloseDealState();
}

class _EfrCloseDealState extends State<EfrCloseDeal> {
  Widget _eventStreamBuild() {
    return Column(
      children: [
        timelineStartBuild("16/05", "Đóng giao dịch"),
        timelineBuild("15/05", "Thực hiện trước bạ sang tên"),
        timelineBuild("13/05", "Thanh toán toàn bộ"),
        timelineBuild("12/05", "Ký hợp đồng đầu tư và đặt cọc"),
        timelineBuild("10/05", "Chốt danh sách nhà đầu tư"),
        timelineBuild("04/05", "Gửi đề xuất cho các nhà đầu tư"),
        timelineBuild("26/04", "Đã thẩm định xong"),
        timelineBuild("24/04", "Hệ thống thẩm định đeal bán"),
        timelineEndBuild("20/04", "Tạo deal bán thành công"),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yrColor1,
      appBar: AppBar(
        backgroundColor: yrColor1,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80.w,
        leading: GestureDetector(
          onTap: () {
            Navigator.popUntil(context, (route) {
              print(route.settings.name);
              return route.settings.name ==
                  "/9f580fc5-c252-45d0-af25-9429992db112";
            });
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
                  await showDialog(
                    context: context,
                    builder: (_) => Evaluate(),
                  );
                },
                child: Container(
                  height: 30.h,
                  width: 110.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 10.w),
                  child: Text(
                    "Đánh giá",
                    style: kText16_13,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){

          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Column(
              children: [
                SizedBox(
                  height: 26.h,
                ),
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
                        width: 280.w,
                        margin: EdgeInsets.only(left: 10.w),
                        decoration: BoxDecoration(
                          color: yrColor8,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Hoàn tất".toUpperCase(),
                          style: kText14_2,
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
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () async {

                  },
                  child: Container(
                    height: 42.h,
                    width: MediaQuery.of(context).size.width - 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: yrColor3,
                        borderRadius: BorderRadius.circular(8.h)),
                    child: Text(
                      "Xem hợp đồng môi giới",
                      style: kText16Bold_1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () async {

                  },
                  child: Container(
                    height: 42.h,
                    width: MediaQuery.of(context).size.width - 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: yrColor3,
                        borderRadius: BorderRadius.circular(8.h)),
                    child: Text(
                      "Xem hợp đồng đầu tư",
                      style: kText16Bold_1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () async {
                    
                  },
                  child: Container(
                    height: 42.h,
                    width: MediaQuery.of(context).size.width - 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: yrColor3,
                        borderRadius: BorderRadius.circular(8.h)),
                    child: Text(
                      "Danh sách nhà đầu tư",
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
      ),
    );
  }
}
