import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/views/deal/item_my_deal.dart';
class MyDeal extends StatefulWidget {
  const MyDeal({Key? key}) : super(key: key);

  @override
  _MyDealState createState() => _MyDealState();
}

class _MyDealState extends State<MyDeal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemMyDeal(),
        ItemMyDeal(),
        ItemMyDeal(),
        ItemMyDeal(),
        ItemMyDeal(),
        ItemMyDeal(),
      ],
    );
  }
}
