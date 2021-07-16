import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/config.dart';
import 'package:s_fam/common/constants/colors_config.dart';

import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';
import 'package:s_fam/models/event.dart';
import 'package:s_fam/models/group.dart';
import 'package:s_fam/models/work.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/home/calendar/create_event_person/create_event_person.dart';
import 'package:s_fam/views/home/calendar/item_calendar.dart';
import '../../menu.dart';
import 'create_event/create_event_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> with AfterLayoutMixin {
  String kind = "Chung";
  DateTime _currentDate = DateTime.now();
  GlobalKey<ScaffoldState> _key = GlobalKey();
  List<String> listKind = ["Chung"];
  late UserProvider user;
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
  List<EventModel> _listEvent = [];
  List<Work> _listWork = [];
  List<Widget> listWorkBuild = [];
  List<Widget> listEventBuild = [];
  bool isLoading = true;
  Group? group;
  bool isLoadingData = false;

  @override
  void initState() {
    super.initState();
    loadInit();
  }

  loadInit() async {
    group = await Provider.of<UserProvider>(context, listen: false)
        .getDataMyGroup();
    if (group != null) {
      group!.listMembers.forEach((element) {
        if (element.name == user.userCurrentLogin.name) {
          listKind.add("Cá nhân");
        } else {
          listKind.add(element.name!);
        }
      });
    }
    setState(() {});
  }

  listenData() async {
    var g = await user.getDataMyGroup();
    setState(() {
      group = g;
    });
    if (kind == "Chung") {
      var e = await user.getListEvent();
      var w = await user.getListWork();
      setState(() {
        _listEvent = e!;
        _listWork = w!;
      });
    } else {
      group!.listMembers.forEach((element) async {
        if (kind == "Cá nhân") {
          var e = await user.getListEventByEmail(user.userCurrentLogin.email!);
          var w = await user.getListWorkByEmail(user.userCurrentLogin.email!);
          setState(() {
            _listEvent = e!;
            _listWork = w!;
          });
        } else if (element.name! == kind) {
          var e = await user.getListEventByEmail(element.email!);
          var w = await user.getListWorkByEmail(element.email!);
          setState(() {
            _listEvent = e!;
            _listWork = w!;
          });
        }
      });
    }

    getMarked(_listWork, _listEvent);
    getWorkByDate(_listWork);
    getEventByDate(_listEvent);
  }

  List<int> getListRepeat(List<String> list) {
    List<int> repeat = [];
    list.forEach((element) {
      switch (element) {
        case "NONE":
          repeat.add(0);
          break;
        case "MONDAY":
          repeat.add(1);
          break;
        case "TUESDAY":
          repeat.add(2);
          break;
        case "WEDNESDAY":
          repeat.add(3);
          break;
        case "THURSDAY":
          repeat.add(4);
          break;
        case "FRIDAY":
          repeat.add(5);
          break;
        case "SATURDAY":
          repeat.add(6);
          break;
        case "SUNDAY":
          repeat.add(7);
          break;
        default:
          repeat.add(0);
          break;
      }
    });
    return repeat;
  }

  Event itemWorkMarkedBuild(DateTime dt) {
    return Event(
      date: DateTime(dt.year, dt.month, dt.day),
      dot: Container(
        color: Colors.white,
        width: 40,
        padding: EdgeInsets.only(top: 1),
        child: Center(
          child: Text(
            dt.day.toString(),
            style: kText14Blue,
          ),
        ),
      ),
    );
  }
  EventList<Event> markEvent = new EventList<Event>(events: {});
  getMarked(List<Work> works, List<EventModel> events) {
    _markedDateMap.clear();

    works.forEach((item) {});
    for (int a = 0; a < works.length; a++) {
      Work item = works[a];
      DateTime dtStart = DateTime.parse(item.startDay);
      DateTime dtEnd = DateTime.parse(item.endDay);
      List<int> repeat = getListRepeat(item.repeatType);
      if (dtStart.month == dtEnd.month) {
        for (int i = 0; i <= (dtEnd.day - dtStart.day); i++) {
          DateTime dt = DateTime(dtStart.year, dtStart.month, dtStart.day + i);
          if (_markedDateMap.getEvents(dt).isEmpty) if (repeat.first == 0) {
            _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
          } else {
            if (repeat.indexOf(dt.weekday) != -1) {
              _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
            }
          }
        }
      } else {
        for (int i = 0; i <= dtEnd.month - dtStart.month; i++) {
          if (i == 0) {
            if (dtStart.month + i == 1 ||
                dtStart.month + i == 3 ||
                dtStart.month + i == 5 ||
                dtStart.month + i == 7 ||
                dtStart.month + i == 8 ||
                dtStart.month + i == 10 ||
                dtStart.month + i == 12) {
              for (int j = 0; j <= (31 - dtStart.day); j++) {
                DateTime dt =
                    DateTime(dtStart.year, dtStart.month, dtStart.day + j);
                if (_markedDateMap.getEvents(dt).isEmpty) if (repeat.first ==
                    0) {
                  _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
                } else {
                  if (repeat.indexOf(dt.weekday) != -1) {
                    _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
                  }
                }
              }
            } else if (dtStart.month + i == 4 ||
                dtStart.month + i == 6 ||
                dtStart.month + i == 9 ||
                dtStart.month + i == 11) {
              for (int j = 0; j <= (30 - dtStart.day); j++) {
                DateTime dt =
                    DateTime(dtStart.year, dtStart.month, dtStart.day + j);
                if (_markedDateMap.getEvents(dt).isEmpty) if (repeat.first ==
                    0) {
                  _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
                } else {
                  if (repeat.indexOf(dt.weekday) != -1) {
                    _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
                  }
                }
              }
            } else {
              for (int j = 0; j <= (28 - dtStart.day); j++) {
                DateTime dt =
                    DateTime(dtStart.year, dtStart.month, dtStart.day + j);
                if (_markedDateMap.getEvents(dt).isEmpty) if (repeat.first ==
                    0) {
                  _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
                } else {
                  if (repeat.indexOf(dt.weekday) != -1) {
                    _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
                  }
                }
              }
            }
          } else if (i == dtEnd.month - dtStart.month) {
            for (int j = 0; j <= (dtEnd.day - 1); j++) {
              DateTime dt = DateTime(dtEnd.year, dtEnd.month, j + 1);
              if (_markedDateMap.getEvents(dt).isEmpty) if (repeat.first == 0) {
                _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
              } else {
                if (repeat.indexOf(dt.weekday) != -1) {
                  _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
                }
              }
            }
          } else {
            if (dtStart.month + i == 1 ||
                dtStart.month + i == 3 ||
                dtStart.month + i == 5 ||
                dtStart.month + i == 7 ||
                dtStart.month + i == 8 ||
                dtStart.month + i == 10 ||
                dtStart.month + i == 12) {
              for (int j = 0; j <= 31; j++) {
                DateTime dt = DateTime(dtStart.year, dtStart.month + i, j + 1);
                if (_markedDateMap.getEvents(dt).isEmpty) if (repeat.first ==
                    0) {
                  _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
                } else {
                  if (repeat.indexOf(dt.weekday) != -1) {
                    _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
                  }
                }
              }
            } else if (dtStart.month + i == 4 ||
                dtStart.month + i == 6 ||
                dtStart.month + i == 9 ||
                dtStart.month + i == 11) {
              for (int j = 0; j <= 30; j++) {
                DateTime dt = DateTime(dtStart.year, dtStart.month + i, j + 1);
                if (_markedDateMap.getEvents(dt).isEmpty) if (repeat.first ==
                    0) {
                  _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
                } else {
                  if (repeat.indexOf(dt.weekday) != -1) {
                    _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
                  }
                }
              }
            } else {
              for (int j = 0; j <= 28; j++) {
                DateTime dt = DateTime(dtStart.year, dtStart.month + i, j + 1);
                if (_markedDateMap.getEvents(dt).isEmpty) if (repeat.first ==
                    0) {
                  _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
                } else {
                  if (repeat.indexOf(dt.weekday) != -1) {
                    _markedDateMap.add(dt, itemWorkMarkedBuild(dt));
                  }
                }
              }
            }
          }
        }
      }
    }

    markEvent.clear();
    for (int i = 0; i < events.length; i++) {
      DateTime dt = DateTime.parse(events[i].date);
      if (markEvent.getEvents(DateTime(dt.year,dt.month,dt.day)).isEmpty) {
        _markedDateMap.add(
          DateTime(dt.year, dt.month, dt.day),
          Event(
            date: DateTime(dt.year, dt.month, dt.day),
            dot: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              decoration:
              BoxDecoration(color: primaryMain, shape: BoxShape.circle),
              height: 5.0,
              width: 5.0,
            ),
          ),
        );
        markEvent.add(
          DateTime(dt.year, dt.month, dt.day),
          Event(
            date: DateTime(dt.year, dt.month, dt.day),
            dot: Container()
          ),
        );

      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget itemWorkBuild(Work item) {
    return Column(
      children: [
        ItemCalendar(
          name: item.name,
          time: item.startTime,
          sub: item.detail,
          avtOwner: "${serverConfig["url"]}" +
              "api/v1/image/${user.userCurrentLogin.email}/avt/download",
        ),
        Container(
          child: Divider(
            height: 1,
            color: textSecondary,
          ),
        ),
      ],
    );
  }

  getWorkByDate(List<Work> works) {
    setState(() {
      isLoadingData = true;
    });
    List<Widget> listBuild = [];
    works.forEach((item) {
      DateTime dtStart = DateTime.parse(item.startDay);
      DateTime dtEnd = DateTime.parse(item.endDay);
      List<int> repeat = getListRepeat(item.repeatType);
      if (dtStart.month == dtEnd.month) {
        if (_currentDate.day >= dtStart.day && _currentDate.day <= dtEnd.day) {
          if (repeat.first == 0) {
            listBuild.add(itemWorkBuild(item));
          } else if (repeat.indexOf(_currentDate.weekday) != -1) {
            listBuild.add(itemWorkBuild(item));
          }
        }
      } else {
        for (int i = 0; i <= (dtEnd.month - dtStart.month); i++) {
          if (_currentDate.month == dtStart.month) {
            if (dtStart.month + i == 1 ||
                dtStart.month + i == 3 ||
                dtStart.month + i == 5 ||
                dtStart.month + i == 7 ||
                dtStart.month + i == 8 ||
                dtStart.month + i == 10 ||
                dtStart.month + i == 12) {
              if (_currentDate.day >= dtStart.day && _currentDate.day <= 31) {
                if (repeat.first == 0) {
                  listBuild.add(itemWorkBuild(item));
                } else if (repeat.indexOf(_currentDate.weekday) != -1) {
                  listBuild.add(itemWorkBuild(item));
                }
              }
            } else if (dtStart.month + i == 4 ||
                dtStart.month + i == 6 ||
                dtStart.month + i == 9 ||
                dtStart.month + i == 11) {
              if (_currentDate.day >= dtStart.day && _currentDate.day <= 30) {
                if (repeat.first == 0) {
                  listBuild.add(itemWorkBuild(item));
                } else if (repeat.indexOf(_currentDate.weekday) != -1) {
                  listBuild.add(itemWorkBuild(item));
                }
              }
            } else {
              if (_currentDate.day >= dtStart.day && _currentDate.day <= 28) {
                if (repeat.first == 0) {
                  listBuild.add(itemWorkBuild(item));
                } else if (repeat.indexOf(_currentDate.weekday) != -1) {
                  listBuild.add(itemWorkBuild(item));
                }
              }
            }
          } else if (_currentDate.month == dtEnd.month) {
            if (_currentDate.day >= 1 && _currentDate.day <= dtEnd.day) {
              if (repeat.first == 0) {
                listBuild.add(itemWorkBuild(item));
              } else if (repeat.indexOf(_currentDate.weekday) != -1) {
                listBuild.add(itemWorkBuild(item));
              }
            }
          } else {
            if (dtStart.month + i == 1 ||
                dtStart.month + i == 3 ||
                dtStart.month + i == 5 ||
                dtStart.month + i == 7 ||
                dtStart.month + i == 8 ||
                dtStart.month + i == 10 ||
                dtStart.month + i == 12) {
              if (_currentDate.day >= 1 && _currentDate.day <= 31) {
                if (repeat.first == 0) {
                  listBuild.add(itemWorkBuild(item));
                } else if (repeat.indexOf(_currentDate.weekday) != -1) {
                  listBuild.add(itemWorkBuild(item));
                }
              }
            } else if (dtStart.month + i == 4 ||
                dtStart.month + i == 6 ||
                dtStart.month + i == 9 ||
                dtStart.month + i == 11) {
              if (_currentDate.day >= 1 && _currentDate.day <= 30) {
                if (repeat.first == 0) {
                  listBuild.add(itemWorkBuild(item));
                } else if (repeat.indexOf(_currentDate.weekday) != -1) {
                  listBuild.add(itemWorkBuild(item));
                }
              }
            } else {
              if (_currentDate.day >= 1 && _currentDate.day <= 28) {
                if (repeat.first == 0) {
                  listBuild.add(itemWorkBuild(item));
                } else if (repeat.indexOf(_currentDate.weekday) != -1) {
                  listBuild.add(itemWorkBuild(item));
                }
              }
            }
          }
        }
      }
    });

    setState(() {
      listWorkBuild = listBuild;
      isLoadingData = false;
    });
  }

  getEventByDate(List<EventModel> events) {
    String _date1 = Tools().getDate(_currentDate.toString());
    List<Widget> listBuild = [];
    events.forEach((item) {
      String _date = Tools().getDate(item.date);
      if (_date == _date1) {
        listBuild.add(Column(
          children: [
            ItemCalendar(
              name: item.name,
              time: item.startTime,
              sub: item.detail,
              avtOwner: "",
            ),
            Container(
              child: Divider(
                height: 1,
                color: textSecondary,
              ),
            ),
          ],
        ));
      }
    });
    setState(() {
      listEventBuild = listBuild;
    });
  }

  getWorkByEmail(email) {
    user.getListWorkByEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);
    return FutureBuilder(
        future: listenData(),
        builder: (context, snapshot) {
          return Scaffold(
            key: _key,
            drawer: Menu(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 100,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Lịch",
                            style: kText24BlackBold,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          padding: EdgeInsets.only(left: 12, right: 12),
                          decoration: BoxDecoration(
                              border: Border.all(color: textSecondary),
                              borderRadius: BorderRadius.circular(8)),
                          child: DropdownButton<String>(
                            value: kind,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down),
                            style: kText16Black,
                            underline: Container(
                              height: 1,
                              color: Colors.white,
                            ),
                            onChanged: (value) {
                              setState(() {
                                kind = value!;
                              });
                              getMarked(user.listWork, user.listEvent);
                              getWorkByDate(user.listWork);
                              getEventByDate(user.listEvent);
                            },
                            items: listKind
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: CalendarCarousel<Event>(
                                onDayPressed:
                                    (DateTime date, List<Event> events) {
                                  this.setState(() => _currentDate = date);
                                  getWorkByDate(user.listWork);
                                  getEventByDate(user.listEvent);
                                },
                                customGridViewPhysics:
                                    NeverScrollableScrollPhysics(),
                                markedDatesMap: _markedDateMap,
                                markedDateIconMaxShown: 2,
                                markedDateCustomTextStyle: kText14Blue,
                                markedDateMoreCustomTextStyle: kText14Blue,
                                headerMargin: EdgeInsets.zero,
                                selectedDayButtonColor: primaryMain,
                                selectedDayBorderColor: primaryMain,
                                selectedDayTextStyle: kText14White,
                                weekendTextStyle: kText12black,
                                dayPadding: 1,
                                locale: "vi",
                                nextMonthDayBorderColor: textSecondary,
                                prevMonthDayBorderColor: textSecondary,
                                markedDateIconBorderColor: textSecondary,
                                thisMonthDayBorderColor: textSecondary,
                                weekFormat: false,
                                weekdayTextStyle: kText14Black,
                                height: 380.0,
                                selectedDateTime: _currentDate,
                                todayButtonColor: Colors.transparent,
                                todayBorderColor: textSecondary,
                                todayTextStyle: kText14Red,
                                daysHaveCircularBorder: false,
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  color: Color(0xFFE8EAED),
                                  child: Text(
                                    "Công việc",
                                    style: kText14Black,
                                  ),
                                ),
                                isLoadingData
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Column(
                                          children: [
                                            if (listWorkBuild.isEmpty)
                                              Container(
                                                height: 80,
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  "Không có công việc nào!",
                                                  style: kSubText14Black,
                                                ),
                                              ),
                                            ...listWorkBuild,
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  color: Color(0xFFE8EAED),
                                  child: Text(
                                    "Sự kiện",
                                    style: kText14Black,
                                  ),
                                ),
                                isLoadingData
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Column(
                                          children: [
                                            if (listEventBuild.isEmpty)
                                              Container(
                                                height: 80,
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  "Không có sự kiện nào!",
                                                  style: kSubText14Black,
                                                ),
                                              ),
                                            ...listEventBuild,
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 60,
                            ),
                          ],
                        )
                ],
              ),
            ),
            floatingActionButton: SpeedDial(
              marginEnd: 18,
              marginBottom: 20,
              icon: Icons.add,
              activeIcon: Icons.clear,
              buttonSize: 60.0,
              visible: true,
              closeManually: false,
              renderOverlay: false,
              curve: Curves.bounceIn,
              overlayColor: Colors.black,
              overlayOpacity: 0.5,
              backgroundColor: primaryMain,
              foregroundColor: Colors.white,
              elevation: 8.0,
              shape: CircleBorder(),
              children: [
                SpeedDialChild(
                  child: Icon(Icons.people),
                  backgroundColor: Colors.green,
                  labelBackgroundColor: Colors.white,
                  label: 'Chung',
                  labelStyle: kText16Black,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateEventScreen(),
                      ),
                    );
                    _markedDateMap.clear();
                    getMarked(user.listWork, user.listEvent);
                    setState(() {});
                  },
                ),
                SpeedDialChild(
                  child: Icon(Icons.person),
                  backgroundColor: Colors.blue,
                  labelBackgroundColor: Colors.white,
                  label: 'Cá nhân',
                  labelStyle: kText16Black,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateEventPerson(),
                      ),
                    );
                    _markedDateMap.clear();
                    getMarked(user.listWork, user.listEvent);
                    getWorkByDate(user.listWork);
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  void afterFirstLayout(BuildContext context) {}
}
