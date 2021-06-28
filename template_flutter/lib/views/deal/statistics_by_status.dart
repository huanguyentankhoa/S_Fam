import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class StatisticsByStatus extends StatefulWidget {
  const StatisticsByStatus({Key? key}) : super(key: key);

  @override
  _StatisticsByStatusState createState() => _StatisticsByStatusState();
}

class _StatisticsByStatusState extends State<StatisticsByStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Text("Khởi tạo Deal",style: kText10Bold_4,),
              SizedBox(
                height: 8.h,
              ),
              Container(
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                  color: yrColor4,
                  shape: BoxShape.circle
                ),
                alignment: Alignment.center,
                child: Text("2",style: kText20_1,),
              )
            ],
          )),
          Expanded(
              child: Column(
                children: [
                  Text("Chốt Deal đầu tư",style: kText10Bold_4,),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                        color: yrColor4,
                        shape: BoxShape.circle
                    ),
                    alignment: Alignment.center,
                    child: Text("3",style: kText20_1,),
                  )
                ],
              )),
          Expanded(
              child: Column(
                children: [
                  Text("Đầu tư",style: kText10Bold_4,),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                        color: yrColor4,
                        shape: BoxShape.circle
                    ),
                    alignment: Alignment.center,
                    child: Text("2",style: kText20_1,),
                  )
                ],
              )),
          Expanded(
              child: Column(
                children: [
                  Text("Hoàn tất",style: kText10Bold_4,),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                        color: yrColor4,
                        shape: BoxShape.circle
                    ),
                    alignment: Alignment.center,
                    child: Text("1",style: kText20_1,),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
