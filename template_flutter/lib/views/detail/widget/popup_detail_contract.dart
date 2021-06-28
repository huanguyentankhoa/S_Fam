import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PopupDetailContract extends StatefulWidget {
  const PopupDetailContract({Key? key}) : super(key: key);

  @override
  _PopupDetailContractState createState() => _PopupDetailContractState();
}

class _PopupDetailContractState extends State<PopupDetailContract> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: yrColor1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.h)),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 50.h),
      contentPadding: EdgeInsets.zero,
      title: Container(
        alignment: Alignment.center,
        child: Text("CHI TIẾT HỢP ĐỒNG", style: kText16Bold_3,),
      ),
      content: Column(
        children: [],
      ),
      buttonPadding: EdgeInsets.zero,
      actions: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            height: 55.h,
            decoration: BoxDecoration(
                color: yrColor4, borderRadius: BorderRadius.circular(15.h)),
            alignment: Alignment.center,
            child: Text(
              "ĐÓNG",
              style: kText16Bold_1,
            ),
          ),
        )
      ],
    );
  }
}
