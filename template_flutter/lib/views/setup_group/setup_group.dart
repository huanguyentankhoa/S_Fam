import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:youreal/routes/ui_pages.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/view_models/chat/chat_provider.dart';
import 'package:youreal/view_models/deal/deal_provider.dart';
import 'package:youreal/view_models/news/news_provider.dart';

import '../main_screen.dart';

class SetupGroup extends StatefulWidget {
  const SetupGroup({Key? key}) : super(key: key);

  @override
  _SetupGroupState createState() => _SetupGroupState();
}

class _SetupGroupState extends State<SetupGroup> {
  String myPosition = "";
  ButtonStatus stateOnlyText = ButtonStatus.idle;
  List<int> typeRealEstate = [];
  bool agreeRule = false;
  late AppModel appModel;
  late DealProvider deal;
  late NewsProvider news;
  late ChatProvider chat;
  bool isError = false;
  List<Province> _listProvince = [
    Province(1, "TP. Hồ Chí Minh", false),
    Province(2, "Hà Nội", false),
    Province(3, "Thanh Hóa", false),
    Province(4, "Đồng Nai", false),
    Province(5, "Vũng Tàu", false),
    Province(6, "Bình Dương", false),
    Province(7, "Khánh Hòa", false),
    Province(8, "Hải Phòng", false),
    Province(9, "Đà Nẵng", false),
    Province(10, "Cần Thơ", false),
  ];
  double minValue = 10;
  double maxValue = 60;

  void onCheckTypeRealEstate(int id, bool result) {
    if (result)
      typeRealEstate.add(id);
    else {
      try {
        int i = typeRealEstate.indexOf(id);
        typeRealEstate.removeAt(i);
      } catch (e) {}
    }
    setState(() {});
  }

  getData() async {
    await deal.getListDealRecently();
    await deal.getListDealSuggest();
    await deal.getListDealInvesting();
    await deal.getListDealInvested();
    await news.getListHotNews();
    await news.getListOtherNews();
    await chat.getListGroupChat();
  }

  void onPressedCustomButton() {
    setState(() {
      stateOnlyText = ButtonStatus.loading;
    });
    Future.delayed(Duration(seconds: 2), () async {
      if (typeRealEstate.length < 2 || agreeRule == false) {
        setState(() {
          stateOnlyText = ButtonStatus.fail;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            stateOnlyText = ButtonStatus.idle;
          });
        });
      } else {
        appModel.sendCriteria(
          position: myPosition,
          soilType: typeRealEstate,
          investmentLimit: "$minValue - $maxValue",
          success: () async {
            await getData();
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
            });
          },
          fail: () {
            setState(() {
              stateOnlyText = ButtonStatus.fail;
            });
            Future.delayed(Duration(seconds: 1), () {
              setState(() {
                stateOnlyText = ButtonStatus.idle;
              });
            });
          },
        );
      }
    });
  }

  List<Widget> _listPosition() {
    return [
      Position(
        province: _listProvince[0],
        size: 160.h,
        top: 159.h,
        left: 140.w,
        nameStyle: kText22_1,
        onTap: () {
          _listProvince.forEach((item) {
            item.isSelected = false;
          });
          myPosition = "";
          setState(() {
            _listProvince[0].isSelected = true;
            myPosition = _listProvince[0].name;
          });
        },
      ),
      Position(
        province: _listProvince[1],
        size: 120.h,
        top: 119.h,
        left: 283.w,
        nameStyle: kText22_1,
        onTap: () {
          _listProvince.forEach((item) {
            item.isSelected = false;
          });
          myPosition = "";
          setState(() {
            _listProvince[1].isSelected = true;
            myPosition = _listProvince[1].name;
          });
        },
      ),
      Position(
        province: _listProvince[2],
        size: 60.h,
        top: 176.h,
        left: 4.w,
        nameStyle: kText12_1,
        onTap: () {
          _listProvince.forEach((item) {
            item.isSelected = false;
          });
          myPosition = "";
          setState(() {
            _listProvince[2].isSelected = true;
            myPosition = _listProvince[2].name;
          });
        },
      ),
      Position(
        province: _listProvince[3],
        size: 60.h,
        top: 213.h,
        left: 72.w,
        nameStyle: kText12_1,
        onTap: () {
          _listProvince.forEach((item) {
            item.isSelected = false;
          });
          myPosition = "";
          setState(() {
            _listProvince[3].isSelected = true;
            myPosition = _listProvince[3].name;
          });
        },
      ),
      Position(
        province: _listProvince[4],
        size: 60.h,
        top: 395.h,
        left: 270.w,
        nameStyle: kText12_1,
        onTap: () {
          _listProvince.forEach((item) {
            item.isSelected = false;
          });
          myPosition = "";
          setState(() {
            _listProvince[4].isSelected = true;
            myPosition = _listProvince[4].name;
          });
        },
      ),
      Position(
        province: _listProvince[5],
        size: 80.h,
        top: 288.h,
        left: 92.w,
        nameStyle: kText15_1,
        onTap: () {
          _listProvince.forEach((item) {
            item.isSelected = false;
          });
          myPosition = "";
          setState(() {
            _listProvince[5].isSelected = true;
            myPosition = _listProvince[5].name;
          });
        },
      ),
      Position(
        province: _listProvince[6],
        size: 80.h,
        top: 324.h,
        left: 9.w,
        nameStyle: kText15_1,
        onTap: () {
          _listProvince.forEach((item) {
            item.isSelected = false;
          });
          myPosition = "";
          setState(() {
            _listProvince[6].isSelected = true;
            myPosition = _listProvince[6].name;
          });
        },
      ),
      Position(
        province: _listProvince[7],
        size: 80.h,
        top: 328.h,
        left: 180.w,
        nameStyle: kText16_1,
        onTap: () {
          _listProvince.forEach((item) {
            item.isSelected = false;
          });
          myPosition = "";
          setState(() {
            _listProvince[7].isSelected = true;
            myPosition = _listProvince[7].name;
          });
        },
      ),
      Position(
        province: _listProvince[8],
        size: 100.h,
        top: 288.h,
        left: 274.w,
        nameStyle: kText20_1,
        onTap: () {
          _listProvince.forEach((item) {
            item.isSelected = false;
          });
          myPosition = "";
          setState(() {
            _listProvince[8].isSelected = true;
            myPosition = _listProvince[8].name;
          });
        },
      ),
      Position(
        province: _listProvince[9],
        size: 100.h,
        top: 377.h,
        left: 82.w,
        nameStyle: kText20_1,
        onTap: () {
          _listProvince.forEach((item) {
            item.isSelected = false;
          });
          myPosition = "";
          setState(() {
            _listProvince[9].isSelected = true;
            myPosition = _listProvince[9].name;
          });
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    appModel = Provider.of<AppModel>(context);
    deal = Provider.of<DealProvider>(context);
    news = Provider.of<NewsProvider>(context);
    chat = Provider.of<ChatProvider>(context);
    return Scaffold(
      backgroundColor: yrColor1,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 90.h,
                    ),
                    Container(
                      child: Text(
                        "Bạn đang ở đâu?",
                        style: kText14_4,
                      ),
                    ),
                    SizedBox(
                      height: 380.h,
                    ),
                    FlutterSlider(
                      values: [minValue, maxValue],
                      rangeSlider: true,
                      trackBar: FlutterSliderTrackBar(
                        activeTrackBar: BoxDecoration(color: yrColor14),
                        inactiveTrackBar: BoxDecoration(color: yrColor4),
                      ),
                      onDragCompleted: (a, lowerValue, upperValue) {
                        setState(() {
                          minValue = lowerValue;
                          maxValue = upperValue;
                        });
                      },
                      tooltip: FlutterSliderTooltip(
                          custom: (value) {
                            return Container(
                              height: 15.h,
                              width: 44.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: yrColor14,
                                  borderRadius: BorderRadius.circular(20.w)),
                              child: Text(
                                "${value.toString()} tỷ",
                                style: kText12_4,
                              ),
                            );
                          },
                          alwaysShowTooltip: true,
                          positionOffset:
                              FlutterSliderTooltipPositionOffset(top: 30.h)),
                      rightHandler: FlutterSliderHandler(
                        child: Container(),
                      ),
                      handler: FlutterSliderHandler(
                        child: Container(),
                      ),
                      handlerHeight: 18.h,
                      handlerWidth: 18.h,
                      max: 100,
                      min: 0,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Bất động sản bạn đang quan tâm: ',
                        style: kText14_4,
                        children: <TextSpan>[
                          TextSpan(
                            text: '(Chọn ít nhất 2 loại)',
                            style: kText14_3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  OtpCheck(
                                    id: 1,
                                    name: "Nhà ở/đất ở riêng lẻ",
                                    onCheck: (id, result) =>
                                        onCheckTypeRealEstate(id, result),
                                  ),
                                  SizedBox(
                                    height: 17.h,
                                  ),
                                  OtpCheck(
                                    id: 2,
                                    name: "Đất nông nghiệp",
                                    onCheck: (id, result) =>
                                        onCheckTypeRealEstate(id, result),
                                  ),
                                  SizedBox(
                                    height: 17.h,
                                  ),
                                  OtpCheck(
                                    id: 3,
                                    name: "Dự án nhà ở",
                                    onCheck: (id, result) =>
                                        onCheckTypeRealEstate(id, result),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  OtpCheck(
                                    id: 4,
                                    name: "Đất sản xuất kinh doanh",
                                    onCheck: (id, result) =>
                                        onCheckTypeRealEstate(id, result),
                                  ),
                                  SizedBox(
                                    height: 17.h,
                                  ),
                                  OtpCheck(
                                    id: 5,
                                    name: "Căn hộ chung cư",
                                    onCheck: (id, result) =>
                                        onCheckTypeRealEstate(id, result),
                                  ),
                                  SizedBox(
                                    height: 17.h,
                                  ),
                                  OtpCheck(
                                    id: 1,
                                    name: "Khác",
                                    onCheck: (id, result) =>
                                        onCheckTypeRealEstate(id, result),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          agreeRule = !agreeRule;
                        });
                      },
                      child: Container(
                        height: 33.h,
                        child: Row(
                          children: [
                            Container(
                              height: 20.h,
                              width: 20.h,
                              decoration: BoxDecoration(
                                color:
                                    agreeRule ? yrColor4 : Colors.transparent,
                                border: Border.all(color: yrColor7),
                              ),
                            ),
                            SizedBox(
                              width: 11.w,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: "Tôi đồng ý với các ",
                                    style: kText14_4,
                                    children: [
                                  TextSpan(
                                    text: "điều khoản ",
                                    style: kText14_14,
                                  ),
                                  TextSpan(
                                    text: "và ",
                                    style: kText14_4,
                                  ),
                                  TextSpan(
                                    text: "chính sách bảo mật",
                                    style: kText14_14,
                                  ),
                                ]))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    ///Button tham gia
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      alignment: Alignment.center,
                      child: ProgressButtonAnimation(
                        onPressed: () {
                          onPressedCustomButton();
                        },
                        state: stateOnlyText,
                        height: 58.h,
                        maxWidth: MediaQuery.of(context).size.width,
                        progressIndicator: CircularProgressIndicator(
                          backgroundColor: yrColor4,
                        ),
                        stateWidgets: {
                          ButtonStatus.idle: Text(
                            "THAM GIA",
                            style: kText18_1,
                          ),
                          ButtonStatus.fail: Text(
                            "Có lỗi xảy ra",
                            style: kText18_3,
                          ),
                          ButtonStatus.success: Text(
                            "THAM GIA",
                            style: kText18_3,
                          ),
                        },
                        stateColors: {
                          ButtonStatus.idle: yrColor4,
                          ButtonStatus.loading: yrColor14,
                          ButtonStatus.fail: yrColor5,
                          ButtonStatus.success: yrColor16,
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ..._listPosition()
            ],
          ),
        ),
      ),
    );
  }
}

class OtpCheck extends StatefulWidget {
  final int id;
  final String name;
  final Function(int, bool) onCheck;

  const OtpCheck({
    Key? key,
    required this.id,
    required this.name,
    required this.onCheck,
  }) : super(key: key);

  @override
  _OtpCheckState createState() => _OtpCheckState();
}

class _OtpCheckState extends State<OtpCheck> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isCheck = !isCheck;
        });
        widget.onCheck(widget.id, isCheck);
      },
      child: Container(
        height: 33,
        child: Row(
          children: [
            Container(
              height: 20.h,
              width: 20.h,
              decoration: BoxDecoration(
                color: isCheck ? yrColor4 : Colors.transparent,
                border: Border.all(color: yrColor7),
              ),
            ),
            SizedBox(
              width: 11.w,
            ),
            Text(
              widget.name,
              style: kText12_3,
            )
          ],
        ),
      ),
    );
  }
}

class Position extends StatefulWidget {
  final Province province;
  final double size;
  final double top;
  final double left;
  final TextStyle nameStyle;
  final Function onTap;

  Position({
    Key? key,
    required this.province,
    required this.size,
    required this.top,
    required this.left,
    required this.nameStyle,
    required this.onTap,
  }) : super(key: key);

  @override
  _PositionState createState() => _PositionState();
}

class _PositionState extends State<Position> {
  // bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Container(
          height: widget.size,
          width: widget.size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.province.isSelected ? yrColor14 : yrColor6),
          child: Text(
            widget.province.name,
            style: widget.nameStyle,
          ),
        ),
      ),
    );
  }
}

class Province {
  bool isSelected = false;
  int id;
  String name;

  Province(this.id, this.name, this.isSelected);
}
