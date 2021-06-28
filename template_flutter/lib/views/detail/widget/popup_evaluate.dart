import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Evaluate extends StatefulWidget {
  const Evaluate({Key? key}) : super(key: key);

  @override
  _EvaluateState createState() => _EvaluateState();
}

class _EvaluateState extends State<Evaluate> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: yrColor4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.h)),
      insetPadding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
      ),
      title: Container(
        alignment: Alignment.center,
        child: Text(
          "ĐÁNH GIÁ NGƯỜI BÁN",
          style: kText16_1,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: 150.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              unratedColor: yrColor17,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: yrColor1,
              ),
              onRatingUpdate: (rating) {

              },
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: yrColor1,
                      ),
                    ),
                   ),
              ),

            )
          ],
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            height: 55.h,
            decoration: BoxDecoration(
                color: yrColor1, borderRadius: BorderRadius.circular(15.h)),
            alignment: Alignment.center,
            child: Text(
              "Gửi",
              style: kText16_3,
            ),
          ),
        )
      ],
    );
  }
}
