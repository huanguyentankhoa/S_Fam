import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';

class SelectDateTime extends StatefulWidget {
  const SelectDateTime({Key? key}) : super(key: key);

  @override
  _SelectDateTimeState createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  DateTime _currentDate = DateTime.now();
  String timeStart = "";
  String timeEnd = "";
  String date = "";
  bool repeat = false;
  bool remind = false;
  bool repeatWeek = false;
  bool repeatMonth = false;
  bool repeatYear = false;
  int remindNum = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      timeStart = Tools().getTime(_currentDate.toString());
      date = Tools().getDate(_currentDate.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              _appBarBuild(),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: CalendarCarousel<Event>(
                  onDayPressed: (DateTime date, List<Event> events) {
                    this.setState(() => _currentDate = date);
                  },
                  customGridViewPhysics: NeverScrollableScrollPhysics(),
                  headerMargin: EdgeInsets.zero,
                  selectedDayButtonColor: primaryMain,
                  selectedDayBorderColor: primaryMain,
                  weekendTextStyle: kText12black,
                  dayPadding: 1,
                  todayButtonColor: Colors.transparent,
                  todayBorderColor: textSecondary,
                  todayTextStyle: kText12black,
                  nextMonthDayBorderColor: textSecondary,
                  prevMonthDayBorderColor: textSecondary,
                  markedDateIconBorderColor: textSecondary,
                  thisMonthDayBorderColor: textSecondary,
                  weekFormat: false,
                  weekdayTextStyle: kText14Black,
                  height: 380.0,
                  selectedDateTime: _currentDate,
                  daysHaveCircularBorder: false,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Giờ bắt đầu",
                            style: kSubText14Black,
                          ),
                          InkWell(
                            onTap: () async {
                              final timePicked = await showRoundedTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (timePicked != null) {
                                setState(() {
                                  timeStart = timePicked.format(context);
                                });
                              }
                            },
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: textSecondary),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    timeStart,
                                    style: kText16Black,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 20,
                                    color: textSecondary,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Giờ kết thúc",
                            style: kSubText14Black,
                          ),
                          InkWell(
                            onTap: () async {
                              final timePicked = await showRoundedTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (timePicked != null) {
                                setState(() {
                                  timeEnd = timePicked.format(context);
                                });
                              }
                            },
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: textSecondary),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    timeEnd,
                                    style: kText16Black,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 20,
                                    color: textSecondary,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                height: 21,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lặp lại",
                      style: kText14BlackBold,
                    ),
                    Switch(
                      value: repeat,
                      onChanged: (value) {
                        setState(() {
                          repeat = value;
                        });
                      },
                      activeTrackColor: Colors.blue,
                      activeColor: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 9,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: repeat
                          ? () {
                              setState(() {
                                repeatWeek = true;
                                repeatMonth = false;
                                repeatYear = false;
                              });
                            }
                          : null,
                      child: Container(
                        height: 49,
                        width: 98,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          border: Border.all(
                            color:
                                repeatWeek ? Colors.black : Color(0xFFF2F2F2),
                          ),
                        ),
                        child: Text(
                          "Tuần",
                          style: kText16Black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: repeat
                          ? () {
                              setState(() {
                                repeatWeek = false;
                                repeatMonth = true;
                                repeatYear = false;
                              });
                            }
                          : null,
                      child: Container(
                        height: 49,
                        width: 98,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          border: Border.all(
                            color:
                                repeatMonth ? Colors.black : Color(0xFFF2F2F2),
                          ),
                        ),
                        child: Text(
                          "Tháng",
                          style: kText16Black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: repeat
                          ? () {
                              setState(() {
                                repeatWeek = false;
                                repeatMonth = false;
                                repeatYear = true;
                              });
                            }
                          : null,
                      child: Container(
                        height: 49,
                        width: 98,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          border: Border.all(
                            color:
                                repeatYear ? Colors.black : Color(0xFFF2F2F2),
                          ),
                        ),
                        child: Text(
                          "Năm",
                          style: kText16Black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                height: 21,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nhắc trước",
                      style: kText14BlackBold,
                    ),
                    Switch(
                      value: remind,
                      onChanged: (value) {
                        setState(() {
                          remind = value;
                        });
                      },
                      activeTrackColor: Colors.blue,
                      activeColor: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 9,
              ),
              InkWell(
                onTap: () {
                  Picker(
                      adapter: NumberPickerAdapter(data: [
                        NumberPickerColumn(
                            begin: 0, end: 100, jump: 1, initValue: 5),
                      ]),
                      hideHeader: true,
                      selectedTextStyle: TextStyle(color: Colors.blue),
                      cancelText: "HỦY",
                      confirmText: "OK",
                      cancelTextStyle: kText14Black,
                      confirmTextStyle: kText14Blue,
                      onConfirm: (Picker picker, List value) {
                        setState(() {
                          remindNum = picker.getSelectedValues().first;
                        });
                      }).showDialog(context);
                },
                child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: textSecondary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          remindNum.toString(),
                          style: kText14Black,
                        ),
                        Text(
                          "Phút",
                          style: kText14Black,
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 28,
              ),
              GestureDetector(
                onTap: () {
                  Map<String, dynamic> data = {
                    "daySelected": _currentDate.toString(),
                    "timeStart": timeStart,
                    "timeEnd": timeEnd,
                    "eventRemindType": "HOUR",
                    "repeat": repeat
                        ? repeatYear
                            ? "YEAR"
                            : repeatMonth
                                ? "MONTH"
                                : "WEEK"
                        : "WEEK",
                    "remindNum": remind ? remindNum : 5,
                  };
                  Navigator.pop(context, data);
                },
                child: Container(
                  height: 52,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: primaryMain,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Tiếp tục",
                    style: kText16WhiteBold,
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
            ],
          ),
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
            height: 90,
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
                  "Chọn thời gian",
                  style: kText20BlackBold,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
