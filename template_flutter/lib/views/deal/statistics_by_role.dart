import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticsByRole extends StatefulWidget {
  const StatisticsByRole({Key? key}) : super(key: key);

  @override
  _StatisticsByRoleState createState() => _StatisticsByRoleState();
}

class _StatisticsByRoleState extends State<StatisticsByRole>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<TabItem> tabs = [
    TabItem(1, "Vài trò: Thẩm định", true),
    TabItem(2, "Nhà đầu tư chính", false),
    TabItem(3, "Nhà đầu tư phụ", false),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Widget Appraisal() {
    return Container(
      height: 69.h,
      color: yrColor4,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text:
                        TextSpan(text: "Tổng dự án:   ", style: kText12_2, children: [
                      TextSpan(
                        text: "4",
                        style: kText12_2,
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  RichText(
                    text:
                    TextSpan(text: "Tổng giá trị:   ", style: kText12_2, children: [
                      TextSpan(
                        text: "39,54 tỷ VNĐ",
                        style: kText12_5,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12.w,top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text:
                    TextSpan(text: "Đã thẩm định:      ", style: kText12_2, children: [
                      TextSpan(
                        text: "1",
                        style: kText12_2,
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  RichText(
                    text:
                    TextSpan(text: "Đang thẩm định:  ", style: kText12_2, children: [
                      TextSpan(
                        text: "2",
                        style: kText12_2,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12.w,top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text:
                    TextSpan(text: "Dự án lớn nhất:", style: kText12_2, ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  RichText(
                    text:
                    TextSpan(text: "13,3 tỷ VNĐ", style: kText12_5, ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget MainInvestor() {
    return Container(
      height: 69.h,
      color: yrColor4,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text:
                  TextSpan(text: "Tổng dự án:   ", style: kText12_2, children: [
                    TextSpan(
                      text: "1",
                      style: kText12_2,
                    ),
                  ]),
                ),
                SizedBox(
                  height: 8.h,
                ),
                RichText(
                  text:
                  TextSpan(text: "Tổng giá trị:   ", style: kText12_2, children: [
                    TextSpan(
                      text: "1,16 tỷ VNĐ",
                      style: kText12_5,
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12.w,top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text:
                    TextSpan(text: "Đã thanh toán:     ", style: kText12_2, children: [
                      TextSpan(
                        text: "1",
                        style: kText12_2,
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  RichText(
                    text:
                    TextSpan(text: "Dự án lớn nhất:   ", style: kText12_2, children: [
                      TextSpan(
                        text: "1,16 tỷ VNĐ",
                        style: kText12_5,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget SubInvestor() {
    return Container(
      height: 69.h,
      color: yrColor4,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text:
                  TextSpan(text: "Tổng dự án:   ", style: kText12_2, children: [
                    TextSpan(
                      text: "2",
                      style: kText12_2,
                    ),
                  ]),
                ),
                SizedBox(
                  height: 8.h,
                ),
                RichText(
                  text:
                  TextSpan(text: "Tổng giá trị:   ", style: kText12_2, children: [
                    TextSpan(
                      text: "3,72 tỷ VNĐ",
                      style: kText12_5,
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12.w,top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text:
                    TextSpan(text: "Đã thanh toán:     ", style: kText12_2, children: [
                      TextSpan(
                        text: "1",
                        style: kText12_2,
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  RichText(
                    text:
                    TextSpan(text: "Dự án lớn nhất:   ", style: kText12_2, children: [
                      TextSpan(
                        text: "1,9 tỷ VNĐ",
                        style: kText12_5,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            color: yrColor1,
            height: 26.h,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      tabs.forEach((item) => item.isSelected = false);
                      setState(() {
                        tabs[0].isSelected = true;
                        _tabController.index = 0;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _tabController.index == 0 ? yrColor10 : yrColor8,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.h),
                          topRight: Radius.circular(15.h),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Vai trò: Thẩm đinh",
                        style: kText12Bold_4,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      tabs.forEach((item) => item.isSelected = false);
                      setState(() {
                        tabs[1].isSelected = true;
                        _tabController.index = 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _tabController.index == 1 ? yrColor5 : yrColor8,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.h),
                          topRight: Radius.circular(15.h),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Nhà đầu tư chính",
                        style: kText12Bold_4,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      tabs.forEach((item) => item.isSelected = false);
                      setState(() {
                        tabs[2].isSelected = true;
                        _tabController.index = 2;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _tabController.index == 2 ? yrColor16 : yrColor8,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.h),
                          topRight: Radius.circular(15.h),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Nhà đầu tư phụ",
                        style: kText12Bold_4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
              Appraisal(),
                MainInvestor(),
             SubInvestor()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabItem {
  late int id;
  late String name;
  late bool isSelected;

  TabItem(this.id, this.name, this.isSelected);
}
