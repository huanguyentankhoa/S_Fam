import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget timelineStartBuild(String time, String event) {
  return Container(
    height: 45.h,
    child: Row(
      children: [
        Container(
          height: 45.h,
          padding: EdgeInsets.only(top: 5),
          margin: EdgeInsets.only(right: 5),
          child: Text(
            time,
            style: kText8_13,
          ),
        ),
        Container(
          width: 20.w,
          height: 45.h,
          child: Column(
            children: [
              Container(
                height: 20.h,
                width: 20.h,
                decoration: BoxDecoration(
                  color: yrColor13,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                  child: Container(
                    width: 1,
                    color: yrColor4,
                  ))
            ],
          ),
        ),
        Container(
          height: 45.h,
          padding: EdgeInsets.only(top: 5),
          margin: EdgeInsets.only(left: 5),
          child: Text(
            event,
            style: kText8_13,
          ),
        )
      ],
    ),
  );
}

Widget timelineBuild(String time, String event) {
  return Container(
    height: 45.h,
    child: Row(
      children: [
        Container(
          height: 45.h,
          padding: EdgeInsets.only(top: 5),
          margin: EdgeInsets.only(right: 5),
          child: Text(
            time,
            style: kText8_4,
          ),
        ),
        Container(
          width: 20.w,
          height: 45.h,
          child: Column(
            children: [
              Container(
                height: 20.h,
                width: 20.h,
                decoration: BoxDecoration(
                  color: yrColor4,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                  child: Container(
                    width: 1,
                    color: yrColor4,
                  ))
            ],
          ),
        ),
        Container(
          height: 45.h,
          padding: EdgeInsets.only(top: 5),
          margin: EdgeInsets.only(left: 5),
          child: Text(
            event,
            style: kText8_4,
          ),
        )
      ],
    ),
  );
}

Widget timelineEndBuild(String time, String event) {
  return Container(
    height: 20.h,
    child: Row(
      children: [
        Container(
          height: 20.h,
          padding: EdgeInsets.only(top: 5),
          margin: EdgeInsets.only(right: 5),
          child: Text(
            time,
            style: kText8_4,
          ),
        ),
        Container(
          width: 20.w,
          height: 20.h,
          child: Column(
            children: [
              Container(
                height: 20.h,
                width: 20.h,
                decoration: BoxDecoration(
                  color: yrColor4,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 45.h,
          padding: EdgeInsets.only(top: 5),
          margin: EdgeInsets.only(left: 5),
          child: Text(
            event,
            style: kText8_4,
          ),
        )
      ],
    ),
  );
}