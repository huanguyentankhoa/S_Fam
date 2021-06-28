import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/flutter_template.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/common/tools.dart';
import 'package:youreal/routes/ui_pages.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/views/create_deal/create_deal_2.dart';

class CreateDealScreen extends StatefulWidget {
  const CreateDealScreen({Key? key}) : super(key: key);

  @override
  _CreateDealScreenState createState() => _CreateDealScreenState();
}

class _CreateDealScreenState extends State<CreateDealScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  var _position = LatLng(10.8468936, 106.6408852);
  static final CameraPosition _kGooglePosition = CameraPosition(
    target: LatLng(10.8468936, 106.6408852),
    zoom: 14.5,
  );
  int kindOfReal = 1;

  String _valueProvince = "Tp.Hồ Chí Minh";
  List<String> listProvince = ["Tp.Hồ Chí Minh", "Đà Nẵng", "Hà Nội", "Gia Lai"];
  String _valueCity = "Tp.Thủ Đức";
  List<String> listCity = ["Tp.Thủ Đức", "Tp.Hồ Chí Minh", "Tp.Đà Nẵng", "Hà Nội"];
  String _valueDistrict = "Quận 2";
  List<String> listDistrict = ["Quận 2", "Quận 3", "Quận 1", "Quận 4"];
  String _valueWard = "P.An Lợi Đông";
  List<String> listWard = ["P.An Lợi Đông", "P. Hiệp Bình", "P. Hiệp Bình Chánh", "P. An Phú Đông"];
  TextEditingController _addressDetail =
      TextEditingController(text: "125 Nguyễn Cơ Thạch");

  bool hasFloor = false;
  double minValue = 50;
  double maxValue = 420;
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    return Scaffold(
      key: _key,
      backgroundColor: yrColor1,
      appBar: AppBar(
        backgroundColor: yrColor1,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Khởi tạo Deal",
          style: kText18Bold_3,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              Container(
                height: 35.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Loại bất động sản",
                          style: kText14Bold_4,
                        ),
                        Text(
                          "Chọn loại bất động sản",
                          style: kText12_4,
                        )
                      ],
                    ),
                    InkWell(
                      onTap:_nextPage,
                      child: Container(
                        height: 35.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                            color: yrColor4,
                            borderRadius: BorderRadius.circular(8.h)),
                        alignment: Alignment.center,
                        child: Text(
                          "Upload hình",
                          style: kText14Bold_1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 247.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          kindOfReal = 1;
                        });
                      },
                      child: Container(
                        height: 247.h,
                        width: 192.w,
                        decoration: BoxDecoration(
                          color: yrColor18,
                          borderRadius: BorderRadius.circular(24.w),
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 110.h,
                                    width: 110.h,
                                    child: getImage(
                                      "House.png",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  Text(
                                    "Nhà riêng",
                                    style: kText14Bold_2,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 48.h,
                              width: 48.h,
                              decoration: BoxDecoration(
                                color: yrColor4,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24.h),
                                  bottomLeft: Radius.circular(12.h),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Container(
                                height: 24.h,
                                width: 24.h,
                                decoration: BoxDecoration(
                                    color:
                                        kindOfReal == 1 ? yrColor1 : yrColor4,
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: yrColor1, width: 2)),
                                child: kindOfReal == 1
                                    ? SvgPicture.asset(getIcon("check.svg"),color: yrColor4,)
                                    : Container(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          kindOfReal = 2;
                        });
                      },
                      child: Container(
                        height: 247.h,
                        width: 192.w,
                        decoration: BoxDecoration(
                          color: yrColor18,
                          borderRadius: BorderRadius.circular(24.w),
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 110.h,
                                    width: 110.h,
                                    child: getImage(
                                      "Flat.png",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  Text(
                                    "Chung cư",
                                    style: kText14Bold_2,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 48.h,
                              width: 48.h,
                              decoration: BoxDecoration(
                                color: yrColor4,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24.h),
                                  bottomLeft: Radius.circular(12.h),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Container(
                                height: 24.h,
                                width: 24.h,
                                decoration: BoxDecoration(
                                    color:
                                        kindOfReal == 2 ? yrColor1 : yrColor4,
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: yrColor1, width: 2)),
                                child: kindOfReal == 2
                                    ? SvgPicture.asset(getIcon("check.svg"),color: yrColor4,)
                                    : Container(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              ///Địa chỉ
              Container(
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Địa chỉ",
                          style: kText14Bold_4,
                        )),
                    Container(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Thành phố/Tỉnh",
                                  style: kText12_4,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 130.h,
                                child: DropdownButton<String>(
                                  value: _valueProvince,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: yrColor8,
                                    ),
                                  ),
                                  style: kText14_4,
                                  dropdownColor: yrColor1,
                                  underline: Container(),
                                  onChanged: (value) {
                                    setState(() {
                                      _valueProvince = value!;
                                    });
                                  },
                                  items: listProvince
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: kText14_4,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Thành phố",
                                  style: kText12_4,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 130.h,
                                child: DropdownButton<String>(
                                  value: _valueCity,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: yrColor8,
                                    ),
                                  ),
                                  style: kText14_4,
                                  dropdownColor: yrColor1,
                                  underline: Container(),
                                  onChanged: (value) {
                                    setState(() {
                                      _valueCity = value!;
                                    });
                                  },
                                  items: listCity.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: kText14_4,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20.w,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Quận/Phường",
                                  style: kText12_4,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 130.h,
                                child: DropdownButton<String>(
                                  value: _valueDistrict,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: yrColor8,
                                    ),
                                  ),
                                  style: kText14_4,
                                  dropdownColor: yrColor1,
                                  underline: Container(),
                                  onChanged: (value) {
                                    setState(() {
                                      _valueDistrict = value!;
                                    });
                                  },
                                  items: listDistrict
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: kText14_4,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Phường/Xã",
                                  style: kText12_4,
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 130.h,
                                child: DropdownButton<String>(
                                  value: _valueWard,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: yrColor8,
                                    ),
                                  ),
                                  style: kText14_4,
                                  dropdownColor: yrColor1,
                                  underline: Container(),
                                  onChanged: (value) {
                                    setState(() {
                                      _valueWard = value!;
                                    });
                                  },
                                  items: listWard.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: kText14_4,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20.w,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Địa chỉ chi tiết",
                              style: kText12_4,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: yrColor4.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(10.h)),
                            child: TextFormField(
                              controller: _addressDetail,
                              style: kText14_4,
                              decoration: InputDecoration(
                                  labelStyle: kText14_4,
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 8.w, bottom: 15.h)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 20.h,
              ),

              ///Vị trí
              Container(
                child: Column(
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
                      child: GoogleMap(
                        mapType: MapType.normal,
                        zoomControlsEnabled: false,
                        onTap: (LatLng _latLng) async {},
                        markers: Set.of([
                          Marker(
                            markerId: MarkerId("home"),
                            draggable: true,
                            position: _position,
                            zIndex: 2,
                            flat: true,
                            anchor: Offset(0.5, 0.5),
                          ),
                        ]),
                        initialCameraPosition: _kGooglePosition,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              ///Diện tích
              Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Diện tích",
                        style: kText14Bold_4,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Row(
                        children: [
                          Container(
                              height: 20.h,
                              padding: EdgeInsets.only(top: 6),
                              child: Text(
                                "Tổng diện tích: ",
                                style: kText12_4,
                              )),
                          Container(
                            width: 50.w,
                            height: 20.h,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: kText12_4,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: yrColor4),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              height: 20.h,
                              padding: EdgeInsets.only(top: 6),
                              child: Text(
                                "m² (mét vuông)",
                                style: kText12_4,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                  height: 20.h,
                                  padding: EdgeInsets.only(top: 6),
                                  child: Text(
                                    "Chiều dài: ",
                                    style: kText12_4,
                                  )),
                              Container(
                                width: 50.w,
                                height: 20.h,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  style: kText12_4,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: yrColor4),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  height: 20.h,
                                  padding: EdgeInsets.only(top: 6),
                                  child: Text(
                                    "m (mét)",
                                    style: kText12_4,
                                  )),
                            ],
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Row(
                            children: [
                              Container(
                                  height: 20.h,
                                  padding: EdgeInsets.only(top: 6),
                                  child: Text(
                                    "Chiều rộng: ",
                                    style: kText12_4,
                                  )),
                              Container(
                                width: 50.w,
                                height: 20.h,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  style: kText12_4,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: yrColor4),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  height: 20.h,
                                  padding: EdgeInsets.only(top: 6),
                                  child: Text(
                                    "m (mét)",
                                    style: kText12_4,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Row(
                        children: [
                          Container(
                            height: 20.h,
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "Tầng/lầu: ",
                              style: kText12_4,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                hasFloor = false;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 15.h,
                                  width: 15.h,
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                      color: yrColor4, shape: BoxShape.circle),
                                  child: hasFloor
                                      ? Container()
                                      : SvgPicture.asset(
                                          getIcon("check.svg"),
                                          color: yrColor1,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Text(
                                      "Không",
                                      style: kText12_4,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                hasFloor = true;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 15.h,
                                  width: 15.h,
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                      color: yrColor4, shape: BoxShape.circle),
                                  child: !hasFloor
                                      ? Container()
                                      : SvgPicture.asset(
                                          getIcon("check.svg"),
                                          color: yrColor1,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Text(
                                      "Có",
                                      style: kText12_4,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          Row(
                            children: [
                              Container(
                                  height: 20.h,
                                  padding: EdgeInsets.only(top: 6),
                                  child: Text(
                                    "Số lầu: ",
                                    style: kText12_4,
                                  )),
                              Container(
                                width: 50.w,
                                height: 20.h,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  style: kText12_4,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    enabled: hasFloor,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: yrColor4),
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: yrColor4),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),

              ///Thời gian ký gửi
              Container(
                child: Row(
                  children: [
                    Container(
                        height: 25.h,
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Thời gian ký gửi ",
                          style: kText14Bold_4,
                        )),
                    Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 20.h,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: kText12_4,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: yrColor4),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            height: 20.h,
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "năm",
                              style: kText12_4,
                            )),
                      ],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 20.h,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: kText12_4,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: yrColor4),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            height: 20.h,
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "tháng",
                              style: kText12_4,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              ///Giá ký gửi
              Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Giá ký gửi",
                        style: kText14Bold_4,
                      ),
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
                      max: 500,
                      min: 0,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 40.h,
              ),
              InkWell(
                onTap:_nextPage,
                child: Container(
                  height: 48.h,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  decoration: BoxDecoration(
                      color: yrColor4,
                      borderRadius: BorderRadius.circular(15.h)),
                  alignment: Alignment.center,
                  child: Text(
                    "Tiếp tục",
                    style: kText16Bold_1,
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _nextPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: '/createDeal2'),
            builder: (context) => CreateDeal_2()));
  }
}
