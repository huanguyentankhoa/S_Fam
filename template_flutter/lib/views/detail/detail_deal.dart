import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/model/deal.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/views/detail/widget/map_widget.dart';
import 'package:youreal/views/detail/widget/popup_payment.dart';
import 'package:youreal/views/detail/widget/popup_share.dart';

class DetailDeal extends StatefulWidget {
  final Deal deal;

  const DetailDeal({Key? key, required this.deal}) : super(key: key);

  @override
  _DetailDealState createState() => _DetailDealState();
}

class _DetailDealState extends State<DetailDeal> {
  int _currentImage = 0;
  List<Widget> _imageSliders = [];

  String investmentPlanValue = "5 năm";
  List<String> investmentPlanList = ["5 năm", "10 năm", "15 năm"];
  // Completer<GoogleMapController> _controller = Completer();
  //
  // var _position = LatLng(10.8468936, 106.6408852);
  // static final CameraPosition _kGooglePosition = CameraPosition(
  //   target: LatLng(10.8468936, 106.6408852),
  //   zoom: 14.5,
  // );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadImageSliders();
  }

  _loadImageSliders() {
    widget.deal.images.forEach((_img) {
      _imageSliders.add(
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: getImage(
            _img,
            fit: BoxFit.fill,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    AppModel _appModel = Provider.of<AppModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: yrColor1,
        appBar: AppBar(
          backgroundColor: yrColor1,
          elevation: 0,
          centerTitle: true,
          leadingWidth: 80.w,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Icon(
                  Icons.chevron_left,
                  color: yrColor4,
                  size: 38.w,
                ),
                Container(
                    margin: EdgeInsets.only(left: 28.w),
                    child: Text(
                      "Back",
                      style: kText18_3,
                    ))
              ],
            ),
          ),
          title: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 5),
            child: Text(
              "Chi tiết deal",
              style: kText18Bold_3,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                _appModel.hideNavBar = true;
                showMaterialModalBottomSheet(
                  context: context,
                  backgroundColor: yrColor3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.h),
                    topLeft: Radius.circular(15.h),
                  )),
                  builder: (context) => PopupShare(),
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 14.w),
                child: Icon(
                  Icons.ios_share,
                  color: yrColor4,
                  size: 25.w,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                Column(children: [
                  Container(
                    child: CarouselSlider(
                      items: _imageSliders,
                      options: CarouselOptions(
                          autoPlay: true,
                          height: 323.h,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentImage = index;
                            });
                          }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.deal.images.map((url) {
                      int index = widget.deal.images.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentImage == index ? yrColor14 : yrColor3,
                        ),
                      );
                    }).toList(),
                  ),
                ]),
                SizedBox(
                  height: 12.h,
                ),

                ///header
                Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "Ngôi nhà của A",
                        style: kText20Bold_4,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            child: Icon(
                              Icons.my_location_outlined,
                              color: yrColor3,
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Container(
                            child: Text(
                              "43 Ngô Gia Tư, P.4, Q.10, TP.Hồ Chí Minh",
                              style: kText12_3,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Cách xa 1.2 KM",
                                style: kText12_3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),

                ///Vị trí
                Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "Vị trí",
                        style: kText14Bold_4,
                      ),
                    ),
                    Container(
                      height: 177.h,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 5.h),
                      child:MapWidget(),
                    ),
                  ],
                ),

                SizedBox(
                  height: 18.h,
                ),

                ///Tổng quan
                Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "TỔNG QUAN",
                        style: kText14Bold_4,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    _element1Build("Nhà đẹp mới sửa xong xách vali vào là ở."),
                    _element1Build(
                        "Vị trí gần chợ 200m, gần đại học kinh tế, y dược."),
                    _element1Build("Sổ hồng riêng."),
                  ],
                ),
                SizedBox(
                  height: 18.h,
                ),

                ///Phần đất
                Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "PHẦN ĐẤT",
                        style: kText14Bold_4,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    _element2Build("Diện tích sàn sử dụng: ", "100m²"),
                    _element2Build("Diện tích không thuộc lộ giới: ", "80m²"),
                    _element2Build("Diện tích thuộc lộ giới: ", "10m²"),
                    _element2Build("Diện tích khuôn viên: ", "10m²"),
                  ],
                ),
                SizedBox(
                  height: 18.h,
                ),

                Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "GIÁ TRỊ BĐS",
                        style: kText14Bold_4,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 18.w),
                      child: Text(
                        "3,210,000,000 VNĐ",
                        style: kText20Bold_13,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),

                ///Giá trị bđs
                Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "GIÁ TRỊ BĐS",
                        style: kText14Bold_4,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    _element3Build("Liên quan đến BĐS: ", "Sổ đỏ"),
                    _element3Build("Liên quan đến chủ BĐS: ", "Sổ hộ khẩu"),
                  ],
                ),

                SizedBox(
                  height: 24.h,
                ),

                ///CÁC YẾU TỐ THUẬN LỢI/BẤT LỢI
                Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "CÁC YẾU TỐ THUẬN LỢI/BẤT LỢI",
                        style: kText14Bold_4,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Stack(
                      children: [
                        Column(
                          children: [
                            _element4Build("Pháp lý"),
                            _element4Build("Quy mô"),
                            _element4Build("Kích thước"),
                            _element4Build("Hình dạng"),
                            _element4Build("Giao thông"),
                            _element4Build("Lợi thế kinh doanh"),
                            _element4Build("Môi trường an ninh"),
                            _element4Build("Các yếu tố khác"),
                          ],
                        ),
                        Container(
                          height: 50.h,
                          width: 172.w,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          margin: EdgeInsets.only(left: 170.w, top: 60.h),
                          color: yrColor15,
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.lock_outline,
                                  color: yrColor1,
                                  size: 20.h,
                                ),
                                Text(
                                  "Yêu cầu thẩm định",
                                  style: kText14_1,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),

                SizedBox(
                  height: 30.h,
                ),

                ///Kế hoạch đầu tư
                Container(
                  height: 142.h,
                  width: MediaQuery.of(context).size.width,
                  color: yrColor3,
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Kế hoạch đầu tư: ",
                            style: kText14Bold_2,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Container(
                            height: 25.h,
                            width: 80.w,
                            child: DropdownButton<String>(
                              value: investmentPlanValue,
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: yrColor2,
                                size: 20.h,
                              ),
                              style: kText14_2,
                              underline: Container(),
                              onChanged: (value) {
                                setState(() {
                                  investmentPlanValue = value!;
                                });
                              },
                              items: investmentPlanList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 40.w,
                        alignment: Alignment.topLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _element5Build("1 tháng: 53,34tr/tháng"),
                                  _element5Build("3 tháng: 160tr/tháng"),
                                  _element5Build("6 tháng: 320tr/tháng"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _element5Build("9 tháng: 426.67tr/tháng"),
                                  _element5Build("12 tháng: 640tr/tháng"),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: 24.h,
                ),

                Column(
                  children: [
                    Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: RichText(
                          text: TextSpan(
                              text: "Tổng tiền đầu tư ",
                              style: kText20Bold_4,
                              children: [
                                TextSpan(
                                  text: "3,210,000,000",
                                  style: kText20Bold_13,
                                )
                              ]),
                        )),
                    SizedBox(
                      height: 18.h,
                    ),
                    Container(
                      height: 18.h,
                      padding: EdgeInsets.only(left: 12.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.h)),
                      child: Stack(
                        children: [
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 80,
                            lineHeight: 20.h,
                            percent: 0.5,
                            backgroundColor: yrColor3,
                            progressColor: yrColor13,
                            linearStrokeCap: LinearStrokeCap.roundAll,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 24.w, top: 2.h),
                            child: Text(
                              "850,000,000",
                              style: kText12_1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 35.w, top: 2.h),
                      child: Text(
                        "2 người đầu tư",
                        style: kText12_3,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 12.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 15.w),
                        alignment: AlignmentDirectional.centerStart,
                        child: RichText(
                          text: TextSpan(
                            text: "Số tiền đầu tư nhỏ nhất",
                            style: kText18_3,
                          ),
                        )),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 15.w),
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        alignment: AlignmentDirectional.centerStart,
                        height: 24.h,
                        width: MediaQuery.of(context).size.width - 80,
                        color: Colors.white30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "200,000,000",
                              style: kText12_13,
                            ),
                            Text(
                              "VNĐ",
                              style: kText12_13,
                            ),
                          ],
                        )),
                  ],
                ),

                SizedBox(
                  height: 40.h,
                ),
                InkWell(
                  onTap: () async {
                    _appModel.hideNavBar = true;
                    await showMaterialModalBottomSheet(
                      context: context,
                      backgroundColor: yrColor3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.h),
                        topLeft: Radius.circular(15.h),
                      )),
                      builder: (context) => PopupPayment(
                        deal: widget.deal,
                      ),
                    );
                    _appModel.hideNavBar = false;
                  },
                  child: Container(
                    height: 42.h,
                    width: MediaQuery.of(context).size.width - 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: yrColor3,
                        borderRadius: BorderRadius.circular(8.h)),
                    child: Text(
                      "THAM GIA",
                      style: kText16Bold_1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Tổng quan
  Widget _element1Build(title) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Container(
            height: 2,
            width: 2,
            decoration: BoxDecoration(shape: BoxShape.circle, color: yrColor3),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: kText14_4,
          ),
        ],
      ),
    );
  }

  ///Phần đất
  Widget _element2Build(title1, title2) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Container(
            height: 2,
            width: 2,
          ),
          SizedBox(
            width: 5,
          ),
          RichText(
            text: TextSpan(text: title1, style: kText14_4, children: [
              TextSpan(
                text: title2,
                style: kText14Bold_4,
              )
            ]),
          ),
        ],
      ),
    );
  }

  ///Giấy tờ liên quan
  Widget _element3Build(title1, title2) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 2,
                width: 2,
              ),
              SizedBox(
                width: 5,
              ),
              RichText(
                text: TextSpan(text: title1, style: kText14_4, children: [
                  TextSpan(
                    text: title2,
                    style: kText14Bold_4,
                  )
                ]),
              ),
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 40.h,
              width: 115.w,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              margin: EdgeInsets.only(left: 20.w),
              decoration: BoxDecoration(
                color: yrColor6,
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.lock_outline,
                    color: yrColor1,
                    size: 20.h,
                  ),
                  Text(
                    "Hình ảnh",
                    style: kText14_1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///Các yếu tố thuận lợi/bất lợi
  Widget _element4Build(name) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      margin: EdgeInsets.only(bottom: 8.w),
      child: Row(
        children: [
          Container(
            height: 2,
            width: 2,
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 35,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      name,
                      style: kText14_4,
                    )),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          color: yrColor15,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Container(
                          height: 8,
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 1,
                            width: 190,
                            color: yrColor15,
                          ),
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
    );
  }

  Widget _element5Build(title) {
    return Container(
        margin: EdgeInsets.only(bottom: 8.h),
        child: Text(
          title,
          style: kText14_2,
        ));
  }
}
