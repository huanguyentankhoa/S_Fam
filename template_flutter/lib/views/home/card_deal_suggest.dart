import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';

class CardDealSuggest extends StatefulWidget {
  final nameCard;
  final address;
  final acreage;
  final numberFollower;
  final price;
  final imageSample;
  final images;
  final Function? onTap;
  const CardDealSuggest(
      {Key? key,
      required this.nameCard,
      required this.address,
      required this.acreage,
      required this.numberFollower,
      required this.price,
      this.imageSample,
      this.images,
        required this.onTap,
      })
      : super(key: key);

  @override
  _CardDealSuggestState createState() => _CardDealSuggestState();
}

class _CardDealSuggestState extends State<CardDealSuggest> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: yrColor3,
      margin: EdgeInsets.only(right: 10),
      child: Container(
        height: 180.h,
        width: 290.w,
        padding: EdgeInsets.all(6.h),
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: 130.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nameCard != null
                          ? widget.nameCard
                          : "Đang cập nhật",
                      style: kText14Bold_2,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      height: 30.h,
                      child: Row(
                        children: [
                          Container(
                            height: 30.h,
                            alignment: Alignment.topCenter,
                            child: Icon(
                              Icons.my_location_outlined,
                              color: yrColor7,
                              size: 10,
                            ),
                          ),
                          Container(
                              height: 30.h,
                              width: 100.w,
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
                        Text(
                          "120 m²",
                          style: kText10_7,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility_outlined,
                          color: yrColor7,
                          size: 10,
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
                      height: 15.h,
                    ),
                    Container(
                      child: Text(
                        widget.price != null
                            ? "${widget.price} VNĐ"
                            : "Đang cập nhật",
                        style: kText18Bold_5,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: (){
                        widget.onTap!();
                      },
                      child: Container(
                        height: 26.h,
                        width: 103.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: yrColor1,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          "Xem chi tiết",
                          style: kText12_4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                  height: 168.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.h),
                  ),
                  child:  widget.imageSample != null
                      ? getImage(
                    widget.imageSample.toString(),
                    fit: BoxFit.fill,
                  )
                      : Container(),),
            )
          ],
        ),
      ),
    );
  }
}
