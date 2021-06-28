import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/model/deal.dart';
import 'package:youreal/views/detail/event_stream/event_stream.dart';
import 'package:youreal/views/edit_for_resale/efr_connect_investors.dart';
class EfrAppraised extends StatefulWidget {
  final Deal deal;
  const EfrAppraised({Key? key, required this.deal}) : super(key: key);

  @override
  _EfrAppraisedState createState() => _EfrAppraisedState();
}

class _EfrAppraisedState extends State<EfrAppraised> {
  @override
  Widget build(BuildContext context) {
    Widget _eventStreamBuild() {
      return Column(
        children: [
          timelineStartBuild("26/04", "Đã thẩm định xong"),
          timelineBuild("24/04", "Hệ thống thẩm định đeal bán"),
          timelineEndBuild("20/04", "Tạo deal bán thành công"),
        ],
      );
    }
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
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EfrConnectInvestors(deal: widget.deal,),
              ),
            );
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
                        width: 193.w,
                        margin: EdgeInsets.only(left: 10.w),
                        decoration: BoxDecoration(
                          color: yrColor3,
                          borderRadius: BorderRadius.circular(15.h),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Khởi tạo deal".toUpperCase(),
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

              ],
            ),
          ),
        ),
      ),

    );
  }
}
