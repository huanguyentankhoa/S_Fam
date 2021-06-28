import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/model/news.dart';

class NewsItem extends StatefulWidget {
  final News news;
  const NewsItem({Key? key,required this.news}) : super(key: key);

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: yrColor4
          )
        )
      ),
      child: Row(
        children: [
          Container(
            height: 70.h,
            width: 80.w,
            alignment: Alignment.centerLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.h),
              child: Container(
                height: 55.h,
                width: 60.h,
                child:
                    getImage(widget.news.image, fit: BoxFit.fill),
              ),
            ),
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Container(
                  child: Text(widget.news.name,style: kText10Bold_11,),
                ),
                Container(
                  child: Text(widget.news.content,style: kText14_4,),
                ),
                Container(
                  child: Text(widget.news.createDate,style: kText12Italic_4,),
                ),
            ],
          ),
              ),),
          Container(
          child: Icon(Icons.ios_share,size: 20.h,color: yrColor4,),
          )
        ],
      ),
    );
  }
}
