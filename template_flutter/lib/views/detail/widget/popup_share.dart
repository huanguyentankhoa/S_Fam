import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';

class PopupShare extends StatefulWidget {
  const PopupShare({Key? key}) : super(key: key);

  @override
  _PopupShareState createState() => _PopupShareState();
}

class _PopupShareState extends State<PopupShare> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 271.h,
        padding: EdgeInsets.all(9.h),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "CHIA SẺ",
                style: kText20_1,
              ),
            ),
            Container(
              height: 56.h,
              color: yrColor17,
              padding: EdgeInsets.all(9.h),
              child: Row(
                children: [
                  SvgPicture.asset(
                  getIcon("website.svg"),
                    color: yrColor1,
                    width: 42.w,
                    height: 40.h,
                  ),
                  SizedBox(width: 12.w,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Deal Ngôi nhà A",style: kText20_2,),
                      Text("3 giờ trước",style: kText12_2,),
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
