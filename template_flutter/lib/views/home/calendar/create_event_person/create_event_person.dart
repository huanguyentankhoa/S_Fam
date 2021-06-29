import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';
import 'package:s_fam/models/work.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/widgets/text_input.dart';

class CreateEventPerson extends StatefulWidget {
  const CreateEventPerson({Key? key}) : super(key: key);

  @override
  _CreateEventPersonState createState() => _CreateEventPersonState();
}

class _CreateEventPersonState extends State<CreateEventPerson> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameEvent = TextEditingController();
  TextEditingController note = TextEditingController();
  DateTime _currentDate = DateTime.now();
  String timeStart = "";
  String timeEnd = "";
  String dateStart = "";
  String dateEnd = "";
  List<String> repeatType = [];
  ButtonStatus stateOnlyText = ButtonStatus.idle;
  late UserProvider user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      timeStart = Tools().getTime(_currentDate.toString());
      dateStart = Tools().getDate(_currentDate.toString());
    });
  }


  void onPressedCustomButton() async {
    Map<String, dynamic> data = {
      "name": nameEvent.text,
      "startDay": dateStart,
      "endDay": dateEnd,
      "startTime": timeStart,
      "endTime": timeEnd,
      "repeatType": repeatType,
      "detail": note.text
    };
    if (stateOnlyText == ButtonStatus.idle) {
      setState(() {
        stateOnlyText = ButtonStatus.loading;
      });
      Future.delayed(Duration(seconds: 2), () async {
        if (_formKey.currentState!.validate()) {
          user.createWork(
              data: data,
              email: user.userCurrentLogin.email,
              success: () {
                setState(() {
                  stateOnlyText = ButtonStatus.success;
                });
                Future.delayed(Duration(seconds: 2), () {
                  if(mounted)
                    setState(() {
                      stateOnlyText = ButtonStatus.idle;
                    });
                });
              },
              fail: () {
                setState(() {
                  stateOnlyText = ButtonStatus.fail;
                });
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    stateOnlyText = ButtonStatus.idle;
                  });
                });
              });
        } else {
          setState(() {
            stateOnlyText = ButtonStatus.fail;
          });
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              stateOnlyText = ButtonStatus.idle;
            });
          });
        }
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                _appBarBuild(),
                SizedBox(
                  height: 32,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(
                    height: 48,
                    labelText: "Tiêu đề",
                    validator: (value) {
                      return value!.isEmpty ? "Không được bỏ trống" : null;
                    },
                    controller: nameEvent,
                  ),
                ),
                SizedBox(
                  height: 8,
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
                              "Thời gian bắt đầu",
                              style: kSubText14Black,
                            ),
                            InkWell(
                              onTap: () async {
                                DateTime? newDateTime =
                                    await showRoundedDatePicker(
                                  context: context,
                                  theme: ThemeData(primarySwatch: Colors.blue),
                                  height: 350,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 1),
                                  lastDate: DateTime(DateTime.now().year + 1),
                                  borderRadius: 16,
                                );
                                if (newDateTime != null) {
                                  setState(() {
                                    dateStart = newDateTime.toString();
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
                                      Tools().getDate(dateStart),
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
                              "Thời gian kết thúc",
                              style: kSubText14Black,
                            ),
                            InkWell(
                              onTap: () async {
                                DateTime? newDateTime =
                                    await showRoundedDatePicker(
                                  context: context,
                                  theme: ThemeData(primarySwatch: Colors.blue),
                                  height: 350,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 1),
                                  lastDate: DateTime(DateTime.now().year + 1),
                                  borderRadius: 16,
                                );
                                if (newDateTime != null) {
                                  setState(() {
                                    dateEnd = newDateTime.toString();
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
                                      Tools().getDate(dateEnd),
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
                  height: 20,
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lặp lại vào",
                        style: kText14BlackBold,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DayOfWeek(
                              day: "T2",
                              onCheck: (result) {
                                int index =
                                    repeatType.indexOf("Monday".toUpperCase());
                                if (index > 0) {
                                  if (!result) repeatType.removeAt(index);
                                } else {
                                  if (result) {
                                    repeatType.add("Monday".toUpperCase());
                                  }
                                }
                              }),
                          DayOfWeek(
                              day: "T3",
                              onCheck: (result) {
                                int index =
                                    repeatType.indexOf("Tuesday".toUpperCase());
                                if (index > 0) {
                                  if (!result) repeatType.removeAt(index);
                                } else {
                                  if (result) {
                                    repeatType.add("Tuesday".toUpperCase());
                                  }
                                }
                              }),
                          DayOfWeek(
                              day: "T4",
                              onCheck: (result) {
                                int index = repeatType
                                    .indexOf("Wednesday".toUpperCase());
                                if (index > 0) {
                                  if (!result) repeatType.removeAt(index);
                                } else {
                                  if (result) {
                                    repeatType.add("Wednesday".toUpperCase());
                                  }
                                }
                              }),
                          DayOfWeek(
                              day: "T5",
                              onCheck: (result) {
                                int index = repeatType
                                    .indexOf("Thursday".toUpperCase());
                                if (index > 0) {
                                  if (!result) repeatType.removeAt(index);
                                } else {
                                  if (result) {
                                    repeatType.add("Thursday".toUpperCase());
                                  }
                                }
                              }),
                          DayOfWeek(
                              day: "T6",
                              onCheck: (result) {
                                int index =
                                    repeatType.indexOf("Friday".toUpperCase());
                                if (index > 0) {
                                  if (!result) repeatType.removeAt(index);
                                } else {
                                  if (result) {
                                    repeatType.add("Friday".toUpperCase());
                                  }
                                }
                              }),
                          DayOfWeek(
                              day: "T7",
                              onCheck: (result) {
                                int index = repeatType
                                    .indexOf("Saturday".toUpperCase());
                                if (index > 0) {
                                  if (!result) repeatType.removeAt(index);
                                } else {
                                  if (result) {
                                    repeatType.add("Saturday".toUpperCase());
                                  }
                                }
                              }),
                          DayOfWeek(
                              day: "CN",
                              onCheck: (result) {
                                int index =
                                    repeatType.indexOf("Sunday".toUpperCase());
                                if (index > 0) {
                                  if (!result) repeatType.removeAt(index);
                                } else {
                                  if (result) {
                                    repeatType.add("Sunday".toUpperCase());
                                  }
                                }
                              }),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
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
                                  locale: Locale("en", "EN"),
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
                                  locale: Locale("en", "EN"),
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
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(
                    height: 76,
                    labelText: "Mô tả",
                    validator: (value) {
                      return null;
                    },
                    controller: note,
                  ),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 52,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child:ProgressButtonAnimation(
                      onPressed: onPressedCustomButton,
                      state: stateOnlyText,
                      height: 52,
                      maxWidth: MediaQuery.of(context).size.width,
                      stateWidgets: {
                        ButtonStatus.idle: Text(
                          "Hoàn tất",
                          style: kText16WhiteBold,
                        ),
                        ButtonStatus.fail: Text(
                          "Xảy ra lỗi",
                          style: kText14White,
                        ),
                        ButtonStatus.success: Text(
                          "Tạo sự kiện thành công",
                          style: kText14White,
                        ),
                      },
                      stateColors: {
                        ButtonStatus.idle: primaryMain,
                        ButtonStatus.loading: primaryMain,
                        ButtonStatus.fail: Colors.red,
                        ButtonStatus.success: Colors.green,
                      },
                    )
                  ),
                ))
              ],
            ),
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
                  "Thêm lịch cá nhân mới",
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

class DayOfWeek extends StatefulWidget {
  final String day;
  final Function(bool) onCheck;

  const DayOfWeek({Key? key, required this.day, required this.onCheck})
      : super(key: key);

  @override
  _DayOfWeekState createState() => _DayOfWeekState();
}

class _DayOfWeekState extends State<DayOfWeek> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isCheck = !isCheck;
        });
        widget.onCheck(isCheck);
      },
      child: Container(
        height: 33,
        width: 33,
        decoration: BoxDecoration(
          color: Color(0xFFF2F2F2),
          shape: BoxShape.circle,
          border: Border.all(color: isCheck ? Colors.black : Color(0xFFF2F2F2)),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.day,
          style: kText16Black,
        ),
      ),
    );
  }
}
