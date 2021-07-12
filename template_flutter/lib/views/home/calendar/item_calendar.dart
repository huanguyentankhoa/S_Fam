import 'package:flutter/material.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';

class ItemCalendar extends StatelessWidget {
  final String? time;
  final String? name;
  final String? sub;
  final String avtOwner;

  const ItemCalendar(
      {Key? key,
      @required this.name,
      @required this.time,
      @required this.sub,
      required this.avtOwner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 32,
            width: 32,
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              border: Border.all(color: primaryMain),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: avtOwner == ""
                  ? Image.asset(
                "assets/images/appicon.png",
                fit: BoxFit.fill,
              )
                  : Tools().getImage(avtOwner),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name == null ? "" : name!,
                      style: kText14BlackBold,
                    ),
                    Text(
                      time == null ? "" : time!,
                      style: kText14Green,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                  width: MediaQuery.of(context).size.width - 80,
                  child: Text(
                    sub == null ? "" : sub!,
                    style: kSubText14Black,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
