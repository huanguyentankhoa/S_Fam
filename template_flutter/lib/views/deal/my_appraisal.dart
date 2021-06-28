import 'package:flutter/material.dart';

import 'item_my_deal.dart';
class MyAppraisal extends StatefulWidget {
  const MyAppraisal({Key? key}) : super(key: key);

  @override
  _MyAppraisalState createState() => _MyAppraisalState();
}

class _MyAppraisalState extends State<MyAppraisal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemMyDeal(),
        ItemMyDeal(),
        ItemMyDeal(),
      ],
    );
  }
}
