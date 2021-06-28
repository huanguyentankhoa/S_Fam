import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';

class CardDealInvesting extends StatefulWidget {
  final nameCard;
  final address;
  final acreage;
  final price;
  final isInvestorsMain;
  final imageSample;
  final images;

  const CardDealInvesting({
    Key? key,
    required this.nameCard,
    required this.address,
    required this.acreage,
    required this.price,
    required this.isInvestorsMain,
    this.imageSample,
    this.images,
  }) : super(key: key);

  @override
  _CardDealInvestingState createState() => _CardDealInvestingState();
}

class _CardDealInvestingState extends State<CardDealInvesting> {
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
              child: widget.imageSample != null
                  ? getImage(
                widget.imageSample.toString(),
                fit: BoxFit.fill,
              )
                  : Container(),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 12.w,right: 12.w,top: 6.h),
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
                          size: 8,
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

                    Container(
                      margin: EdgeInsets.only(top: 3.h),
                      child: Text(
                        widget.price != null
                            ? "${widget.price} VNĐ"
                            : "Đang cập nhật",
                        style: kText14Bold_5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: 100.w,
              child: Row(
                children: [
                  Text("NDT chính",style: kText14Bold_5,),
                  SizedBox(width: 6.w,),
                  Container(
                    height: 30.h,
                    width: 27.h,
                    child:SvgPicture.asset(getIcon("files.svg"),color: yrColor1,),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
