import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';

class CardDealRecently extends StatefulWidget {
  final nameCard;
  final address;
  final acreage;
  final numberFollower;
  final price;
  final isExpired;
  final imageSample;
  final images;

  const CardDealRecently({
    Key? key,
    required this.nameCard,
    required this.address,
    required this.acreage,
    required this.numberFollower,
    required this.price,
    required this.isExpired,
    this.imageSample,
    this.images,
  }) : super(key: key);

  @override
  _CardDealRecentlyState createState() => _CardDealRecentlyState();
}

class _CardDealRecentlyState extends State<CardDealRecently> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.isExpired ? yrColor7 : yrColor3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.h),
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 110.h,
        child: Row(
          children: [
            Container(
              height: 110.h,
              width: 113.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.h),
              ),
              child: widget.imageSample != null
                  ? getImage(
                widget.imageSample.toString(),
                fit: BoxFit.fill,
              )
                  : Container(),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 12.w, right: 12.w,top: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nameCard != null
                          ? widget.nameCard
                          : "Đang cập nhật",
                      style: kText16Bold_2,
                    ),
                    Container(
                      height: 20.h,
                      child: Row(
                        children: [
                          Container(
                            height: 15.h,
                            alignment: Alignment.topCenter,
                            child: Icon(
                              Icons.my_location_outlined,
                              color: yrColor7,
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                              height: 15.h,
                              child: Text(
                                widget.address != null
                                    ? widget.address
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
                          size: 10,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          widget.acreage != null
                              ? "${widget.acreage} m²"
                              : "Đang cập nhật",
                          style: kText10_7,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility_outlined,
                          color: yrColor7,
                          size: 10,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          widget.numberFollower != null
                              ? "${widget.numberFollower} người quan tâm"
                              : "Đang cập nhật",
                          style: kText10_7,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            widget.price != null
                                ? "${widget.price} VNĐ"
                                : "Đang cập nhật",
                            style: kText18Bold_5,
                          ),
                        ),
                        Row(
                          children: [
                            if( widget.isExpired)
                              Container(
                                height: 19.h,
                                width: 59.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: yrColor5)
                                ),
                                child: Text("HẾT HẠN", style: kText12_5,),
                              ),
                            SizedBox(width: 13.w,),
                            Container(
                              height: 20.h,
                              width: 20.w,
                              child: Icon(
                                Icons.ios_share,
                                size: 25.h,
                                color: yrColor1,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
