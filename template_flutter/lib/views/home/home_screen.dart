import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/model/deal.dart';
import 'package:youreal/view_models/deal/deal_provider.dart';
import 'package:youreal/view_models/notification/firebase_notification_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/views/detail/detail_deal.dart';
import 'package:youreal/views/home/card_deal_invested.dart';
import 'package:youreal/views/home/card_deal_investing.dart';
import 'package:youreal/views/home/card_deal_suggest.dart';
import 'package:youreal/views/menu/menu.dart';

import '../../routes/ui_pages.dart';
import '../../view_models/app_model.dart';
import 'card_deal_recently.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _key = GlobalKey<ScaffoldState>();
  FirebaseNotification firebaseNotification = FirebaseNotification();
  String _valueLocation = "Tp.Hồ Chí Minh";
  List<String> listLocation = ["Tp.Hồ Chí Minh", "Value2", "Value3", "Value4"];
  String _valueSort = "LeaderA";
  List<String> listSort = ["LeaderA", "LeaderB", "LeaderC", "LeaderD"];
  bool isSelectLocation = false;

  TextEditingController _search = TextEditingController();
  List<Widget> _dealRecentlyBuild = [];
  List<Widget> _dealInvestingBuild = [];
  List<Widget> _dealInvestedBuild = [];
  List<Deal> _listDealRecently = [];
  List<Deal> _listDealSuggest = [];
  List<Deal> _listDealInvesting = [];
  List<Deal> _listDealInvested = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _listDealRecently =
          Provider.of<DealProvider>(context, listen: false).listDealRecently;
      _listDealSuggest =
          Provider.of<DealProvider>(context, listen: false).listDealSuggest;
      _listDealInvesting =
          Provider.of<DealProvider>(context, listen: false).listDealInvesting;
      _listDealInvested =
          Provider.of<DealProvider>(context, listen: false).listDealInvested;
    });

    _loadCard();
  }

  _loadCard() {
    _listDealRecently.forEach((item) {
      _dealRecentlyBuild.add(
        CardDealRecently(
          nameCard: item.name,
          address: item.address,
          acreage: item.acreage,
          numberFollower: item.numberFollower,
          price: item.price,
          isExpired: item.isExpired,
          imageSample: item.imageSample,
          images: item.images,
        ),
      );
    });
    _listDealInvesting.forEach((item) {
      _dealInvestingBuild.add(CardDealInvesting(
        nameCard: item.name,
        address: item.address,
        acreage: item.acreage,
        price: item.price,
        isInvestorsMain: item.isInvestorsMain,
        imageSample: item.imageSample,
        images: item.images,
      ));
    });
    _listDealInvested.forEach((item) {
      _dealInvestedBuild.add(CardDealInvested(deal: item));
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: yrColor1,
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: yrColor1,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            _key.currentState!.openDrawer();
          },
          child: Container(
            child: Icon(
              Icons.menu,
              color: yrColor4,
              size: 38.w,
            ),
          ),
        ),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            "Trang chủ",
            style: kText18Bold_3,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: 14.w),
              child: Icon(
                Icons.notifications_none,
                color: yrColor4,
                size: 25.w,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _headerBuild(),
            SizedBox(
              height: 30.h,
            ),
            Container(
              height: 200,
              padding: EdgeInsets.only(left: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deal đề xuất",
                    style: kText20Bold_4,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Container(
                    height: 180.h,
                    child: ListView.builder(
                        itemCount: _listDealSuggest.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var item = _listDealSuggest[index];
                          return CardDealSuggest(
                            nameCard: item.name,
                            address: item.address,
                            acreage: item.acreage,
                            numberFollower: item.numberFollower,
                            price: item.price,
                            imageSample: item.imageSample,
                            onTap: () {
                              // appModel.currentAction = PageAction(
                              //     state: PageState.addWidget,
                              //     widget: DetailDeal(
                              //       deal: item,
                              //     ),
                              //     page: DetailPageConfig);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailDeal(deal: item),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 12.w, right: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deal gần đây",
                    style: kText20Bold_4,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  ..._dealRecentlyBuild,
                  SizedBox(
                    height: 8.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Xem thêm",
                        style: kText18_3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  Container(
                    height: 33.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: yrColor3,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.h),
                          topRight: Radius.circular(8.h),
                        )),
                    alignment: Alignment.center,
                    child: Text(
                      "Deal đang đâu tư",
                      style: kText16Bold_1,
                    ),
                  ),
                  ..._dealInvestingBuild,
                  SizedBox(
                    height: 8.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Xem thêm",
                        style: kText18_3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  Container(
                    height: 33.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: yrColor3,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.h),
                          topRight: Radius.circular(8.h),
                        )),
                    alignment: Alignment.center,
                    child: Text(
                      "Deal đã đâu tư",
                      style: kText16Bold_1,
                    ),
                  ),
                  ..._dealInvestedBuild,
                  SizedBox(
                    height: 8.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Xem thêm",
                        style: kText18_3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerBuild() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 5, left: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: yrColor3,
                      size: 15,
                    ),
                    Container(
                      height: 20,
                      width: 120,
                      margin: EdgeInsets.only(left: 16.w),
                      child: DropdownButton<String>(
                        value: _valueLocation,
                        isExpanded: true,
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: yrColor3,
                          ),
                        ),
                        style: kText16Bold_3,
                        dropdownColor: yrColor1,
                        underline: Container(),
                        onChanged: (value) {
                          setState(() {
                            _valueLocation = value!;
                          });
                        },
                        items: listLocation
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: kText16Bold_3,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
                width: 80,
                margin: EdgeInsets.only(left: 16.w),
                child: DropdownButton<String>(
                  value: _valueSort,
                  isExpanded: true,
                  icon: Image.asset(getIcon("sort-size.png")),
                  style: kText16Bold_3,
                  dropdownColor: yrColor1,
                  underline: Container(),
                  onChanged: (value) {
                    setState(() {
                      _valueSort = value!;
                    });
                  },
                  items: listSort.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: kText16Bold_3,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Container(
          height: 45.h,
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          padding: EdgeInsets.only(left: 12),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: yrColor3, borderRadius: BorderRadius.circular(10.h)),
          child: TextFormField(
            controller: _search,
            style: kText16_1,
            decoration: InputDecoration(
                hintText: "Tìm kiếm",
                hintStyle: kText16_1,
                focusedBorder: InputBorder.none,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, top: 3, right: 3, bottom: 3),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 38.h,
                      width: 38.h,
                      decoration: BoxDecoration(
                          color: yrColor1,
                          borderRadius: BorderRadius.circular(10.h)),
                      child: Icon(
                        Icons.search,
                        color: yrColor4,
                        size: 20.h,
                      ),
                    ),
                  ),
                )),
          ),
        )
      ],
    );
  }
}
