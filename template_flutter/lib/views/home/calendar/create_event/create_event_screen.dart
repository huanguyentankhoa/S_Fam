import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:provider/provider.dart';
import 'package:s_fam/common/constants/colors_config.dart';
import 'package:s_fam/common/constants/texts_config.dart';
import 'package:s_fam/common/tools.dart';
import 'package:s_fam/models/member.dart';
import 'package:s_fam/view_models/events/event_provider.dart';
import 'package:s_fam/view_models/user_provider.dart';
import 'package:s_fam/views/home/calendar/add_member.dart';
import 'package:s_fam/views/home/calendar/select_date_time.dart';
import 'package:s_fam/widgets/text_input.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameEvent = TextEditingController();
  TextEditingController note = TextEditingController();
  List<Member> listMember = [];
  List<String> listEmailMember = [];
  String day = "";
  String startTime = "";
  String endTime = "";
  String repeatType = "WEEK";
  String eventRemindType = "HOUR";
  int remindNum = 5;
  ButtonStatus stateOnlyText = ButtonStatus.idle;
  late UserProvider user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    day = DateTime.now().toString();
  }

  void onPressedCustomButton() async {
    Map<String, dynamic> data = {
      "name": nameEvent.text,
      "day": day,
      "startTime": startTime,
      "endTime": endTime,
      "repeatType": repeatType,
      "eventRemindType": eventRemindType,
      "remindNum": remindNum,
      "appUserSet": listEmailMember.toList(),
      "detail": note.text
    };
    if (stateOnlyText == ButtonStatus.idle) {
      setState(() {
        stateOnlyText = ButtonStatus.loading;
      });
      Future.delayed(Duration(seconds: 2), () async {
        user.sendNotification();
        if (_formKey.currentState!.validate()||listMember.isNotEmpty) {
          user.createEvent(data: data,
              success: () {
                setState(() {
                  stateOnlyText = ButtonStatus.success;
                });
                Future.delayed(Duration(seconds: 2), () {
                  if (mounted)
                    setState(() {
                      stateOnlyText = ButtonStatus.idle;
                    });
                });
          }, fail: () {
              setState(() {
                stateOnlyText = ButtonStatus.fail;
              });
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                  stateOnlyText = ButtonStatus.idle;
                });
              });
          },);
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
  Widget build(BuildContext context) {
    EventProvider _event = Provider.of<EventProvider>(context);
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
                          "Tạo sự kiện mới",
                          style: kText20BlackBold,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(
                    height: 48,
                    labelText: "Tên sự kiện",
                    validator: (value) {
                      return value!.isEmpty ? "*Không được bỏ trống" : null;
                    },
                    controller: nameEvent,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    Map<String, dynamic> result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectDateTime(),
                      ),
                    );
                    setState(() {
                      day = result["daySelected"];
                      startTime = result["timeStart"];
                      endTime = result["timeEnd"];
                      eventRemindType = result["eventRemindType"];
                      repeatType = result["repeat"];
                      remindNum = result["remindNum"];
                    });
                  },
                  child: Container(
                    height: 48,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: textSecondary),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Tools().getDate(day),
                          style: kText16Black,
                        ),
                        Container(
                          height: 24,
                          width: 24,
                          child: SvgPicture.asset(
                            "assets/icons/calendar_date.svg",
                            color: primaryMain,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Thêm thành viên",
                      style: kText14Black,
                    )),
                if (_event.listMemberAdd.length < 1)
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "*Thêm ít nhất 1 thành viên",
                        style: kText14Red,
                      )),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 48,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          List<Member> members = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddMember(),
                            ),
                          );
                          members.forEach((element) {
                            listEmailMember.add(element.email!);
                          });
                          setState(() {
                            listMember = members;
                          });
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          child: Stack(
                            children: [
                              Image.asset("assets/icons/rectangle_30.png"),
                              Container(
                                height: 48,
                                width: 48,
                                child: Icon(
                                  Icons.add,
                                  color: primaryMain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width - 100,
                        child: ListView.builder(
                            itemCount: _event.listMemberAdd.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Container(
                                    height: 48,
                                    width: 123,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border:
                                            Border.all(color: textSecondary)),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 28,
                                          width: 28,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: Image.asset(
                                              "assets/images/Ellipse10.png"),
                                        ),
                                        Text(
                                          _event.listMemberAdd[index].name!,
                                          style: kText14Black,
                                        ),
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.centerRight,
                                          margin: EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.cancel,
                                            color: textSecondary,
                                            size: 16,
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 26,
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
                SizedBox(
                  height: 8,
                ),
                Expanded(
                    child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
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
}
