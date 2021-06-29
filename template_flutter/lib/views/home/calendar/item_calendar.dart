import 'package:flutter/material.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';

class ItemCalendar extends StatelessWidget {
  final String? time;
  final String? name;
  final String? sub;

  const ItemCalendar({
    Key? key,
    @required this.name,
    @required this.time,
    @required this.sub,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Container(
              height: 32,
              width: 32,
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border.all(color: primaryMain),
                shape: BoxShape.circle,
              ),
              child: Image.asset("assets/images/Ellipse10.png",fit: BoxFit.fill,),
            ),
          ),
          SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                width: MediaQuery.of(context).size.width-90,
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
