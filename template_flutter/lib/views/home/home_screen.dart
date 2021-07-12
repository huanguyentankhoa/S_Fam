import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/config.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';
import 'package:s_fam/models/event.dart';
import 'package:s_fam/models/group.dart';
import 'package:s_fam/models/member.dart';
import 'package:s_fam/models/work.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/home/item.dart';
import 'package:s_fam/views/home/list_event_screen.dart';
import 'package:s_fam/views/menu.dart';
import 'package:s_fam/views/notification/notification_screen.dart';

import 'list_work_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();

  late UserProvider user;
  bool isLoading = true;

  Group? _group;
  List<Work>? _works;
  List<EventModel>? _events;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Provider.of<UserProvider>(context, listen: false)
        .getDataMyGroup()
        .then((value) {
      setState(() {
        _group = value;
      });
    });

    _works =
        await Provider.of<UserProvider>(context, listen: false).getListWork();

    _events =
        await Provider.of<UserProvider>(context, listen: false).getListEvent();

    setState(() {});
  }

  Widget showListMember(List<Member> members) {
    return Container(
      height: 110,
      child: ListView.builder(
          itemCount: members.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Member member = members[index];
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
                      child: member.avatarUrl != null && member.avatarUrl != ""
                          ? Tools().getImage("${serverConfig["url"]}" +
                          "api/v1/image/download?path=${member.email}&name=${member.avatarUrl}")
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
                    member.id == user.userCurrentLogin.id
                        ? "Tôi"
                        : member.name!,
                    style: kSubText14Black,
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget showListWork(List<Work> works) {
    return Container(
      height: 220,
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemCount: works.length > 2 ? 2 : works.length,
          separatorBuilder: (context, index) {
            return Container(
              child: Divider(
                height: 1,
                color: textSecondary,
              ),
            );
          },
          itemBuilder: (context, index) {
            Work work = works[index];
            return Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: Item(
                name: work.name,
                date: work.startDay,
                time: work.startTime,
                sub: work.detail,
              ),
            );
          }),
    );
  }

  Widget showListEvent(List<EventModel> events) {
    return Container(
      height: 220,
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemCount: events.length > 2 ? 2 : events.length,
          separatorBuilder: (context, index) {
            return Container(
              child: Divider(
                height: 1,
                color: textSecondary,
              ),
            );
          },
          itemBuilder: (context, index) {
            EventModel event = events[index];
            return Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: Item(
                name: event.name,
                date: event.date,
                time: event.startTime,
                sub: event.detail,
              ),
            );
          }),
    );
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
          // Container(
          //   height: 50,
          //   width: 50,
          //   margin: EdgeInsets.only(right: 15),
          //   child: Stack(
          //     alignment: AlignmentDirectional.topEnd,
          //     children: [
          //       GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => NotificationScreen(),
          //             ),
          //           );
          //         },
          //         child: Container(
          //           height: 40,
          //           width: 40,
          //           alignment: Alignment.center,
          //           margin: EdgeInsets.only(right: 5, top: 5),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(8),
          //             border: Border.all(color: Colors.black),
          //           ),
          //           child: Icon(
          //             Icons.notifications_none,
          //             size: 20,
          //             color: Colors.black,
          //           ),
          //         ),
          //       ),
          //       Container(
          //         height: 15,
          //         width: 15,
          //         alignment: Alignment.center,
          //         decoration:
          //             BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          //         child: Text(
          //           "0",
          //           style: kText10White,
          //         ),
          //       )
          //     ],
          //   ),
          // )
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
                    FutureBuilder(
                        future: user.getDataMyGroup(),
                        initialData: _group,
                        builder: (BuildContext context,
                            AsyncSnapshot<Group?> snapshot) {
                          if (snapshot.hasData)
                            return showListMember(snapshot.data!.listMembers);
                          else if (snapshot.hasError)
                            return Container();
                          else if (_group != null &&
                              _group!.listMembers.length > 0)
                            return showListMember(_group!.listMembers);
                          else
                            return CircularProgressIndicator();
                        }),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListWorkScreen(works: user.listWork,),
                                ),
                              );
                            },
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
                    FutureBuilder(
                        future: user.getListWork(),
                        initialData: _works,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Work>?> snapshot) {
                          if (snapshot.hasData) if (snapshot.data!.length > 0)
                            return showListWork(snapshot.data!);
                          else
                            return Container(
                              child: Text(
                                "Không có công việc nào!",
                                style: kSubText16BlackBold,
                              ),
                            );
                          else if (snapshot.hasError)
                            return Container(
                              child: Text(
                                "Không có công việc nào!",
                                style: kSubText16BlackBold,
                              ),
                            );
                          else if (_works != null)
                            if(_works!.length>0)
                            return showListWork(_works!);
                            else{
                              return Container(
                                child: Text(
                                  "Không có công việc nào!",
                                  style: kSubText16BlackBold,
                                ),
                              );
                            }
                          else
                            return CircularProgressIndicator();
                        }),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListEventScreen(events: user.listEvent,),
                                ),
                              );
                            },
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
                    FutureBuilder(
                        future: user.getListEvent(),
                        initialData: _events,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<EventModel>?> snapshot) {
                          if (snapshot.hasData) if (snapshot.data!.length > 0)
                            return showListEvent(snapshot.data!);
                          else
                            return Container(
                              child: Text(
                                "Không có sự kiện nào!",
                                style: kSubText16BlackBold,
                              ),
                            );
                          else if (snapshot.hasError)
                            return Container(
                              child: Text(
                                "Không có sự kiện nào!",
                                style: kSubText16BlackBold,
                              ),
                            );
                          else if (_events != null)
                            if(_events!.length>0)
                              return showListEvent(_events!);
                            else{
                              return Container(
                                child: Text(
                                  "Không có sự kiện nào!",
                                  style: kSubText16BlackBold,
                                ),
                              );
                            }
                          else
                            return CircularProgressIndicator();
                        }),
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
