import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeLeader extends StatelessWidget {
  const ChangeLeader({Key? key}) : super(key: key);

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
        height: 95.h,
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        alignment: Alignment.center,
        child: Text(
          "Bạn muốn chuyển quyền Leader cho người khác trong nhóm không?",
          textAlign: TextAlign.center,
          style: kText16_1,
        ),
      ),
      buttonPadding: EdgeInsets.zero,

      actions: [
        Container(

          child: Row(
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context,false);
                },
                child: Container(
                  height: 55.h,
                  width: MediaQuery.of(context).size.width/2-20.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: yrColor8,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.h)
                      )
                  ),
                  child: Text(
                    "Không",
                    style: kText16Bold_1,
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context,true);
                },
                child: Container(
                  height: 55.h,
                  width: MediaQuery.of(context).size.width/2-20.w,
                  decoration: BoxDecoration(
                      color: yrColor1,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.h)
                    )
                  ),
                  alignment: Alignment.center,

                  child: Text(
                    "Có",
                    style: kText16Bold_3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
