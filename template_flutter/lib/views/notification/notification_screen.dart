import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/views/home/item.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  List<Map<String, dynamic>> listNotification = [
    {
      "id": 1,
      "name": "Đóng tiền điện",
      "date": "2021-04-16T09:44:50.784987",
      "sub": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "id": 2,
      "name": "Đưa cả nhà đi công viên chơi cuối tuần",
      "date": "2021-04-16T09:44:50.784987",
      "sub": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "id": 1,
      "name": "Đón con",
      "date": "2021-05-16T09:44:50.784987",
      "sub": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "id": 2,
      "name": "Gặp khách hàng",
      "date": "2021-04-16T09:44:50.784987",
      "sub": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _appBarBuild(),

            Expanded(
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listNotification.length,
                  separatorBuilder: (context, index) {
                    return Container(
                      child: Divider(
                        height: 1,
                        color: textSecondary,
                      ),
                    );
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Item(
                        name: listNotification[index]["name"],
                        date: listNotification[index]["date"],
                        time:listNotification[index]["date"],
                        sub: listNotification[index]["sub"],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
  Widget _appBarBuild() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 80,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left: 16),
            child: Row(
              children: [
               SvgPicture.asset("assets/icons/back.svg",color: Colors.black,),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Thông báo",
                  style: kText20BlackBold,
                )
              ],
            ),
          ),
        ),

      ],
    );
  }
}



