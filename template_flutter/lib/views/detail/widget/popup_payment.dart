import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:youreal/common/config/color_config.dart';
import 'package:youreal/common/config/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youreal/model/deal.dart';
import 'package:youreal/view_models/app_model.dart';
import 'package:youreal/views/detail/connect_investors.dart';

import '../../../routes/ui_pages.dart';

class PopupPayment extends StatefulWidget {
  final Deal deal;

  const PopupPayment({Key? key, required this.deal}) : super(key: key);

  @override
  _PopupPaymentState createState() => _PopupPaymentState();
}

class _PopupPaymentState extends State<PopupPayment> {
  int indexPayments = 0;
  FocusNode _focusNode = FocusNode();
  TextEditingController percent = TextEditingController();
  TextEditingController money = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppModel _appModel = Provider.of<AppModel>(context);
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Form(
        child: Container(
          height: _focusNode.hasFocus ? 560.h : 296.h,
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            children: [
              Container(
                height: 6.h,
                width: 148.w,
                margin: EdgeInsets.only(top: 14.h),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(15.h)),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Container(
                    width: 104.h,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "% tham gia đầu tư",
                            style: kText12_1,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: yrColor9,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.w)),
                          ),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            controller: percent,
                            validator: (value) {
                              return value!.isEmpty ? "*Yêu cầu nhập %" : null;
                            },
                            onChanged: (value){
                              double a = double.parse(value);
                              double b = (a*3210000000.0)/100;
                              setState(() {
                                money.text = b.toString();
                              });
                            },
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 5),
                              suffixIcon: Container(
                                  width: 15.w,
                                  padding: EdgeInsets.only(right: 5.w),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "%",
                                    style: kText20_15,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 17.w,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Thành tiền",
                            style: kText12_1,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: yrColor9,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.w)),
                          ),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            enabled: false,
                            controller: money,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 5),
                              suffixIcon: Container(
                                  width: 30.w,
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: Text(
                                    "VNĐ",
                                    style: kText12_15,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hình thức thanh toán",
                  style: kText12_1,
                ),
              ),
              InkWell(
                onTap: () {
                  _focusNode.unfocus();
                  setState(() {
                    indexPayments = 1;
                  });
                },
                child: Container(
                  height: 34,
                  child: Row(
                    children: [
                      Container(
                        height: 26.h,
                        width: 26.h,
                        margin: EdgeInsets.only(right: 10.w),
                        decoration: BoxDecoration(
                            color: indexPayments == 1 ? yrColor14 : yrColor3,
                            border: Border.all(color: yrColor1, width: 2),
                            shape: BoxShape.circle),
                      ),
                      Text(
                        "Thanh toán trực tiếp",
                        style: kText12_1,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _focusNode.unfocus();
                  setState(() {
                    indexPayments = 2;
                  });
                },
                child: Container(
                  height: 34,
                  child: Row(
                    children: [
                      Container(
                        height: 26.h,
                        width: 26.h,
                        margin: EdgeInsets.only(right: 10.w),
                        decoration: BoxDecoration(
                            color: indexPayments == 2 ? yrColor14 : yrColor3,
                            border: Border.all(color: yrColor1, width: 2),
                            shape: BoxShape.circle),
                      ),
                      Text(
                        "Chuyển khoản ngân hàng",
                        style: kText12_1,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 48.h,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _focusNode.unfocus();
                        setState(() {
                          _appModel.hideNavBar = false;
                        });
                        // _appModel.currentAction = PageAction(
                        //     state: PageState.addWidget,
                        //     widget: ConnectInvestors(
                        //       deal: widget.deal,
                        //       startTimeWaiting: DateTime.parse("2021-06-03 14:26:41.783608"),
                        //     ),
                        //     page: DetailPage1Config);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConnectInvestors(
                              deal: widget.deal,
                              startTimeWaiting:
                                  DateTime.parse("2021-06-03 14:26:41.783608"),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 48.h,
                        width: 260.w,
                        decoration: BoxDecoration(
                          color: yrColor1,
                          borderRadius: BorderRadius.all(Radius.circular(30.h)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "GỬI YÊU CẦU ĐẾN ADMIN",
                          style: kText16_3,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            _focusNode.unfocus();
                            setState(() {
                              _appModel.hideNavBar = false;
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 48.h,
                            width: 60.w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.clear,
                                  color: yrColor5,
                                  size: 20.h,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "HỦY",
                                  style: kText16_5,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              if (_focusNode.hasFocus)
                SizedBox(
                  height: 100,
                )
            ],
          ),
        ),
      ),
    );
  }
}
