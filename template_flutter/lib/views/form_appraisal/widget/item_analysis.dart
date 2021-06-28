import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemAnalysis extends StatefulWidget {
  final String nameAnalysis;
  final String nameItem;
  const ItemAnalysis({Key? key, required this.nameAnalysis, required this.nameItem}) : super(key: key);

  @override
  _ItemAnalysisState createState() => _ItemAnalysisState();
}

class _ItemAnalysisState extends State<ItemAnalysis> {
  List<Widget> listItemAnalysis = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 8.w),
      height: 52.h,
      child: Row(
        children: [
          Container(
            height: 52.h,
            width: 90.w,
            color: yrColor1,
            padding: EdgeInsets.only(left: 3),
            alignment: Alignment.centerLeft,
            child: Text(widget.nameAnalysis,style: kText12_4,),
          ),
          Container(
            height: 52.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 3.w),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        "${widget.nameItem} 1: ",
                        style: kText12_2,
                      ),
                      Container(
                        height: 17.h,
                        width: 168.w,
                        padding: EdgeInsets.only(bottom: 4),
                        child: TextFormField(
                          style: kText12_2,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 3.w),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        "${widget.nameItem} 2: ",
                        style: kText12_2,
                      ),
                      Container(
                        height: 17.h,
                        width: 168.w,
                        padding: EdgeInsets.only(bottom: 4),
                        child: TextFormField(
                          style: kText12_2,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 3.w),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        "${widget.nameItem} 3: ",
                        style: kText12_2,
                      ),
                      Container(
                        height: 17.h,
                        width: 168.w,
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
          )
        ],
      ),
    );
  }
}

