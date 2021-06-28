import 'package:flutter/material.dart';
import 'package:youreal/generated/i10n.dart';

import 'config/color_config.dart';
import 'config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Utils {
  static Function getLanguagesList = ([context]) {
    return [
      {
        "name": context != null ? S.of(context)!.english : "English",
        "icon": "",
        "code": "en",
        "text": "English",
        "storeViewCode": ""
      },
      {
        "name": context != null ? S.of(context)!.vietnamese : "Vietnam",
        "icon": "",
        "code": "vi",
        "text": "Vietnam",
        "storeViewCode": ""
      },
    ];
  };
}

Widget TextInput(
    {required String name,
    TextStyle? nameStyle,
      Alignment? nameAlign,
    double? width,
    Widget? input,
    String? sub,
    TextStyle? subStyle,}) {
  return Row(
    children: [
      Container(
        width: 78.h,
        alignment: nameAlign??Alignment.centerRight,
        child: Text(
          name,
          style: nameStyle??kText14_2,
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Container(
          height: 20.h, width: width ?? 54.w, color: yrColor17, child: input),
      Text(
        sub ?? "",
        style: subStyle??kText14_2,
      ),
    ],
  );
}

Widget getImage(String link, {BoxFit? fit}) {
  if (link.contains('http://') || link.contains('https://')) {
    return Image.network(
      link,
      fit: fit,
    );
  }
  return Image.asset(
    "assets/images/$link",
    fit: fit,
  );
}

String getIcon(link) {
  return "assets/icons/$link";
}
