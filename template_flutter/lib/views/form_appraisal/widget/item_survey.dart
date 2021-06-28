import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemSurvey extends StatefulWidget {
  final String nameSurvey;
  final double? heightName;

  const ItemSurvey({Key? key, required this.nameSurvey, this.heightName})
      : super(key: key);

  @override
  _ItemSurveyState createState() => _ItemSurveyState();
}

class _ItemSurveyState extends State<ItemSurvey> {
  List<Widget> listItemCompare = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: widget.heightName ?? 20.h,
                width: 130.w,
                color: yrColor1,
                alignment: Alignment.center,
                child: Text(
                  widget.nameSurvey,
                  style: kText12_4,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 3.w),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Text(
                      "BĐS thẩm định: ",
                      style: kText12_2,
                    ),
                    Container(
                      height: 20.h,
                      width: 157.w,
                      padding: EdgeInsets.only(bottom: 4),
                      child: TextFormField(
                        style: kText12_2,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          ...listItemCompare,
          InkWell(
            onTap: () {
              listItemCompare.add(
                _itemCompareBuild(
                    "BĐS so sánh ${listItemCompare.length + 1}", "15,000,000"),
              );
              setState(() {});
            },
            child: Container(
              height: 13.h,
              width: 68.w,
              color: yrColor9,
              child: Row(
                children: [
                  Icon(
                    Icons.add_circle_outline_outlined,
                    color: yrColor1,
                    size: 10,
                  ),
                  Text(
                    "BĐS so sánh",
                    style: kText10_1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _itemCompareBuild(name, price) {
    return Container(
      height: 20.h,
      child: Row(
        children: [
          Container(
            height: 20.h,
            width: 130.w,
            color: yrColor19,
            alignment: Alignment.center,
            child: Text(
              name,
              style: kText14_2,
            ),
          ),
          Expanded(
            child: Container(
              color: yrColor7,
              height: 20.h,
              alignment: Alignment.center,
              child: Text(
                price,
                style: kText14_2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
