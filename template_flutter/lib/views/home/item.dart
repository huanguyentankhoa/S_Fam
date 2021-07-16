import 'package:flutter/material.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';

class Item extends StatelessWidget {
  final String? date;
  final String? time;
  final String? name;
  final String? sub;

  const Item({Key? key, this.name, this.date, this.time, this.sub})
      : super(key: key);

  // _isToday(date) {
  //   var today = Tools().getDate(DateTime.now().toString());
  //   var d = Tools().getDate(date);
  //   if (d == today) return true;
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${date != null ? Tools().getTime(date!) : ""} - ${date != null ? Tools().getDate("$date") : ""}",
            //dateTime.toString(),
            //style: _isToday(dateTime) ? kText14Red : kSubText14Black,
            style: kSubText14Black,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            name == null ? "" : name!,
            style: kText14BlackBold,
          ),
          SizedBox(
            height: 8,
          ),
          Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Text(
                sub == null ? "" : sub!,
                style: kSubText14Black,
              )),
        ],
      ),
    );
  }
}
