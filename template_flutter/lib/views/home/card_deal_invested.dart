import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/model/deal.dart';
import 'package:youreal/views/edit_for_resale/efr_waiting_appraisal.dart';
import 'package:youreal/views/sell_with_handwritten_paper/shp_connect_investors.dart';

class CardDealInvested extends StatefulWidget {
  final Deal deal;

  const CardDealInvested({
    Key? key,
    required this.deal,
  }) : super(key: key);

  @override
  _CardDealInvestedState createState() => _CardDealInvestedState();
}

class _CardDealInvestedState extends State<CardDealInvested> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: yrColor3,
      margin: EdgeInsets.symmetric(vertical: 2.h),
      shape: RoundedRectangleBorder(),
      child: Container(
        height: 68.h,
        child: Row(
          children: [
            Container(
              height: 68.h,
              width: 68.h,
              child: widget.deal.imageSample != ""
                  ? getImage(
                      widget.deal.imageSample.toString(),
                      fit: BoxFit.fill,
                    )
                  : Container(),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 6.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.deal.name != ""
                          ? widget.deal.name
                          : "Đang cập nhật",
                      style: kText16Bold_2,
                    ),
                    Container(
                      height: 10.h,
                      child: Row(
                        children: [
                          Container(
                            height: 10.h,
                            alignment: Alignment.topCenter,
                            child: Icon(
                              Icons.my_location_outlined,
                              color: yrColor7,
                              size: 8,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                              height: 10.h,
                              child: Text(
                                widget.deal.address != ""
                                    ? widget.deal.address
                                    : "Đang cập nhật",
                                style: kText10_7,
                              ))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: yrColor7,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          widget.deal.acreage != ""
                              ? "${widget.deal.acreage} m²"
                              : "Đang cập nhật",
                          style: kText10_7,
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3.h),
                      child: Text(
                        widget.deal.price != ""
                            ? "${widget.deal.price} VNĐ"
                            : "Đang cập nhật",
                        style: kText14Bold_5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EfrWaitingAppraisal(
                      deal: widget.deal,
                    ),
                  ),
                );
              },
              child: Container(
                  width: 50.w,
                  height: 25.h,
                  margin: EdgeInsets.only(right: 20.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.h),
                      color: yrColor1),
                  alignment: Alignment.center,
                  child: Text(
                    "Bán lại",
                    style: kText12_4,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
