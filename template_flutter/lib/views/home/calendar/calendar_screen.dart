import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';

import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';
import 'package:s_fam/models/event.dart';
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
  List<String> listKind = ["Chung", "Cá nhân"];
  late UserProvider user;
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
  List<Widget> listWorkBuild = [];
  List<Widget> listEventBuild = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // listWork = Provider.of<UserProvider>(context, listen: false).listWork;
    // listEvent = Provider.of<UserProvider>(context, listen: false).listEvent;
    // print(Provider.of<UserProvider>(context, listen: false).listWork.length);
  }

  getMarked(works, events) {
    works.forEach((item) {
      DateTime dt = DateTime.parse(item.startDay);
      _markedDateMap.add(
        DateTime(dt.year, dt.month, dt.day),
        Event(
          date: DateTime(dt.year, dt.month, dt.day),
          dot: Container(),
        ),
      );
    });
    if (kind == "Chung") {
      events.forEach((item) {
        DateTime dt = DateTime.parse(item.date);
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
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  getWorkByDate(works) {
    String _date1 = Tools().getDate(_currentDate.toString());
    List<Widget> listBuild = [];
    works.forEach((item) {
      String _date = Tools().getDate(item.startDay);
      if (_date == _date1) {
        listBuild.add(Column(
          children: [
            ItemCalendar(
              name: item.name,
              time: item.startTime,
              sub: item.detail,
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
      listWorkBuild = listBuild;
    });
  }

  getEventByDate(events) {
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

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);
    getMarked(user.listWork, user.listEvent);
    getWorkByDate(user.listWork);
    getEventByDate(user.listEvent);
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
                        if (kind == "Chung") getEventByDate(user.listEvent);
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
                ? Container(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  )
                : Container(
                    height: 360,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: CalendarCarousel<Event>(
                      onDayPressed: (DateTime date, List<Event> events) {
                        this.setState(() => _currentDate = date);
                        getWorkByDate(user.listWork);
                        if (kind == "Chung") getEventByDate(user.listEvent);
                      },
                      customGridViewPhysics: NeverScrollableScrollPhysics(),
                      markedDatesMap: _markedDateMap,
                      markedDateCustomTextStyle: kText14Blue,
                      headerMargin: EdgeInsets.zero,
                      selectedDayButtonColor: primaryMain,
                      selectedDayBorderColor: primaryMain,
                      selectedDayTextStyle: kText14White,
                      weekendTextStyle: kText12black,
                      dayPadding: 1,
                      nextMonthDayBorderColor: textSecondary,
                      prevMonthDayBorderColor: textSecondary,
                      markedDateIconBorderColor: textSecondary,
                      thisMonthDayBorderColor: textSecondary,
                      weekFormat: false,
                      weekdayTextStyle: kText14Black,
                      height: 420.0,
                      selectedDateTime: _currentDate,
                      todayButtonColor: Colors.transparent,
                      todayBorderColor: textSecondary,
                      todayTextStyle:
                          listWorkBuild.isNotEmpty ? kText14Blue : kText14Black,
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
                isLoading
                    ? Container(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            if (listWorkBuild.isEmpty)
                              Container(
                                height: 80,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Không có công viện nào!",
                                  style: kSubText14Black,
                                ),
                              ),
                            ...listWorkBuild,
                          ],
                        ),
                      ),
              ],
            ),
            if(kind=="Chung")
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
                isLoading
                    ? Container(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            if (listEventBuild.isEmpty)
                              Container(
                                height: 80,
                                padding: EdgeInsets.only(top: 10),
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
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {}
}
