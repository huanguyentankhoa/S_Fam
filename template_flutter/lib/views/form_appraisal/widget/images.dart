import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Images extends StatefulWidget {
  const Images({Key? key}) : super(key: key);

  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  List<Widget> listImage = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          InkWell(
            onTap: () {
              listImage
                  .add(_itemImageBuild("Hình ảnh ${listImage.length + 1}"));
              setState(() {});
            },
            child: Container(
              height: 122.h,
              width: 92.w,
              decoration: BoxDecoration(
                color: yrColor9,
                borderRadius: BorderRadius.circular(10.h),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline_outlined,
                    size: 40.h,
                    color: yrColor1,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                      width: 73.w,
                      child: Text(
                        "Chụp/ Upload hình ảnh",
                        style: kText10_1,
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
          ),
          SizedBox(width: 5.w,),
          ...listImage,
        ],
      ),
    );
  }

  _itemImageBuild(link) {
    return Container(
      height: 122.h,
      width: 92.w,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        color: yrColor9,
        borderRadius: BorderRadius.circular(10.h),
      ),
      alignment: Alignment.center,
      child: Text(
        link,
        style: kText10_2,
      ),
    );
  }
}
