import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ItemMyDeal extends StatelessWidget {
  const ItemMyDeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77.h,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: yrColor4,
        borderRadius: BorderRadius.circular(15.h)
      ),
      child: Row(
        children: [
          Expanded(child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nhà riêng",style: kText14Bold_2,),
                Text("Ông Nguyễn Văn A",style: kText14_2,),
                Text("184/20 Thảo Điền, Q.2 , TP. Hồ Chí Minh ",style: kText12_2,),
              ],
            ),
          ),),
          Container(
            width: 110.w,
            padding: EdgeInsets.only(right: 8.w),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Text("10/05/2021",style: kText10_7,),
                ),
                SizedBox(height: 8.h,),
                Container(
                  alignment: Alignment.center,
                  child: Text("Khởi tạo Deal",style: kText14_1,),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
