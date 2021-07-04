import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';
import 'package:s_fam/models/event.dart';
import 'package:s_fam/models/member.dart';
import 'package:s_fam/models/work.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/home/item.dart';
import 'package:s_fam/views/menu.dart';
import 'package:s_fam/views/notification/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();

  late UserProvider user;
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
     if(mounted)
       setState(() {
         isLoading = false;
       });
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            _key.currentState!.openDrawer();
          },
          child: Container(
            child: Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        title: Container(
          height: 48,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 60),
          child: Row(
            children: [
              Container(
                height: 48,
                width: 24,
                child: Image.asset(
                  "assets/icons/logo.png",
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                "-Fam",
                style: kText20BlueBold,
              )
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
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
                        border: Border.all(color: Colors.black),),
                    child: Icon(
                      Icons.notifications_none,
                      size: 20,
                      color: Colors.black,
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
                    "0",
                    style: kText10White,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Menu(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            children: [
              Container(
                height: 165,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Thành viên gia đình",
                        style: kSubText18BlackBold,
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    if (user.groupOfUser != null)
                      Container(
                        height: 110,
                        child: ListView.builder(
                            itemCount: user.groupOfUser!.listMembers.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              Member member =
                                  user.groupOfUser!.listMembers[index];
                              return Container(
                                margin: EdgeInsets.only(right: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: primaryMain),
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: member.avatarUrl != null &&
                                                member.avatarUrl != ""
                                            ? Tools().getImage(
                                                "https://testfam.herokuapp.com/api/v1/image/${member.email}/avt/download")
                                            : Image.asset(
                                                "assets/icons/logo.png",
                                                fit: BoxFit.contain,
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      member.id == user.userCurrentLogin.id ? "Tôi" : member.name!,
                                      style: kSubText14Black,
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                  ],
                ),
              ),
              Container(
                height: 260,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Công việc",
                          style: kSubText18BlackBold,
                        ),
                        if (user.listWork.length > 2)
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Xem thêm",
                              style: kSubText12Black,
                            ),
                          )
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    if (isLoading)
                      Container(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    if (!isLoading)
                      user.listWork.length <= 0
                          ? Container(
                              child: Text(
                                "Không có công việc nào!",
                                style: kSubText16BlackBold,
                              ),
                            )
                          : Container(
                              height: 220,
                              child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: user.listWork.length > 2
                                      ? 2
                                      : user.listWork.length,
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      child: Divider(
                                        height: 1,
                                        color: textSecondary,
                                      ),
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    Work work = user.listWork[index];
                                    return Container(
                                      margin:
                                          EdgeInsets.only(top: 8, bottom: 8),
                                      child: Item(
                                        name: work.name,
                                        date: work.startDay,
                                        time: work.startTime,
                                        sub: work.detail,
                                      ),
                                    );
                                  }),
                            )
                  ],
                ),
              ),
              Container(
                height: 260,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sự kiện",
                          style: kSubText18BlackBold,
                        ),
                        if (user.listEvent.length > 2)
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Xem thêm",
                              style: kSubText12Black,
                            ),
                          )
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    if (isLoading)
                      Container(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    if (!isLoading)
                      user.listEvent.length <= 0
                          ? Container(
                              child: Text(
                                "Không có sự kiện nào!",
                                style: kSubText16BlackBold,
                              ),
                            )
                          : Container(
                              height: 220,
                              child: ListView.separated(
                                  itemCount: user.listEvent.length > 2
                                      ? 2
                                      : user.listEvent.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      child: Divider(
                                        height: 1,
                                        color: textSecondary,
                                      ),
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    EventModel event = user.listEvent[index];
                                    return Container(
                                      margin:
                                          EdgeInsets.only(top: 8, bottom: 8),
                                      child: Item(
                                        name: event.name,
                                        date: event.date,
                                        time: event.startTime,
                                        sub: event.detail,
                                      ),
                                    );
                                  }),
                            )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
