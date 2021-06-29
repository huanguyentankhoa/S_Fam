import 'package:flutter/material.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/views/notification/notification_screen.dart';

class AppBarHome extends StatefulWidget implements PreferredSizeWidget {
  @override
  _AppBarHomeState createState() => _AppBarHomeState();

  @override
  Size get preferredSize {
    return new Size.fromHeight(110.0);
  }
}

class _AppBarHomeState extends State<AppBarHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, bottom: 10),
      alignment: AlignmentDirectional.bottomStart,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipOval(
            child: Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Color(0xFFD6C3F6),),
              child: Text("PT",style: kText16White,),
            ),
          ),
          Expanded(
            child: Container(
              height: 45,
              margin: EdgeInsets.only(left: 10),
              alignment: AlignmentDirectional.centerStart,
              padding: EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "16 Apr,2021",
                    style: kSubText14Black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Nguyễn Phương Tính",
                    style: kText16BlackBold,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(right: 15),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 5, top: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black)),
                    child: Icon(
                      Icons.notifications_none,
                      size: 20,
                    ),
                  ),
                ),
                Container(
                  height: 15,
                  width: 15,
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Text(
                    "2",
                    style: kText10White,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
