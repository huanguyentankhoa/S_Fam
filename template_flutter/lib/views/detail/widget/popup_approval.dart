import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Approval extends StatelessWidget {
  const Approval({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: yrColor4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.h)),
      insetPadding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: 150.h,
        alignment: Alignment.center,
        child: Text(
          "Chuyển quyền Leader của bạn đã thành công. "
              "Vui lòng thông báo cho thành viên trong nhóm để đề cử leader mới.",
          style: kText16_1,
          textAlign: TextAlign.center,
        ),
      ),
      buttonPadding: EdgeInsets.zero,
      actions: [
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 55.h,
            decoration: BoxDecoration(
                color: yrColor1,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.h),
                    bottomRight: Radius.circular(15.h)
                )
            ),
            alignment: Alignment.center,
            child: Text("Đóng",style: kText16_3,),
          ),
        )
      ],
    );
  }
}
