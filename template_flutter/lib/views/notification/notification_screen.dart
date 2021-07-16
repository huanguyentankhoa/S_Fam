import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/services/services_api.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/home/item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  late UserProvider user;
  APIServices _services = APIServices();
  List<Map<String, dynamic>>? listNotification = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    listNotification =
    await Provider.of<UserProvider>(context,listen: false).getListNotification();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appBarBuild(),

            listNotification!=null&&listNotification!.length>0? Expanded(
              child: ListView.separated(
                  itemCount:listNotification!.length,
                  separatorBuilder: (context, index) {
                    return Container(
                      child: Divider(
                        height: 1,
                        color: textSecondary,
                      ),
                    );
                  },
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = listNotification![index];
                    return Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Item(
                        name: item["title"],
                        date: item["day"],
                        sub: item["message"],
                      ),
                    );
                  }),
            ):
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                "Không có thông báo mới!",
                style: kSubText16BlackBold,
              ),
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
                SvgPicture.asset(
                  "assets/icons/back.svg",
                  color: Colors.black,
                ),
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
